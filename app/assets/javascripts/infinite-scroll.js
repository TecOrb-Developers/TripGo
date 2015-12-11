// assets/javascripts/infinite-scroll.js
$(function() {
  // var content = $('#beaches');    // where to load new content
  var viewMore = $('[id^="show-more"]'); // tag containing the "View More" link

  var isLoadingNextPage = false;  // keep from loading two pages at once
  var lastLoadAt = null;          // when you loaded the last page
  var minTimeBetweenPages = 5000; // milliseconds to wait between loading pages
  var loadNextPageAt = 1000;      // pixels above the bottom

  var waitedLongEnoughBetweenPages = function() {
    return lastLoadAt == null || new Date() - lastLoadAt > minTimeBetweenPages;
  }

  var approachingBottomOfPage = function() {
    return document.documentElement.clientHeight +
        $(document).scrollTop() < document.body.offsetHeight - loadNextPageAt;
  }

  var nextPage = function() {

    var url = viewMore.find('a').attr('href');
    // alert(url);

    if (isLoadingNextPage || !url)
      return;

    viewMore.addClass('loading');
    isLoadingNextPage = true;
    lastLoadAt = new Date();

    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'script',
      success: function() {
        viewMore.removeClass('loading');
        isLoadingNextPage = false;
        lastLoadAt = new Date();
      }
    })
  };

  // watch the scrollbar
  // $(window).scroll(function() {
  //   if (approachingBottomOfPage() && waitedLongEnoughBetweenPages()) {
  //     nextPage();
  //   }
  // });

  // failsafe in case the user gets to the bottom
  // without infinite scrolling taking affect.

  viewMore.find('a').click(function(event) {
    viewMore = $("#"+($(this).parent().attr('id')));
    event.preventDefault();
    nextPage();
   
  })

});