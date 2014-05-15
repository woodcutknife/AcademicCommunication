class Product < ActiveRecord::Base
  belongs_to :contest
  has_many :profiles, dependent: :destroy
  has_many :accounts, through: :profiles
  has_many :results, dependent: :destroy
  has_many :judges, through: :results, class_name: 'Account'
  has_one :form, dependent: :destroy
  belongs_to :product_category
  mount_uploader :attachment, AttachmentUploader
  before_save :set_slug

  def attr(name)
    tf = self.contest.form_formations.where(resource: 'product').first.term_formations.where(name: name).first
    t = tf.terms.where(form: self.form).first
    get_value_by_formation(t, tf)
  end

  private

  def set_slug
    if self.slug
      num = self.slug.split('-')[-1]
    else
      num = self.product_category.products.size
    end
    self.slug = "#{self.product_category.slug}-#{num}"
  end

  def get_value_by_formation(object, formation)
    type_name = formation.type.tableize.split('_')[0]
    if type_name == 'boolean'
      object.send("#{type_name}_value?".to_sym)
    else
      object.send("#{type_name}_value".to_sym)
    end
  end
end
