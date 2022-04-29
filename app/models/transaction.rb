require 'csv'
require 'gl_account'

class Transaction < ApplicationRecord
  belongs_to :gl_account

  def self.import(file)
    CSV.foreach(file) do |row|
      date, amount, description = row
      transaction = Transaction.create(date: date, amount: amount, description: description, gl_account_id: 1)
    end
  end

  # def self.to_csv
  #   attributes = %w{id date amount description gl_account}

  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #     all.each do |transaction|
  #       number = GlAccount.find(transaction.gl_account_id).number.to_s
  #       name = GlAccount.find(transaction.gl_account_id).name.to_s
  #       gl_account = number + ": " + name
  #       csv << [transaction.date.to_s, transaction.amount.to_s, transaction.description.to_s, gl_account]
  #     end
  #   end
  # end

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
