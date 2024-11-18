import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['container'];

  connect() {
    console.log("Links controller connect")
    if (this.hasContainerTarget) {
      this.containerTarget.querySelectorAll('a').forEach((link) => {
        link.setAttribute('target', '_blank');
        link.classList.add('external-link')
      });
    }
  }
}
