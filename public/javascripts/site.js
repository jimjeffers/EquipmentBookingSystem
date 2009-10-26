// Unobtrusive Interface Enhancements
// Written by J. Jeffers
// ------------------------------------------------------------------
// Some scripts here have been written specific to this project.
// Others have been reused from past projects. You can find those
// here: http://gist.github.com/jimjeffers

$(document).ready(function() {
   // Search Form
   var search_form = $('.search_field input[type="text"]').addClass('fresh')
   var search_form_default = "projectors, camera, laptop case, etc...";
   search_form.each(function(index) {
      var current = $(this);
      if(current.val() == "") { 
         current.val(search_form_default); 
      }
   });
   search_form.focus(function() {
      var current_field = $(this).removeClass('fresh');
      if(current_field.val() == search_form_default) {
         current_field.val('');
      }
   });
   
   // Bind jQuery UI Datepicker
   $('.datepicker').datepicker({
      beforeShow: function(input) { 
         var from = $('#available_from');
         var until = $('#available_until');
         var current = $(input);
         if(current.attr('id') == "available_from" && until.val()) {
            from.datepicker('option', 'maxDate', until.datepicker('getDate'));
         } else if(current.attr('id') == "available_until" && from.val()) {
            until.datepicker('option', 'minDate', from.datepicker('getDate'));
         }
      },
      minDate: new Date(),
      duration: 'slow',
      numberOfMonths: 2,
   });

   // Setup accordians
   $('.accordian').accordion();
   
   // Hide items that are only present for non-JS users.
   $('#ui-datepicker-div, .non_interactive').hide();
   
   // Search Refinements
   
   // Easy dropdown navigation with timeouts.
   $('.sub_navigation').each(function() {
          var menu = $(this);
          menu.hide();
          var parent = $(menu.parent().get(0));
          var timeout = false; 
          parent.hover(function(){
             if(!timeout && !menu.is(':visible')) {
                timeout = setTimeout(function(){
                   menu.show();
                   parent.addClass('active');
                   timeout = false;
                }, 350);
             } else {
                if(timeout) {
                   clearTimeout(timeout);
                }
                timeout = false;
             }
          },
          function(){
             if(!timeout && menu.is(':visible')) {
                 timeout = setTimeout(function(){
                    menu.hide();
                    parent.removeClass('active');
                    timeout = false;
                 }, 350);
              } else {
                 if(timeout) {
                    clearTimeout(timeout);
                 }
                 timeout = false;
              }
          });
      });
});