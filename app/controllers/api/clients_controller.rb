module Api
  class ClientsController < ApplicationController
    before_action :set_client, only: %i[ show update destroy ]

    # GET /api/clients
    def index
      render json: Client.all
    end

    # GET /api/clients/1
    def show
      render json: @client.to_json(include: :wallets)
    end

    # POST /api/clients
    def create
      client = Client.new(client_params)

      if client.save
        render json: client, status: :created
      else
        render json: client.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/clients/1
    def update
      if @client.update(client_params)
        render json: @client
      else
        render json: @client.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/clients/1
    def destroy
      @client.destroy!
    end

    private

    def client_params
      params.require(:client).permit(:name)
    end

    def set_client
      @client = Client.find(params[:id])
    end
  end
end
