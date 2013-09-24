class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :work_start, :datetime
    add_column :companies, :work_end, :datetime
    add_column :companies, :mobile, :string
    add_column :companies, :contact_person2, :string
    add_column :companies, :metro, :string
  end
end
