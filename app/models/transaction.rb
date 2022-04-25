require 'csv'

class Transaction < ApplicationRecord
  belongs_to :gl_account

  def self.import(file)
    CSV.foreach(file) do |row|
      date, amount, description = row
      transaction = Transaction.create(date: date, amount: amount, description: description, gl_account_id: 1)
    end
  end
end
