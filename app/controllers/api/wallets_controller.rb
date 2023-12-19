module Api
  class WalletsController < ApplicationController
    before_action :set_wallet, only: %i[ show destroy ]

    # GET /api/wallets
    def index
      render json: Wallet.where(is_active: true)
    end

    # GET /api/wallets/1
    def show
      render json: @wallet
    end

    # POST /api/wallets
    def create
      wallet = Wallet.new(wallet_params)

      if wallet.save
        render json: wallet, status: :created
      else
        render json: wallet.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/wallets/1
    def destroy
      @wallet.update(is_active: false)

      head :no_content
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_wallet
        @wallet = Wallet.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def wallet_params
        params.require(:wallet).permit(:client_id, :currency, :balance)
      end
  end
end
