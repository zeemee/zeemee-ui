# frozen_string_literal: true

module ApplicationHelper
  def current_user
    return nil unless session[:current_user]
    Struct.new(:user, *session[:current_user].keys)
          .new(:user, *session[:current_user].values)
          .freeze
  end
end
