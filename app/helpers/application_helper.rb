module ApplicationHelper
  def label_tag_with_required_option(name, required)
    if required
      label_tag(name.to_sym, '<abbr title="required">*</abbr> '.html_safe + name.humanize)
    else
      label_tag(name.to_sym, name.humanize)
    end
  end

  ['product', 'profile', 'result'].each do |resource|
    define_method "contest_category_contest_#{resource}_form_formation_path" do |contest_category, contest|
      form_formation = contest.form_formations.where(resource: resource).first
      contest_category_contest_form_formation_path(contest_category, contest, form_formation)
    end
  end
end
