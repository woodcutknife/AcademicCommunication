module AccountsHelper
  def display_fields
    [:email, :current_sign_in_at, :sign_in_count, :created_at]
  end
end
