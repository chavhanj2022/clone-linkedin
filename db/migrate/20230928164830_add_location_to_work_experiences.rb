class AddLocationToWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    add_column :work_experiences, :location, :string
  end
end
