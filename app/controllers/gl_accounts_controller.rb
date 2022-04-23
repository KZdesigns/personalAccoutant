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

    def show
        @gl_account = GlAccount.find(params[:id])
    end

    def update
        @gl_account = GlAccount.find(params[:id])

        if @gl_account.update(account_params)
            redirect_to action: "index"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @gl_account = GlAccount.find(params[:id])
        @gl_account.destroy
    
        redirect_to gl_accounts_path, status: :see_other
      end
    
    private 
    def account_params
        params.require(:gl_account).permit(:name, :number, :gl_type)
    end
end
