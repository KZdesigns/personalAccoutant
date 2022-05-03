require 'csv'
require 'gl_account'

class Transaction < ApplicationRecord
  belongs_to :gl_account

  def self.import(file)
    CSV.foreach(file) do |row|
      date, amount, splat, blank, description = row
      if(amount.to_f < 0)
        amount = amount.to_f * -1
      end
      transaction = Transaction.create(date: date, amount: amount, description: description, gl_account_id: 1)
    end
  end

  def self.generateBalance(gl_account, transactions)
    amount = 0
    transactions.each do |transaction|
      if gl_account.id == transaction.gl_account_id
        amount += transaction.amount
      end
    end
    return amount
  end

  def self.incomeTotal(transactions)
    totalIncome = 0
    transactions.each do |transaction|
      if transaction.gl_account.gl_type == "income"
        totalIncome += transaction.amount
      end
    end

    return totalIncome
  end

  def self.expenseTotal(transactions)
    totalExpense = 0
    transactions.each do |transaction|
      if transaction.gl_account.gl_type == "expense"
        totalExpense += transaction.amount
      end
    end

    return totalExpense
  end

end
