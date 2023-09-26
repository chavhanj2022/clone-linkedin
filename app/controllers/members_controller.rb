class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit_description, update_description]
  def show
    @user = User.find(params[:id])
  end

  def edit_description;  end

  def update_description
    respond_to do |format|
      if current_user.update(about: params[:user][:about])
        format.turbo_stream {render turbo_stream: turbo_stream.replace('member_description', partial: 'members/member_description', locals: {user: current_user})}
      end
    end
  end

  def edit_profile
    
  end

  def update_profile
    respond_to do |format|
      if current_user.update(first_name: params[:user][:first_name], last_name: params[:user][:last_name], profile_title: params[:user][:profile_title], city: params[:user][:city], state: params[:user][:state], state: params[:user][:state], country: params[:user][:country], pincode: params[:user][:pincode])
        format.turbo_stream {render turbo_stream: turbo_stream.replace('user_profile', partial: 'members/user_profile', locals: {user: current_user})}
      end
    end
  end
end
