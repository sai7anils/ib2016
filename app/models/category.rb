class Category < StaticModel::Base
  has_many :ideas
  has_many :users
  set_data_file "#{Rails.root}/db/statics/category.yml"

  def self.latest_ideas
    ideas = []
    Category.all.each do |cate|
      ideas.push(cate.ideas.last)
    end
    ideas
  end
end
