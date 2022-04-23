class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all
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

    private 
    def transaction_params
        params.require(:transaction).permit(:date, :amount, :description, :notes, :gl_account_id)
    end
end
