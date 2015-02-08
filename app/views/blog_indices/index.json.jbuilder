json.array!(@blog_indices) do |blog_index|
  json.extract! blog_index, :id
  json.url blog_index_url(blog_index, format: :json)
end
