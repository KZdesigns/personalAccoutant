require 'csv'
require 'gl_account'

class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all

        respond_to do |format|
            format.html
            format.csv { send_data @transactions.to_csv, filename:  "transaction-#{Date.today}"}
        end
    end

    def export
        @transactions = Transaction.all
    
        respond_to do |format|
          format.csv do
            response.headers['Content-Type'] = 'text/csv'
            response.headers['Content-Disposition'] = "attachment; filename=transaction-#{Date.today}.csv"
          end
        end
    end

    def new
        @transaction = Transaction.new
    end

    def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
            redirect_to transactions_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @transaction = Transaction.find(params[:id])
    end

    def transaction_params
        params.require(:transaction).permit(:date, :amount, :notes, :description, :gl_account_id)
    end

    def update
        @transaction = Transaction.find(params[:id])

        if @transaction.update(transaction_params)
            redirect_to action: "index"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
    
        redirect_to transactions_path, status: :see_other
    end

    def delete_all
        @transactions = Transaction.all
        @transactions.destroy_all
        redirect_to transactions_path, status: :see_other
    end

    def import
        Transaction.import(params[:file])
        redirect_to transactions_path, notice: "transactions imported."
    end

    def income
        @transactions = Transaction.all
        @amount = Transaction.incomeTotal(@transactions)
    end

    def expense
        @transactions = Transaction.all
        @amount = Transaction.expenseTotal(@transactions)
    end

    def income_statement
        @transactions = Transaction.all
        @incomeTotal = Transaction.incomeTotal(@transactions)
        @expenseTotal = Transaction.expenseTotal(@transactions)
        @netIncome = @incomeTotal - @expenseTotal
    end

    def gl_balance
        @transaction = Transaction.all
        @gl_accounts = GlAccount.all
        @balances = []
        @gl_accounts.each do |gl|
            amount = Transaction.generateBalance(gl, Transaction.all)
            @balances << "#{gl.number}," + ", " + ",#{gl.name}" + ': ' + ",#{amount}"
        end
    end

    private 
    def transaction_params
        params.require(:transaction).permit(:date, :amount, :description, :notes, :gl_account_id)
    end
end
