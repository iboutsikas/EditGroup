json.array!(@authors) do |author|
  json.extract! author, :id, :person_id, :publication_id
  json.url author_url(author, format: :json)
end
