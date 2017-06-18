class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.integer :entry_type
      t.integer :paid_entry_cose_min
      t.integer :event_sub_type
      t.string :website
      t.string :event_image
      t.string :partner_logo
      t.text :description
      t.string :address_line_1
      t.string :address_line_2
      t.string :country
      t.string :city
      t.string :region
      t.string :zipcode
      t.text :event_partner
      t.datetime :event_from
      t.datetime :event_to
      t.timestamps :event_time
      t.string :timezone
      t.integer :views, default: 0
      t.timestamps null: false
    end
  end
end
