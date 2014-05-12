class PagesController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest, except: [:page_params]

  def new
    @page = @contest.pages.build
  end

  def create
    if @page = @contest.pages.create(page_params)
      flash[:notice] = "Successfully created page."
      redirect_to contest_category_contest_path(@contest_category, @contest)
    else
      render action: :new
    end
  end

  def edit
    @page = @contest.pages.find(params[:id])
  end

  def update
    @page = @contest.pages.find(params[:id])
    if @page.update(page_params)
      flash[:notice] = "Successfully updated page."
      redirect_to contest_category_contest_path(@contest_category, @contest)
    else
      render action: :edit
    end
  end

  def page_params
    params[:page].permit(:title, :content, :default, :slug, :visible)
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
  end
end
