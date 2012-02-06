$(function(){
    $(".social-icon img").hover(function() {
        $(this).parent().next("span").animate({opacity: "show", top: "170"}, "slow");}, function(){
            $(this).parent().next("span").animate({opacity: "hide", top: "170"}, "fast");
    });

    $().UItoTop({ easingType: 'easeOutQuart' });
});
