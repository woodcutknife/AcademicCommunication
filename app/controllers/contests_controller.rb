class ContestsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category, except: [:contest_params]

  def index
    @contests = @contest_category.contests.order(id: :desc)
  end

  def show
    @contest = @contest_category.contests.find(params[:id])
    @pages = @contest.pages.where(visible: true).order(z_index: :desc)
  end

  def new
    @contest = @contest_category.contests.build
  end

  def create
    if @contest = @contest_category.contests.create(contest_params)
      @contest.form_formations.create(resource: 'product')
      @contest.form_formations.create(resource: 'profile')
      @contest.form_formations.create(resource: 'result')
      flash[:notice] = "Successfully created contest."
      redirect_to contest_category_contests_path(@contest_category)
    else
      render action: :new
    end
  end

  def edit
    @contest = @contest_category.contests.find(params[:id])
  end

  def update
    @contest = @contest_category.contests.find(params[:id])
    if @contest.update(contest_params)
      flash[:notice] = "Successfully updated contest."
      redirect_to contest_category_contests_path(@contest_category)
    else
      render action: :edit
    end
  end

  def destroy
    @contest = @contest_category.contests.find(params[:id])
    if @contest_category.contests.destroy @contest
      flash[:notice] = "Successfully deleted contest."
      redirect_to contest_category_contests_path(@contest_category)
    end
  end

  def destroy_multiple
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
    params[:contest].permit(:name, :upload)
  end

  private

  def get_category
    @contest_category = ContestCategory.find(params[:contest_category_id])
  end
end
