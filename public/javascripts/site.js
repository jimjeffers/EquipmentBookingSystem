// Unobtrusive Interface Enhancements
// Written by J. Jeffers
// ------------------------------------------------------------------
// Some scripts here have been written specific to this project.
// Others have been reused from past projects. You can find those
// here: http://gist.github.com/jimjeffers

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