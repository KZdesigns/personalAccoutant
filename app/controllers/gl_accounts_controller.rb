class GlAccountsController < ApplicationController
    def index
        @gl_accounts = GlAccount.all
    end

    def new
        @gl_account = GlAccount.new
    end

    def create
        @gl_account = GlAccount.new(account_params)

        if @gl_account.save
            redirect_to action: "index"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private 
    def account_params
        params.require(:gl_account).permit(:name, :number, :gl_type)
    end
end
