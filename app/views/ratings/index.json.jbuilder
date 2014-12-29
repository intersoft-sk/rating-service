json.array!(@ratings) do |rating|
  json.extract! rating, :id, :event_id, :meat_id, :username, :comment, :rating
  json.url rating_url(rating, format: :json)
end
