class WorkExperience < ApplicationRecord
  belongs_to :user

  #validations
  validates :company, :start_date, :employment_type, :job_title, :location_type, presence: true

    

end
