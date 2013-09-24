class AddExperienceToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :experience, :string
    add_column :companies, :state, :integer
  end
end
