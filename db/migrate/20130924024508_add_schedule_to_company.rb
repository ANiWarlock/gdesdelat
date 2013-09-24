class AddScheduleToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :schedule, :string
  end
end
