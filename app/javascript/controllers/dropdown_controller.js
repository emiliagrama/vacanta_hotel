import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    console.log("Dropdown menu connected");
  }

  toggle() {
    event.stopPropagation();
    this.menuTarget.classList.toggle("active");
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("active");
    }
  }
}
