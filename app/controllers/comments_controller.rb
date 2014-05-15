class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_contest_and_topic, except: [:comment_params]

  def create
    @comment = @topic.comments.build(comment_params)
    @comment.account = current_account
    @comment.save
    flash[:notice] = "Successfully created comment."
    redirect_to contest_category_contest_forum_topic_path(@contest_category, @contest, @topic)
  end

  def destroy
    @comment = @topic.comments.find(params[:id])
    if @topic.comments.destroy @comment
      flash[:notice] = "Successfully deleted comment."
      redirect_to contest_category_contest_forum_topic_path(@contest_category, @contest, @topic)
    end
  end

  def comment_params
    params[:comment].permit(:title, :content)
  end

  private

  def get_category_contest_and_topic
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
    @forum = @contest.forum
    @topic = @forum.topics.find(params[:topic_id])
  end
end
