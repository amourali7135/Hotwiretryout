import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="experimental"
export default class extends Controller {
  static targets = [ "testing" ]

  change(event) {
    console.log("testing please");
    console.log(this.element.innerText);
    console.log(this.testingTarget);
    this.element.innerText = "Red";
    this.element.style.color = "red";
  }
}
