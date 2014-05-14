class Product < ActiveRecord::Base
  belongs_to :contest
  has_many :profiles, dependent: :destroy
  has_many :accounts, through: :profiles
  has_one :form, dependent: :destroy

  def attr(name)
    tf = self.contest.form_formations.where(resource: 'product').first.term_formations.where(name: name).first
    t = tf.terms.where(form: self.form).first
    if tf.type == 'StringTermFormation'
      t.string_value
    end
  end
end
