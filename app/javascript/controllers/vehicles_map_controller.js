import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

// Connects to data-controller="vehicles-map"
export default class extends Controller {
    static values = {
        vehicles: Array,
        center: Array
    }

    connect() {
        this.initMap()
        this.addMarkers()
    }

    initMap() {
        const warsawCoordinates = [52.2297, 21.0122]
        const center = this.hasCenterValue ? this.centerValue : warsawCoordinates

        this.map = L.map(this.element).setView(center, 6)

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors',
            maxZoom: 18,
        }).addTo(this.map)
    }

    addMarkers() {
        if (!this.hasVehiclesValue || this.vehiclesValue.length === 0) return

        const bounds = []
        this.vehiclesValue.forEach(vehicle => {
            if (vehicle.latitude && vehicle.longitude) {
                const marker = L.marker([vehicle.latitude, vehicle.longitude])
                    .addTo(this.map)

                marker.bindPopup(`<b>${vehicle.name}</b><br /><a href="${vehicle.url}">Zobacz więcej </a>`)

                bounds.push([vehicle.latitude, vehicle.longitude])
            }
        })

        if (bounds.length > 0) {
            this.map.fitBounds(bounds, { padding: [50, 50] })
        }
    }

    disconnect() {
        if (this.map) {
            this.map.remove()
        }
    }
}
