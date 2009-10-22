$(document).ready(function() {
   // Search Form
   var search_form = $('.search_form input[type="text"]').addClass('fresh');
   var search_form_default = search_form.val();
   search_form.focus(function() {
      var current_field = $(this).removeClass('fresh');
      if(current_field.val() == search_form_default) {
         current_field.val('');
      }
   });
});