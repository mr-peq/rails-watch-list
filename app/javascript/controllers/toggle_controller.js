import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  connect() {
    console.log("Connected");
  }

  static targets = ["addMovieForm", "createListForm"];

  showAddMovieForm() {
    this.addMovieFormTarget.classList.remove('d-none')
    this.addMovieFormTarget.scrollIntoView();
  }

  showCreateListForm() {
    this.createListFormTarget.classList.remove('d-none')
    this.createListFormTarget.scrollIntoView();
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
