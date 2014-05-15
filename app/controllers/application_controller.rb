class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end

  def get_assignment_by_formation(object, formation)
    type_name = formation.type.tableize.split('_')[0]
    lambda { |val| object.send("#{type_name}_value=".to_sym, val) unless val.nil? }
  end
end
