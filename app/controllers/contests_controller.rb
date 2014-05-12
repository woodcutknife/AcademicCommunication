class ContestsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contests = @contest_category.contests.order(id: :desc)
  end

  def show
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:id])
  end

  def new
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.build
  end

  def create
    @contest_category = ContestCategory.find(params[:contest_category_id])
    if @contest_category.contests.create(contest_params)
      flash[:notice] = "Successfully created contest."
      redirect_to [@contest_category, @contest]
    else
      render action: :new
    end
  end

  def edit
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:id])
  end

  def update
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:id])
    if @contest.update(contest_params)
      flash[:notice] = "Successfully updated contest."
      redirect_to [@contest_category, @contest]
    else
      render action: :edit
    end
  end

  def destroy
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:id])
    if @contest_category.contests.destroy @contest
      flash[:notice] = "Successfully deleted contest."
      redirect_to contest_category_contests_path(@contest_category)
    end
  end

  def destroy_multiple
    @contest_category = ContestCategory.find(params[:contest_category_id])
    if params[:contest_ids]
      @contests = @contest_category.contests.find(params[:contest_ids])
      @contests.each do |contest|
        @contest_category.contests.destroy contest
      end
    end
    flash[:notice] = "Successfully deleted contests."
    redirect_to contest_category_contests_path(@contest_category)
  end

  def contest_params
    params[:contest].permit(:name)
  end
end
