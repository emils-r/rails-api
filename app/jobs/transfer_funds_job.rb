class TransferFundsJob < ApplicationJob
  queue_as :default

  EXCHANGE_API_KEY = ENV["EXCHANGE_API_KEY"]
  EXCHANGE_API_LINK = "https://api.freecurrencyapi.com/v1/latest?apikey="

  def perform(transfer)

    # TODO:
    # - get exchange rate
    # - calculate amounts
    # - update wallet amounts
    # - update is_done transfer property
    #
  end
end
