import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

// Connects to data-controller="vehicle-map"
export default class extends Controller {
    static values = {
        latitude: Number,
        longitude: Number,
    }

    connect() {
        this.initMap()
        this.addMarker()
    }

    initMap() {
        this.map = L.map(this.element).setView(
            [this.latitudeValue, this.longitudeValue], 9
        )

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap'
        }).addTo(this.map)
    }

    addMarker() {
        L.marker([this.latitudeValue, this.longitudeValue])
            .addTo(this.map)
    }

    disconnect() {
        if (this.map) {
            this.map.remove()
        }
    }
}