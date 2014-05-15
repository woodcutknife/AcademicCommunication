class Result < ActiveRecord::Base
  belongs_to :judge, class_name: 'Account', foreign_key: 'account_id'
  belongs_to :task, class_name: 'Product', foreign_key: 'product_id'
  has_one :form, dependent: :destroy

  after_create :set_terms

  private

  def set_terms
    form_formation = self.task.contest.form_formations.where(resource: 'result').first
    form = self.create_form
    form_formation.term_formations.each do |tf|
      form.terms.create(term_formation: tf)
    end
  end
end
