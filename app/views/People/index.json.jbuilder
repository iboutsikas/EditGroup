json.array!(people) do |person|
  json.extract! person, :id, :firstName, :lastName
  json.url person_url(person, format: :json)
end
