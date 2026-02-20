import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["details", "button"]

  toggle() {
    const collapsed = this.detailsTarget.classList.toggle("is-collapsed")
    const expanded = !collapsed

    this.buttonTarget.textContent = expanded ? "Închide" : "Citește mai mult"
    this.buttonTarget.setAttribute("aria-expanded", expanded.toString())
  }
}
