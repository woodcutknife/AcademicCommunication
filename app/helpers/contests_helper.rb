module ContestsHelper
  def contest_display_fields
    [:name]
  end

  ['product', 'profile'].each do |resource|
    define_method "contest_category_contest_#{resource}_form_formation_path" do |contest_category, contest|
      form_formation = contest.form_formations.where(resource: resource).first
      contest_category_contest_form_formation_path(contest_category, contest, form_formation)
    end
  end
end
