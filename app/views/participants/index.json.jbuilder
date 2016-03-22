json.array!(@participants) do |participant|
  json.extract! participant, :id, :administrative_title, :title, :email, :person_id
  json.url participant_url(participant, format: :json)
end
