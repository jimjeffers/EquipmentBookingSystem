$(document).ready(function() {
   $('#grid').hide();
   $('body').dblclick(function() {
      if($('#grid').is(':visible')) {
         $('#grid').hide('slow');
      } else {
         $('#grid').show('slow');  
      }
   });
});
