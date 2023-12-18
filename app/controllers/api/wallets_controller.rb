module Api
  class WalletsController < ApplicationController
    before_action :set_wallet, only: %i[ show update destroy ]

    # GET /api/wallets
    def index
      #  TODO: add check for active wallets (is_deleted = 0)
      render json: Wallet.all
    end

    # GET /api/wallets/1
    def show
      render json: @wallet
    end

    # POST /api/wallets
    def create
      wallet = Wallet.new(wallet_params)

      # TODO: add validation for unique wallet currency for each client

      if wallet.save
        render json: wallet, status: :created
      else
        render json: wallet.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/wallets/1
    def update
      if @wallet.update(wallet_params)
        render json: @wallet
      else
        render json: @wallet.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/wallets/1
    def destroy
      # TODO: implement soft delete (set is_deleted = 1)
      @wallet.destroy!
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
