class HomeController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).limit(10).order('created_at DESC')
  end
end
