module Api
  class TransferController < ApplicationController
    def transfer_funds
      transfer = Transfer.new(transfer_params)

      # TODO:
      # - check if wallets exist
      # - check wallets currencies
      # - create background job

      TransferFundsJob.perform_later transfer

      if transfer.save
        render json: transfer, status: :created
      else
        render json: transfer.errors, status: :unprocessable_entity
      end
    end

    private

      def transfer_params
        params.require(:transfer).permit(:wallet_from, :wallet_to, :amount, :currency)
      end
  end
end
