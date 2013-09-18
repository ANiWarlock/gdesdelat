json.array!(@companies) do |company|
  json.extract! company, :phone, :address, :logo, :contact_person, :avg_price, :site, :notes
  json.url company_url(company, format: :json)
end
