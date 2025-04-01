import { Application } from "@hotwired/stimulus"
const application = Application.start()
window.Stimulus = application // ✅ expose globally
export { application }
