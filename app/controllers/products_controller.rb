class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest

  def index
    if current_account.role?(:super_admin) or current_account.role?(:contest_admin)
      @products = @contest.products
    elsif current_account.role?(:user)
      @products = current_account.products.where(contest: @contest)
    elsif current_account.role?(:judge)
      @products = current_account.tasks.where(contest: @contest)
    end
  end

  def new
    @product = @contest.products.build
    @form_formation = @contest.form_formations.where(resource: 'product').first
  end

  def create
    @product = @contest.products.create(product_params)
    @form_formation = @contest.form_formations.where(resource: 'product').first
    @form = @product.create_form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.build(term_formation: tf)
      get_assignment_by_formation(t, tf).call params[tf.name.to_sym]
      t.save
    end
    if current_account.role?(:user)
      @profile = @product.profiles.create(account: current_account)
      @form_formation = @contest.form_formations.where(resource: 'profile').first
      @form = @profile.create_form
      @form_formation.term_formations.each do |tf|
        t = @form.terms.build(term_formation: tf)
        get_assignment_by_formation(t, tf).call params[tf.name.to_sym]
        t.save
      end
    end
    redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
  end

  def edit
    @product = @contest.products.find(params[:id])
    @form_formation = @contest.form_formations.where(resource: 'product').first
  end

  def update
    @product = @contest.products.find(params[:id])
    @form_formation = @contest.form_formations.where(resource: 'product').first
    @form = @product.form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.where(term_formation: tf).first
      get_assignment_by_formation(t, tf).call params[tf.name.to_sym]
      t.save
    end
    if @product.update(product_params)
      redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
    else
      render action: :edit
    end
  end

  def destroy
    @product = @contest.products.find(params[:id])
    if @contest.products.destroy(@product)
      flash[:notice] = "Successfully deleted product."
      redirect_to contest_category_contest_products_path(@contest_category, @contest)
    end
  end

  def destroy_multiple
    if params[:product_ids]
      @products = @contest.products.find(params[:product_ids])
      @products.each do |product|
        @contest.products.destroy product
      end
    end
    flash[:notice] = "Successfully deleted products."
    redirect_to contest_category_contest_products_path(@contest_category, @contest)
  end

  def product_params
    params[:product].permit(:product_category_id, :judge_ids => [])
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
  end
end
