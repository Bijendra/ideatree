json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :description, :user_id, :category_id, :status
  json.url assignment_url(assignment, format: :json)
end
