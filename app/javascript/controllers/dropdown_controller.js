import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    if (!this.hasMenuTarget) return;
    console.log("✅ Dropdown menu connected");

    // Close the dropdown when a link is clicked (mobile fix)
    const links = this.menuTarget.querySelectorAll("a");
    links.forEach(link => {
      link.addEventListener("click", () => {
        this.menuTarget.classList.remove("active");
      });
    });
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("active");
  }

  close(event) {
    if (!this.hasMenuTarget) return;
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("active");
    }
  }
}
