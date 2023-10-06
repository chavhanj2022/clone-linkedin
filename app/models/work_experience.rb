class WorkExperience < ApplicationRecord
  belongs_to :user

  # constants
  EMPLOYMENT_TYPE = %w[Full-time Part-time Freelancer Self-Employed Trainee Internship]
  LOCATION_TYPE = %w[Remote On-Site Hybrid]

  # validations
  validates :company, :start_date, :employment_type, :job_title, :location_type, presence: true

  # custom validations
  validate :work_experience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :currently_not_working_here

  # validation for specific wit custom error messages
  validates :employment_type, presence: true,
                              inclusion: { in: EMPLOYMENT_TYPE, message: 'is not valid employment type' }
  validates :location_type, presence: true, inclusion: { in: LOCATION_TYPE, message: 'is not valid location type' }

  def work_experience_last_date
    return unless end_date.present? && currently_working_here

    errors.add(:end_date, 'must be blank if you are currently working in this company')
  end

  def presence_of_end_date
    return unless end_date.nil? && !currently_working_here

    errors.add(:end_date, 'must be present if you are currently working in this company')
  end

  def currently_not_working_here
    !currently_working_here
  end

  def end_date_greater_than_start_date
    return if end_date.nil?

    return unless end_date < start_date

    errors.add(:end_date, ' end date must be greater than start date')
  end

  def company_with_employment_type
    "#{company} ( #{employment_type} )".strip
  end

  def job_location
    "#{location} ( #{location_type} )".strip
  end

  def job_duration
    months = if end_date.present?
               fetch_month_days(end_date)
             else
               fetch_month_days(Date.today)
             end

    result = months.divmod(12)

    duration = "#{result.first} #{result.first > 1 ? 'years' : 'year'} #{result.last} #{result.last > 1 ? 'months' : 'month'}"

    if currently_working_here
      "#{start_date.strftime('%b %Y')} - Present ( #{duration})"
    else 
      "#{start_date.strftime('%b %Y')} - #{end_date.strftime('%b %Y')} ( #{duration})" # end_date.present?
    end
  end

  def fetch_month_days(end_date)
    ((end_date.year - start_date.year) * 12 + end_date.month - start_date.month - (end_date.day >= start_date.day ? 0 : 1)).round
  end
end
