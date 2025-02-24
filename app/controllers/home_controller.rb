class HomeController < ApplicationController
  def index
    return unless user_signed_in?

    @total_users = User.count
  end
end
