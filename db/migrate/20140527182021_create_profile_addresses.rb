class CreateProfileAddresses < ActiveRecord::Migration
  def change
    create_table :profile_addresses do |t|
      t.references :user_profile
      t.string :street_1
      t.string :street_2
      t.string :city
      t.integer :postal_code

      t.timestamps
    end
  end
end
