class FormFormationsController < ApplicationController
  load_and_authorize_resource

  before_action :get_form_formation, except: [:form_formation_params]

  def show
  end

  def edit
  end

  def update
    if @form_formation.update(form_formation_params)
      flash[:notice] = "Successfully updated form formation."
      redirect_to contest_category_contest_form_formation_path(@contest_category, @contest, @form_formation)
    else
      render action: :edit
    end
  end

  def form_formation_params
    params[:form_formation].permit(:term_formations_attributes => [:id, :type, :name, :required, :choises, :single, :_destroy])
  end

  private

  def get_form_formation
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
    @form_formation = @contest.form_formations.find(params[:id])
  end
end
