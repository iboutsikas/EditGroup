json.array!(@publications) do |publication|
  json.extract! publication, :id, :title, :date_time, :pages, :abstract
  json.url publication_url(publication, format: :json)
end
