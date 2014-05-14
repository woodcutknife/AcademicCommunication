class ProfilesController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_contest_and_product

  def new
    @profile = @product.profiles.build(account: current_account)
    @form_formation = @contest.form_formations.where(resource: 'profile').first
  end

  def create
    @profile = @product.profiles.create
    @form_formation = @contest.form_formations.where(resource: 'profile').first
    @form = @profile.create_form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.build(term_formation: tf)
      if tf.type == 'StringTermFormation'
        t.string_value = params[tf.name.to_sym]
        if tf.name == 'email'
          account = Account.where(email: params[:email]).first
          @profile.account = account unless account.nil?
        end
      end
      t.save
    end
    @profile.save
    redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
  end

  def edit
    @profile = @product.profiles.find(params[:id])
    @form_formation = @contest.form_formations.where(resource: 'profile').first
  end

  def update
    @profile = @product.profiles.find(params[:id])
    @form_formation = @contest.form_formations.where(resource: 'profile').first
    @form = @profile.form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.where(term_formation: tf).first
      if tf.type == 'StringTermFormation'
        t.string_value = params[tf.name.to_sym]
        if tf.name == 'email'
          account = Account.where(email: params[:email]).first
          @profile.account = account
        end
      end
      t.save
    end
    @profile.save
    redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
  end

  def destroy
    @profile = @product.profiles.find(params[:id])
    if @product.profiles.destroy(@profile)
      flash[:notice] = "Successfully deleted profile."
      redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
    end
  end

  private

  def get_category_contest_and_product
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
    @product = @contest.products.find(params[:product_id])
  end
end
