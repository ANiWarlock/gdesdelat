class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :phone
      t.string :address
      t.string :logo
      t.string :contact_person
      t.float :avg_price
      t.string :site
      t.text :notes

      t.timestamps
    end
  end
end
