class TransferFundsJob < ApplicationJob
  queue_as :default

  def perform(transfer)
    # TODO:
    # - get exchange rate
    # - calculate amounts
    # - update wallet amounts
    # - update is_done transfer property
  end
end
