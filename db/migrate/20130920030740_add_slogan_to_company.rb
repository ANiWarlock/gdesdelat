class AddSloganToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :slogan, :string
  end
end
