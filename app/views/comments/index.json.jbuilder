json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :used_id
  json.url comment_url(comment, format: :json)
end
