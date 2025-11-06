# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

FEATURES_DATA = [
  { key: 'fridge', position: 1 },
  { key: 'stove', position: 2 },
  { key: 'toilet', position: 3 },
  { key: 'shower', position: 4 },
  { key: 'heating', position: 5 },
  { key: 'air_conditioning', position: 6 },
  { key: 'tv', position: 7 },
  { key: 'wifi', position: 8 },
  { key: 'solar_panel', position: 9 },
  { key: 'awning', position: 10 },
  { key: 'bikes', position: 11 },
  { key: 'outdoor_table', position: 12 },
  { key: 'camping_chairs', position: 13 },
  { key: 'kitchenware', position: 14 },
  { key: 'bedding', position: 15 },
  { key: 'towels', position: 16 }
]

FEATURES_DATA.each do |data|
  Feature.find_or_create_by!(key: data[:key]) do |feature|
    feature.position = data[:position]
  end
end

puts "Created #{Feature.count} features"
