class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :full_name
      t.date :dob
      t.string :city
      t.string :country

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
