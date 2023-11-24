// app/javascript/controllers/reservation_controller.js
import { Controller } from "stimulus";
export default class extends Controller {
  static targets = ["form"];
  connect() {
    const calendar = new Calendar(document.getElementById("calendar"), {
      // Configuration du calendrier JSPCK
      dateClick: this.dateClicked.bind(this)
    });
  }
}
