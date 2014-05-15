class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest, except: [:post_params]

  def index
    @posts = @contest.posts.order(id: :desc)
  end

  def show
    @post = @contest.posts.find(params[:id])
  end

  def new
    @post = @contest.posts.build
  end

  def create
    if @post = @contest.posts.create(post_params)
      flash[:notice] = "Successfully created post."
      redirect_to [@contest_category, @contest, @post]
    else
      render action: :new
    end
  end

  def edit
    @post = @contest.posts.find(params[:id])
  end

  def update
    @post = @contest.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Successfully updated post."
      redirect_to [@contest_category, @contest, @post]
    else
      render action: :edit
    end
  end

  def destroy
    @post = @contest.posts.find(params[:id])
    if @contest.posts.destroy @post
      flash[:notice] = "Successfully deleted post."
      redirect_to contest_category_contest_posts_path(@contest_category, @contest)
    end
  end

  def post_params
    params[:post].permit(:title, :content)
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
  end
end
