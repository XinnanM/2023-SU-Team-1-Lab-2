class ChangeTimeDataTypesInSections < ActiveRecord::Migration[7.0]
  def change
    change_column :sections, :time_start, :time
    change_column :sections, :time_end, :time
  end
end
