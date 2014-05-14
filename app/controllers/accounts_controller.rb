class AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @accounts = Account.all
  end

  def show
    @accounts = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      flash[:notice] = "Successfully updated account."
      redirect_to @account
    else
      render action: :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    if @account.destroy
      flash[:notice] = "Successfully deleted account."
      redirect_to accounts_path
    end
  end

  def destroy_multiple
    if params[:account_ids]
      @accounts = Account.find(params[:account_ids])
      @accounts.each do |account|
        account.destroy
      end
    end
    flash[:notice] = "Successfully deleted accounts."
    redirect_to accounts_path
  end

  def account_params
    params[:account].permit(:role_ids => [], :contest_category_ids => [])
  end
end
