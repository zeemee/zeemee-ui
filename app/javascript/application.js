// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

// Other imports...
import jquery from "jquery"
import "foundation-sites"

window.jQuery = jquery
window.$ = jquery

$(function() {
  $(document).foundation();
})

