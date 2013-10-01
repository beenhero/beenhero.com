/* from /vendor/javascripts dir */

//= require jquery/jquery
//= require main

!function ($) {
  $(function(){
  	$(".aside img").on("click", function(e){
      e.preventDefault();
      $(this).parent(".aside").toggleClass("stretch");
  	});
  });
}(window.jQuery);