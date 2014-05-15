class TopicsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_and_contest, except: [:topic_params]

  def index
    @topics = @forum.topics.order(id: :desc)
  end

  def show
    @topic = @forum.topics.find(params[:id])
    @comments = @topic.comments.order(id: :asc)
  end

  def create
    @topic = @forum.topics.build(topic_params)
    @topic.account = current_account
    @topic.save
    flash[:notice] = "Successfully created topic."
    redirect_to contest_category_contest_forum_topic_path(@contest_category, @contest, @topic)
  end

  def destroy
    @topic = @forum.topics.find(params[:id])
    if @forum.topics.destroy @topic
      flash[:notice] = "Successfully deleted topic."
      redirect_to contest_category_contest_forum_topics_path(@contest_category, @contest)
    end
  end

  def topic_params
    params[:topic].permit(:title, :content)
  end

  private

  def get_category_and_contest
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
    @forum = @contest.forum
  end
end
