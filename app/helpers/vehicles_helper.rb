module VehiclesHelper
  def vehicle_features(vehicle)
    [
      { label: "Rok produkcji", value: vehicle.year },
      { label: "Ilość miejsc do spania", value: vehicle.sleeps },
      { label: "Skrzynia biegów", value: vehicle.transmission_name },
      { label: "Długość", value: vehicle.length },
      { label: "Cena za dobę", value: formatted_daily_price(vehicle) }
    ]
  end

  def formatted_daily_price(vehicle)
    "#{number_to_currency(vehicle.price, unit: "zł", precision: 0, format: "%n%u")} / dzień"
  end
end
