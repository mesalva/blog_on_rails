json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :author, :create_at, :comment_id
  json.url comment_url(comment, format: :json)
end
