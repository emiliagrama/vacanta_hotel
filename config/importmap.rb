# Pin npm packages by running ./bin/importmap
pin "flatpickr/ro", to: "flatpickr/ro.js"

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "cookies", to: "cookies.js"
pin "flatpickr" # @4.6.13
pin "flatpickr/dist/l10n/ro", to: "flatpickr--dist--l10n--ro.js" # @4.6.13
