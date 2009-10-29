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
   function bindDatePicker(selector) {
      $(selector).find('.datepicker').datepicker({
         beforeShow: function(input) { 
            var from = $('input[name="available_from"]');
            var until = $('input[name="available_until"]');
            var current = $(input);
            if(current.attr('name') == "available_from" && until.val()) {
               from.datepicker('option', 'maxDate', until.datepicker('getDate'));
            } else if(current.attr('name') == "available_until" && from.val()) {
               until.datepicker('option', 'minDate', from.datepicker('getDate'));
            }
         },
         onSelect: function(dateText, inst) {
            var current = $(inst);
            if(current.attr('id').match(/from/)) {
               $.cookie("available_from", dateText);
               if($('.cart_item_module').length > 0) {
                  if($('.unavailable').is(':visible')) {
                     $('.unavailable').hide();
                     $('.pull_request').hide();
                     $('.search_field_quantity').show();
                     $('.cart_item_module .search_field_availability_submit').show();
                  } else {
                     $('.unavailable').show();
                     $('.pull_request').show();
                     $('.search_field_quantity').hide();
                     $('.cart_item_module .search_field_availability_submit').hide();
                  }
               }
            } else if(current.attr('id').match(/until/)) {
               $.cookie("available_until", dateText);
            }
         },
         minDate: new Date(),
         duration: 'slow',
         altFormat: 'dd/mm/yyyy',
         numberOfMonths: 2
      });
      $('input[name$="available_from"]').val($.cookie("available_from"));
      $('input[name$="available_until"]').val($.cookie("available_until"));
   }
   bindDatePicker('body');
   
   // Live search datepicker refinements.
   if($('#search_results').length){
      
   }
   
   // Setup accordians
   $('.accordian').accordion();
   
   // Hide items that are only present for non-JS users.
   $('#ui-datepicker-div, .non_interactive').hide();
   
   // Search Refinements
   function updateCategoryCounts() {
      $('.category_checklist input[type="checkbox"]').each(function(index) {
         var current = $(this);
         var count = $('ol.item_list li.'+current.attr('id')).length
         current.siblings('span.count').html(count);
         if (count > 0) {
            current.parent().show();
         } else {
            current.parent().hide();
         }
      });
   }
   
   // Build a list of selectors.
   // Hide all list items and only show the items that match the selectors.
   function filterSearchResults() {
      var selectors = [];
      var base = 'ol.item_list .item';
      $('.category_checklist :checked').each(function(index) {
         selectors.push(base+"."+$(this).attr('id'));
      });
      
      var total_list = $(base).addClass('inactive').removeClass('active');
      if (selectors.length > 0) {
         var active_list = $(selectors.join(',')).addClass('active').removeClass('inactive').show();
         $('#filtered_count').html("Viewing "+active_list.length+" out of ");
      }
      var inactive_list = $(base+".inactive").hide();
   }
   
   if($('body').hasClass('search_results') && !$('body').hasClass('browse')) {
      updateCategoryCounts(); // Run on load...
      filterSearchResults(); // Run on load...
      $('.category_checklist input[type="checkbox"]').change(filterSearchResults); // Bind to checkboxes...
   }
   
   // Lightbox
   function showLightBox() {
      if($('#lightbox').length < 1) {
         $('body').append('<div id="lightbox"><a href="#" id="lightbox-close">close</a><h2 id="lightbox-load">Just one moment please...</h2><div id="lightbox-content"></div>');
         $('#lightbox-close').click(function() {
            hideLightBox();
            return false;
         });
      }
      if($('#lightbox-background').length < 1) {
         $('body').append('<div id="lightbox-background"></div>');
         $('#lightbox-background').click(function() {
            hideLightBox();
            return false;
         });
      }
      $('#lightbox, #lightbox-background').show();
      $('#lightbox-load').show();
      $('#lightbox-content').html('');
      centerLightBox();
   }
   
   function hideLightBox() {
      $('#lightbox, #lightbox-background').hide('fast');
      return false;
   }
   
   function intoLightBox(content) {
      showLightBox();
      setTimeout(function(){
         $('#lightbox-load').hide('fast');
         $('#lightbox-content').html(content);
         $('#lightbox-content .lightbox-close').click(hideLightBox);
         bindDatePicker('#lightbox-content');
         bindCartForm('#lightbox-content');
         centerLightBox();
      }, 350);
   }
   
   function centerLightBox() {
      $('#lightbox').css('margin-top',-($('#lightbox').height()/2));
   }
   
   // Bind lightbox to cart form.
   function bindCartForm(selector) {
      $(selector).find('#add_to_cart form, .cart_form form').submit(function() {
         showLightBox();
         var form = $(this);
         $.post(this.action, form.serializeArray(),
            function(data) {
               intoLightBox(data);
            },
         "text");

         return false;
      });
   }
   bindCartForm('body');
   
   $('a.interactive').click(function() {
      showLightBox();
      $.post(this.href, '',
         function(data) {
            intoLightBox(data);
         },
      "text");
      return false;
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
   
   // Add list sorting for admin.
   $(".sorted_list").sortable({
      handle: '.drag',
      update: function(event, ui) {
         showLightBox();
         var current = $(event.target);
         console.log(current.sortable('serialize'));
         $.post('/'+current.attr('id')+'/update_order', current.sortable('serialize'),
            function(data) {
               intoLightBox(data);
            },
         "text");
      }
   });
   $(".sorted_list").disableSelection();
});