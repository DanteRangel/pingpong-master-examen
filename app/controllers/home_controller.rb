class HomeController < ApplicationController
  def index
    @users = User.order(rating: :desc)
  end

  def history
  end

  def log
  end
end
