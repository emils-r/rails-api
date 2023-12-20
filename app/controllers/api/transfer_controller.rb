module Api
  class TransferController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    # POST /api/transfer
    def transfer_funds
      @transfer = Transfer.new(transfer_params)

      error_message = validate_transfer_data

      if error_message
        return render json: { error: error_message }, status: :bad_request
      end

      if @transfer.save
        perform_transfer

        render json: { message: 'Transfer successfully created' }, status: :created
      else
        render json: @transfer.errors, status: :unprocessable_entity
      end
    end

    # POST /api/transfer/exchange-rate for testing and checking exchange rates
    def exchange_rate
      api = ExchangeRateApi.new(params[:currency_from], params[:currency_to])

      if !api || !api.valid_data?
        return render json: { error: 'incorrect data, check currencies' }, status: :bad_request
      end

      exchange_rate = api.latest_exchange_rate

      render json: { rate: exchange_rate }
    end

    private

      def transfer_params
        params.require(:transfer).permit(:wallet_from, :wallet_to, :amount)
      end

      def validate_transfer_data
        @wallet_from = Wallet.find_by!(id: @transfer.wallet_from, is_active: true)
        @transfer.currency_from ||= @wallet_from.currency

        return 'Wallet has insufficient available balance' if !@wallet_from.valid_balance(@transfer.amount)

        @wallet_to = Wallet.find_by!(id: @transfer.wallet_to, is_active: true)
        @transfer.currency_to = @wallet_to.currency

        false
      end

      def perform_transfer
        if @transfer.currency_from != @transfer.currency_to
          # TODO: use Active Job to perform transfer logic in background task
          api = ExchangeRateApi.new(@transfer.currency_from, @transfer.currency_to)

          return render json: { error: 'invalid exchange API data' }, status: :bad_request if !api.valid_data

          exchange_rate = api.latest_exchange_rate
          exchanged_amount = @transfer.amount * exchange_rate

          @transfer.update(exchange_rate: exchange_rate)
          @wallet_from.update(balance: @wallet_from.balance - @transfer.amount)
          @wallet_to.update(balance: @wallet_to.balance + exchanged_amount)
          @transfer.update(is_done: true)
        else
          @wallet_from.update(balance: @wallet_from.balance - @transfer.amount)
          @wallet_to.update(balance: @wallet_to.balance + @transfer.amount)
          @transfer.update(is_done: true)
        end
      end

      def not_found(error)
        render json: { error: error }, status: :bad_request
      end
  end
end
