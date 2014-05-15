class ResultsController < ApplicationController
  load_and_authorize_resource

  before_action :get_category_contest_product_and_result

  def show
  end

  def edit
    @form_formation = @contest.form_formations.where(resource: 'result').first
  end

  def update
    @form_formation = @contest.form_formations.where(resource: 'result').first
    @form = @result.form
    @form_formation.term_formations.each do |tf|
      t = @form.terms.where(term_formation: tf).first
      get_assignment_by_formation(t, tf).call params[tf.name.to_sym]
      t.save
    end
    redirect_to contest_category_contest_products_path(@contest_category, @contest)
  end

  private

  def get_category_contest_product_and_result
    @contest_category = ContestCategory.find(params[:contest_category_id])
    @contest = @contest_category.contests.find(params[:contest_id])
    @product = @contest.products.find(params[:product_id])
    @result = @product.results.find(params[:id])
  end
end
