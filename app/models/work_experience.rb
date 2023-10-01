class WorkExperience < ApplicationRecord
  belongs_to :user

  #constants
  EMPLOYMENT_TYPE = ["Full-time", "Part-time", "Freelancer", "Self-Employed", "Trainee", "Internship"]
  LOCATION_TYPE = ["Remote", "On-Site", "Hybrid"]

  #validations
  validates :company, :start_date, :employment_type, :job_title, :location_type, presence: true

  #custom validations
  validate :work_experience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :currently_not_working_here

  #validation for specific wit custom error messages
  validates :employment_type, presence: true ,inclusion: { in: EMPLOYMENT_TYPE, message: 'is not valid employment type' }
  validates :location_type, presence: true ,inclusion: { in: LOCATION_TYPE, message: 'is not valid location type' }


  def work_experience_last_date
    if end_date.present? && currently_working_here
      errors.add(:end_date, 'must be blank if you are currently working in this company')
    end
  end

  def presence_of_end_date
    if end_date.nil? && !currently_working_here
      errors.add(:end_date, 'must be present if you are currently working in this company')
    end
  end

  def currently_not_working_here
    !currently_working_here
  end

  def end_date_greater_than_start_date
    return if end_date.nil?

    if end_date < start_date
      errors.add(:end_date, ' end date must be greater than start date')
    end
  end
end
