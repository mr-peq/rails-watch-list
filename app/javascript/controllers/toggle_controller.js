import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  connect() {
    console.log("Connected");
  }

  static targets = ["form"];

  showForm() {
    this.formTarget.classList.remove('d-none')
    this.formTarget.scrollIntoView();
  }

//   const listShowEvents = () => {
//   const addMovieBtn = document.getElementById('addMovie');
//   const form = document.getElementById('new_bookmark');

//   addMovieBtn.addEventListener('click', () => {
//     form.classList.remove('d-none');
//     form.scrollIntoView();
//   });
// }
}
