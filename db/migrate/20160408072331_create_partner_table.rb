class CreatePartnerTable < ActiveRecord::Migration
  def change
    create_table :partner_tables do |t|
      t.integer :event_id
      t.string :name
      t.string :logo
    end
  end
end
