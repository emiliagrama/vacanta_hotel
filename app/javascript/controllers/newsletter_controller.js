import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["successMessage", "emailField", "submitButton"];

  connect() {
    console.log("📬 Newsletter controller loaded");

    // Extra: check immediately when page loads
    this.checkIfAlreadySubscribed();
  }

  async submit(event) {
    event.preventDefault();
    const form = event.target;
    const formData = new FormData(form);

    try {
      const response = await fetch(form.action, {
        method: "POST",
        body: formData,
        headers: { Accept: "application/json" }
      });

      const data = await response.json();

      if (response.ok) {
        form.style.display = "none";
        if (this.hasSuccessMessageTarget) {
          this.successMessageTarget.classList.remove("hidden");
        }
        document.cookie = "subscribed_to_newsletter=true; path=/; max-age=31536000";
        // Send event to Google Analytics
        if (typeof gtag === 'function') {
          gtag('event', 'newsletter_signup', {
            event_category: 'engagement',
            event_label: 'homepage_form'
          });
        }

      } else {
        alert(data.error || "A apărut o eroare. Încearcă din nou.");
      }
    } catch (error) {
      console.error("Newsletter error:", error);
      alert("A apărut o eroare de rețea.");
    }
  }

  checkIfAlreadySubscribed() {
    if (document.cookie.split(";").some(c => c.trim().startsWith("subscribed_to_newsletter="))) {
      // Already subscribed
      if (this.hasEmailFieldTarget) {
        this.emailFieldTarget.disabled = true;
        this.emailFieldTarget.value = "Deja abonat ✔️";
      }
      if (this.hasSubmitButtonTarget) {
        this.submitButtonTarget.disabled = true;
        this.submitButtonTarget.style.opacity = "0.5";
      }
    }
  }
}
