class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :work_experiences, dependent: :destroy
  has_many :connections, dependent: :destroy

  PROFILE_TITLE = [
    "Sr RoR Developer",
    "Jr RoR Developer",
    "RoR Developer",
    "Full Stack RoR Developer",
    "Jr Full Stack Developer",
    "Sr Full Stack Developer"
  ].freeze

  def name
    "#{first_name} #{last_name}"
  end

  def address
    "#{city}, #{state}, #{country}, #{pincode}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["about", "city", "contact_no", "country", "created_at", "current_sign_in_at", "current_sign_in_ip", "dob", "email", "encrypted_password", "first_name", "id", "last_name", "last_sign_in_at", "last_sign_in_ip", "pincode", "profile_title", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "state", "street_address", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def my_connection(user)
    Connection.where("(user_id = ? AND connected_user_id = ?) OR (user_id = ? AND connected_user_id = ?)", user.id, id, id, user.id)
  end

  def checked_if_already_connected?(current_user, user)
    self != user && !my_connection(user).present?
  end

  def mutual_connected_ids(user)
    self.connected_user_ids.intersection(user.connected_user_ids)
  end
end
