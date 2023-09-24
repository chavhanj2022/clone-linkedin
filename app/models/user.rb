class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

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
end
