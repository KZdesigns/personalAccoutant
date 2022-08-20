require 'csv'
require 'gl_account'

class Api::V1::TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token #only for local dev need to learn how to pass auth token
    respond_to? :json

    def index
        @transactions = Transaction.all
        render json: @transactions
    end

    def show
        @transaction = Transaction.find(params[:id])
        render json: @transaction
    end

    def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
            render json: @transaction, status: :created, location: @transaction
        else
            render json: @transaction.errors, status: :unprocessable_entity
        end
    end

    def update
        transaction = Transaction.find(params[:id])
        transaction.update(transaction_params)
        render json: transaction
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        # not needed below for api
        # redirect_to transactions_path, status: :see_other
    end

    # def new
    #     @transaction = Transaction.new
    # end

    def export
        @transactions = Transaction.all

        respond_to do |format|
            format.html
            format.csv { send_file @transactions.to_csv, filename: "users-#{Date.today}.csv" }
          end
    end

    def delete_all
        @transactions = Transaction.all
        @transactions.destroy_all
        # redirect_to transactions_path, status: :see_other
    end

    def import
        Transaction.import(params[:file])
        @transaction = Transaction.all
        render json: @transactions
        # redirect_to transactions_path, notice: "transactions imported."
        # TODO: Ensure the import of CSV files works correctly.
        # https://mendywoly.medium.com/uploading-a-file-with-react-frontend-and-rails-api-backend-eb61939eedbc
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

    # def transactions_notes
    #     @transactions = Transaction.all
    # end
    private 
    def transaction_params
        params.require(:transaction).permit(:id, :date, :amount, :description, :notes, :gl_account_id)
    end
end