class ProductCategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest, except: [:product_category_params]

  def index
    @product_categories = @contest.product_categories
  end

  def new
    @product_category = @contest.product_categories.build
  end

  def create
    @product_category = @contest.product_categories.build(product_category_params)
    if @product_category.save
      flash[:notice] = "Successfully created product category."
      redirect_to contest_category_contest_product_categories_path(@contest_category, @contest)
    else
      render action: :new
    end
  end

  def edit
    @product_category = @contest.product_categories.find(params[:id])
  end

  def update
    @product_category = @contest.product_categories.find(params[:id])
    if @product_category.update(product_category_params)
      flash[:notice] = "Successfully updated product category."
      redirect_to contest_category_contest_product_categories_path(@contest_category, @contest)
    else
      render action: :edit
    end
  end

  def destroy
    @product_category = @contest.product_categories.find(params[:id])
    if @contest.product_categories.destroy @product_category
      flash[:notice] = "Successfully deleted product category."
      redirect_to contest_category_contest_product_categories_path(@contest_category, @contest)
    end
  end

  def destroy_multiple
    if params[:product_category_ids]
      @product_categories = @contest.product_categories.find(params[:product_category_ids])
      @product_categories.each do |product_category|
        @contest.product_categories.destroy product_category
      end
    end
    flash[:notice] = "Successfully deleted product categories."
    redirect_to contest_category_contest_product_categories_path(@contest_category, @contest)
  end

  def product_category_params
    params[:product_category].permit(:name, :slug, :contest_id)
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
  end
end
