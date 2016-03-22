json.array!(@participations) do |participation|
  json.extract! participation, :id, :administrative_title, :email
  json.url participation_url(participation, format: :json)
end
