class TrxnAmountUpdate < ActiveRecord::Migration[7.0]
  def change
    change_column(:transactions, :amount, :decimal)
  end
end
