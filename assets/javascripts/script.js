$(function(){
    $(".social-icon img").hover(function() {
        $(this).parent().next("span").animate({opacity: "show", top: "190"}, "slow");}, function(){
            $(this).parent().next("span").animate({opacity: "hide", top: "200"}, "fast");
    });

    $().UItoTop({ easingType: 'easeOutQuart' });
});
