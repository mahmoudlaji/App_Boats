import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';
// Connects to data-controller="sweetalert"
export default class extends Controller {
  connect() {
    Swal.fire({
      title: "Votre demande a bien été envoyée!",
      text: "Cliquez sur OK!",
      icon: "success"
    });
  }
}
