$(document).ready(function() {
  console.log("eeee")
   $("#myCarousel").swiperight(function() {
      $(this).carousel('prev');
      });
   $("#myCarousel").swipeleft(function() {
      $(this).carousel('next');
 });
})
