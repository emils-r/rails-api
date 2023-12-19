module Api
  class TransferController < ApplicationController
    def transfer_funds
      transfer = Transfer.new(transfer_params)

      error_message = validate_transfer_data(transfer)

      if error_message
        render json: { error: error_message }, status: :bad_request
      end

      if transfer.save
        TransferFundsJob.perform_later transfer

        render json: transfer, status: :created
      else
        render json: transfer.errors, status: :unprocessable_entity
      end
    end

    private

      def transfer_params
        params.require(:transfer).permit(:wallet_from, :wallet_to, :amount, :currency)
      end

      def validate_transfer_data(transfer)
        wallet_from = Wallet.find_by(id: params[:wallet_from], is_active: true)

        if !wallet_from
          return 'From wallet not found'
        end

        wallet_to = Wallet.find_by(id: params[:wallet_to], is_active: true)

        if !wallet_to
          return 'To wallet not found'
        end

        if params(:amount) <= 0
          return 'Invalid amount, must be more than 0'
        end

        if wallet_from.currency != transfer.currency && wallet_to.currency != transfer.currency
          return 'Transfer currency must be the same as at least one of wallets'
        end
      end
  end
end
