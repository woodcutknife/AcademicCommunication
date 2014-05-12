class ContestCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @contest_categories = ContestCategory.all
  end

  def show
    @contest_category = ContestCategory.find(params[:id])
  end

  def new
    @contest_category = ContestCategory.new
  end

  def create
    redirect_to root_path
    @contest_category = ContestCategory.new(contest_category_params)
    if @contest_category.save
      flash[:notice] = "Successfully created contest category."
      redirect_to @contest_category
    else
      render action: :new
    end
  end

  def edit
    @contest_category = ContestCategory.find(params[:id])
  end

  def update
    @contest_category = ContestCategory.find(params[:id])
    if @contest_category.update(contest_category_params)
      flash[:notice] = "Successfully updated contest category."
      redirect_to @contest_category
    else
      render action: :edit
    end
  end

  def destroy
    @contest_category = ContestCategory.find(params[:id])
    if @contest_category.destroy
      flash[:notice] = "Successfully deleted contest category."
      redirect_to contest_categories_path
    end
  end

  def destroy_multiple
    if params[:contest_category_ids]
      @contest_categories = ContestCategory.find(params[:contest_category_ids])
      @contest_categories.each do |contest_category|
        contest_category.destroy
      end
    end
    flash[:notice] = "Successfully deleted contest categories."
    redirect_to contest_categories_path
  end

  def contest_category_params
    params[:contest_category].permit(:name)
  end
end
