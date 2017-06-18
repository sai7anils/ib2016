class CreateIdeaBurns < ActiveRecord::Migration
  def change
    create_table :idea_burns do |t|
      t.string :name
      t.string :url
      t.text :meta_description
      t.text :meta_keywords
      t.string :seo_title
      t.string :mail_from_address
      t.string :default_currency
      t.string :facebook
      t.string :linkedin
      t.string :instagram
      t.string :tumblr
      t.string :twitter
      t.string :video
      t.timestamps null: false
    end
  end
end
