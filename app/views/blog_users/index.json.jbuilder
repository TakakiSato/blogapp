json.array!(@blog_users) do |blog_user|
  json.extract! blog_user, :id
  json.url blog_user_url(blog_user, format: :json)
end
