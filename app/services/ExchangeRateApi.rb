require 'httparty'

class ExchangeRateApi
  include HTTParty

  base_uri 'api.freecurrencyapi.com/v1'

  def initialize(currency_from, currency_to)
    @currency_from = currency_from
    @currency_to = currency_to
    @options = { query: { apikey: ENV["EXCHANGE_API_KEY"], base_currency: currency_from, currencies: currency_to }}
  end

  def latest_exchange_rate
    if valid_data
        response = self.class.get("/latest", @options)

        parsedData = JSON.parse(response.body)
        parsedData["data"]["#{@currency_to}"]
    end
  end

  def valid_data
    @currency_from.length == 3 && @currency_to.length == 3
  end
end
