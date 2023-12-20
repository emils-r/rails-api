class TransferExchangeJob < ApplicationJob
  include Sidekiq::Status::Worker

  queue_as :default

  def expiration
    @expiration ||= 60 * 60 * 24 * 30 # 30 days
  end

  def perform(transfer)
    wallet_from = Wallet.find(transfer.wallet_from)
    wallet_to = Wallet.find(transfer.wallet_to)
    api = ExchangeRateApi.new(transfer.currency_from, transfer.currency_to)

    return if !api.valid_data || !wallet_from || !wallet_to

    exchange_rate = api.latest_exchange_rate
    exchanged_amount = transfer.amount * exchange_rate

    transfer.update(exchange_rate: exchange_rate)
    wallet_from.update(balance: wallet_from.balance - transfer.amount)
    wallet_to.update(balance: wallet_to.balance + exchanged_amount)
    transfer.update(is_done: true)
  end
end
