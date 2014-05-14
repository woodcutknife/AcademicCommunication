class ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest

  def new
    @product = @contest.products.build
    @form_formation = @contest.form_formations.where(resource: 'product').first
  end

  def create
    @product = @contest.products.create
    @form_formation = @contest.form_formations.where(resource: 'product').first
    @form = @product.create_form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.build(term_formation: tf)
      if tf.type == 'StringTermFormation'
        t.string_value = params[tf.name.to_sym]
      end
      t.save
    end
    if current_account.role?(:user)
      @profile = @product.profiles.create(account: current_account)
      @form_formation = @contest.form_formations.where(resource: 'profile').first
      @form = @profile.create_form
      @form_formation.term_formations.each do |tf|
        t = @form.terms.build(term_formation: tf)
        if tf.type == 'StringTermFormation'
          t.string_value = current_account.send(tf.name.to_sym)
        end
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
      if tf.type == 'StringTermFormation'
        t.string_value = params[tf.name.to_sym]
      end
      t.save
    end
    redirect_to contest_category_contest_product_path(@contest_category, @contest, @product)
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
  end
end
