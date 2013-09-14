class CreateCsasses < ActiveRecord::Migration
  def change
    create_table :csasses do |t|
      t.integer :company_id
      t.integer :service_id
      t.integer :subscription_type
      t.date :subscription_date
      t.date :subscription_until

      t.timestamps
    end
  end
end
