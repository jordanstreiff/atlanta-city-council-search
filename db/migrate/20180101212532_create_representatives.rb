class CreateRepresentatives < ActiveRecord::Migration[5.1]
  def change
    create_table :representatives do |t|
      t.integer :district_id
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :website
      t.string :facebook_url
      t.string :instagram_url

      t.timestamps
    end
  end
end
