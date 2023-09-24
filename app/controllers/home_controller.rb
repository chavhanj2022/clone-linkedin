class HomeController < ApplicationController
  def index
    @users = User.limit(10).order('created_at DESC')
  end
end
