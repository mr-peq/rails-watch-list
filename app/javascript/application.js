// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@popperjs/core"


function listShowEvents() {
  const addMovieBtn = document.getElementById('addMovie');
  const form = document.getElementById('new_bookmark');

  addMovieBtn.addEventListener('click', () => {
    form.classList.remove('d-none');
    form.scrollIntoView();
  });
}

listShowEvents();
