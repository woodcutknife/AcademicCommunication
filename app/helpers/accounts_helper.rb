module AccountsHelper
  def account_display_fields
    [:email, :current_sign_in_at, :sign_in_count, :created_at]
  end
end
