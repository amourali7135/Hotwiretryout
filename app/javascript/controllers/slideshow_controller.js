import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="slideshow"
export default class extends Controller {
  static targets = ["slide"];
  static values = { index: { type: Number, default: 2 } };
  // static values = { index: Number, effect: { type: String, default: "kenburns" } };

  next() {
    this.indexValue++
  }

  previous() {
    this.indexValue--
  }

  indexValueChanged() {
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue
    })
  }
}
