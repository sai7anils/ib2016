json.array!(@ideas) do |idea|
  json.extract! idea, :id, :category_id, :title, :description, :attachment
  json.url idea_url(idea, format: :json)
end
