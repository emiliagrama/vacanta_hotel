import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "left", "right"]

  connect() {
    console.log("🎠 Carousel controller connected")
  }

  scrollLeft() {
    this.containerTarget.scrollBy({ left: -200, behavior: "smooth" })
  }

  scrollRight() {
    this.containerTarget.scrollBy({ left: 200, behavior: "smooth" })
  }
}

