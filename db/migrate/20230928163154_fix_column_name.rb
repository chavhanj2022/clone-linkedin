class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :work_experiences, :start_data, :start_date
    rename_column :work_experiences, :end_data, :end_date
    rename_column :work_experiences, :location_tye, :location_type
  end
end
