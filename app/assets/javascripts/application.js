//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require ember-cli-frontend/assets/vendor
//= require ember-cli-frontend/assets/frontend

$.fn.dump = function(label) {
  if (label) {
    console.log([label, this]);
  } else {
    console.log(this);
  }

  return this;
};
