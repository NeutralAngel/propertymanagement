json.array!(@leases) do |lease|
  json.extract! lease, :id, :start_date, :end_date, :rent, :unit_id
  json.url lease_url(lease, format: :json)
end
