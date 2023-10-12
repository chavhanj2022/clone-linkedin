class MembersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit_description, update_description, edit_profile, update_profile]
  def show
    @user = User.find(params[:id])
    @connections = Connection.where('user_id = ? OR connected_user_id = ?', params[:id], params[:id]).where(status: 'accepted')
  end

  def edit_description;  end

  def update_description
    respond_to do |format|
      if current_user.update(about: params[:user][:about])
        format.turbo_stream {render turbo_stream: turbo_stream.replace('member_description', partial: 'members/member_description', locals: {user: current_user})}
      end
    end
  end

  def edit_profile; end

  def update_profile
    respond_to do |format|
      if current_user.update(user_personal_info_params)
        format.turbo_stream {render turbo_stream: turbo_stream.replace('user_profile', partial: 'members/user_profile', locals: {user: current_user})}
      end
    end
  end

  private
  
  def user_personal_info_params
    params.require(:user).permit(:first_name, :last_name, :city, :state, :country, :pincode, :profile_title)
  end

end
