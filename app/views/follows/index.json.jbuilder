json.array!(@follows) do |follow|
  json.extract! follow, :id, :obj_type, :obj_id, :user_id
  json.url follow_url(follow, format: :json)
end
