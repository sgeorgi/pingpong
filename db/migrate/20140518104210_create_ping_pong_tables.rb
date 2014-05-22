class CreatePingPongTables < ActiveRecord::Migration
  def change
    create_table :ping_pong_tables do |t|
      t.float :latitude, :longitude
      t.string :street, :street_number, :postal_code, :city
    end
  end
end
