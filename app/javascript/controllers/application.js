import { Application } from "@hotwired/stimulus"
const application = Application.start()
window.Stimulus = application // ✅ expose globally

// transparent navbar when scroling
window.addEventListener('scroll', () => {
  const navbar = document.querySelector('nav.navbar');
  if (window.scrollY > 50) {
    navbar.classList.add('scrolled');
    console.log('Scrolled - class added');
  } else {
    navbar.classList.remove('scrolled');
    console.log('Not Scrolled - class removed');
  }
});


export { application }
