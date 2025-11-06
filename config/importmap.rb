# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "hotkeys-js", to: "https://cdn.jsdelivr.net/npm/hotkeys-js@3.13.7/dist/hotkeys.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "leaflet" # @1.9.4
pin "tailwindcss-animated" # @2.0.0
pin "tailwindcss/package.json", to: "tailwindcss--package.json.js" # @4.1.16
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @4.1.16
