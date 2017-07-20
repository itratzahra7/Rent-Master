json.array!(@industries) do |industry|
  json.extract! industry, :id, :name, :status
  json.url industry_url(industry, format: :json)
end
