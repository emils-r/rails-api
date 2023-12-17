module Api
  class ClientsController < ApplicationController
    def index
      render json: Client.all
    end

    def create
      client = Client.new(client_params)

      if client.save
        render json: client, status: :created
      else
        render json: client.errors, status: :unprocessable_entity
      end
    end

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
