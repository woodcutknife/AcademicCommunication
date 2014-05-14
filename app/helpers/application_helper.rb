module ApplicationHelper
  def label_tag_with_required_option(name, required)
    if required
      label_tag(name.to_sym, '<abbr title="required">*</abbr> '.html_safe + name.humanize)
    else
      label_tag(name.to_sym, name.humanize)
    end
  end
end
