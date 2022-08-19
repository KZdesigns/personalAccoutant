class Api::V1::GlAccountsController < ApplicationController
    skip_before_action :verify_authenticity_token #only for local dev need to learn how to pass auth token
    respond_to? :json

    def index
        @gl_accounts = GlAccount.all
        render json: @gl_accounts
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
        @gl_account.destroy unless @gl_account.id == 1
    
        redirect_to gl_accounts_path, status: :see_other
      end
    
    private 
    def account_params
        params.require(:gl_account).permit(:name, :number, :gl_type)
    end
end
