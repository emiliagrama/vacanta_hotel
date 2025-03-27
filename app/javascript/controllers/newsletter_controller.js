import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["successMessage"]

  connect() {
    console.log("📬 Newsletter controller loaded")
  }

  async submit(event) {
    event.preventDefault()

    const form = event.target
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: "POST",
        body: formData,
        headers: { Accept: "application/json" }
      })

      if (response.ok) {
        form.style.display = "none"
        this.successMessageTarget.classList.remove("hidden")
      } else {
        alert("A apărut o eroare. Încearcă din nou.")
      }
    } catch (error) {
      console.error("Newsletter error:", error)
      alert("A apărut o eroare de rețea.")
    }
  }
}
