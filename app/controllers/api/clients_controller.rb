module Api
  class ClientsController < ApplicationController
    # GET /api/clients
    def index
      render json: Client.all
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

    # DELETE /api/clients/1
    def destroy
      Client.find(params[:id]).destroy!

      head :no_content
    end

    private

    def client_params
      params.require(:client).permit(:name)
    end
  end
end
