import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["source", "button", "default", "success"]

  static values = {
    successContent: { type: String, default: "✅" },
    successDuration: { type: Number, default: 2000 }
  }

  connect() {
    if (!this.hasButtonTarget) return

    this.originalContent = this.buttonTarget.innerHTML
  }

  copy(event) {
    event.preventDefault()
    
    const text = this.sourceTarget.value || this.sourceTarget.innerHTML
    navigator.clipboard.writeText(text).then(() => {
      // Show success state
      if (this.hasDefaultTarget && this.hasSuccessTarget) {
        this.defaultTarget.classList.add('hidden')
        this.successTarget.classList.remove('hidden')
        
        // Reset after specified duration
        setTimeout(() => {
          this.defaultTarget.classList.remove('hidden')
          this.successTarget.classList.add('hidden')
        }, this.successDurationValue)
      } else if (this.hasButtonTarget) {
        // Fallback for old implementation
        const originalContent = this.buttonTarget.innerHTML
        this.buttonTarget.innerHTML = this.successContentValue
        
        setTimeout(() => {
          this.buttonTarget.innerHTML = originalContent
        }, this.successDurationValue)
      }
    })
  }

  get successContentValue() {
    return this.data.get("successContentValue")
  }
}
