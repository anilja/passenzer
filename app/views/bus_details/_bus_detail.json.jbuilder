json.extract! bus_detail, :id, :name, :number, :source, :destination, :source_lat, :destination_lat, :source_lang, :destination_lang, :created_at, :updated_at
json.url bus_detail_url(bus_detail, format: :json)
