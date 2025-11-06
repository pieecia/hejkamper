Geocoder.configure(
  timeout: 5,
  lookup: :nominatim,
  language: :pl,
  use_https: false,
  units: :km,
  http_headers: {
    "User-Agent" => "Hejkamper App"
  }
)