json.array!(@journals) do |journal|
  json.extract! journal, :id, :title, :volume, :issue
  json.url journal_url(journal, format: :json)
end
