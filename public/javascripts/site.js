$(document).ready(function() {
   // Search Form
   var search_form = $('#primary_search_form input[type="text"]');
   var search_form_default = search_form.val();
   search_form.focus(function() {
      if(search_form.val() == search_form_default) {
         search_form.val('');
      }
   });
});
