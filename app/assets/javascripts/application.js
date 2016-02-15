//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$.fn.dump = function(label) {
  if (label) {
    console.log([label, this]);
  } else {
    console.log(this);
  }

  return this;
};
