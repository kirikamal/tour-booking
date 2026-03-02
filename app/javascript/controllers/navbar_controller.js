import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "openIcon", "closeIcon"]

  toggleMenu() {
    const menu = this.mobileMenuTarget
    const isHidden = menu.classList.contains("hidden")
    menu.classList.toggle("hidden", !isHidden)
    this.openIconTarget.classList.toggle("hidden", !isHidden)
    this.closeIconTarget.classList.toggle("hidden", isHidden)
  }
}
