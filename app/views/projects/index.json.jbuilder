json.array!(@projects) do |project|
  json.extract! project, :id, :title, :motto, :description, :date_started, :website, :video
  json.url project_url(project, format: :json)
end
