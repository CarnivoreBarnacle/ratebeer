json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :beer_count
  json.url brewery_url(brewery, format: :json)
end
