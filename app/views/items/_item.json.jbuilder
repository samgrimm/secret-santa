json.extract! item, :id, :name, :url, :price, :created_at, :updated_at
json.url item_url(item, format: :json)