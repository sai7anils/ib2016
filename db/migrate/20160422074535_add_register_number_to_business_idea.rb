class AddRegisterNumberToBusinessIdea < ActiveRecord::Migration
  def change
    add_column :business_ideas, :register_number, :string
  end
end
