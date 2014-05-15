class Product < ActiveRecord::Base
  belongs_to :contest
  has_many :profiles, dependent: :destroy
  has_many :accounts, through: :profiles
  has_many :results, dependent: :destroy
  has_many :judges, through: :results, class_name: 'Account'
  has_one :form, dependent: :destroy
  belongs_to :product_category

  def attr(name)
    tf = self.contest.form_formations.where(resource: 'product').first.term_formations.where(name: name).first
    t = tf.terms.where(form: self.form).first
    get_value_by_formation(t, tf)
  end

  private

  def get_value_by_formation(object, formation)
    type_name = formation.type.tableize.split('_')[0]
    if type_name == 'boolean'
      object.send("#{type_name}_value?".to_sym)
    else
      object.send("#{type_name}_value".to_sym)
    end
  end
end
