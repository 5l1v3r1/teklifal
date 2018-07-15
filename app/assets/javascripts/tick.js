$(function () {
    var $ticker = $('#news-ticker'),
      $first = $('li:first-child', $ticker);
    
    // put an empty space between each letter so we can 
    // use break word
    $('a', $ticker).each(function () {
        var $this = $(this),
          text = $this.text();
       $this.html(text.split('').join('&#8203;'));
    });
    
    // begin the animation
    function tick($el) {
        $el.addClass('tick')
          .on('webkitAnimationEnd oanimationend msAnimationEnd animationend', function () {
              
            $el.removeClass('tick');
              var $next = $el.next('li');
              $next = $next.length > 0 ? $next : $first;
            tick($next);
        });
    }
        
    tick($first);
    
});