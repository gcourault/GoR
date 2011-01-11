window.addEvent('domready', function(){

	$('login').setStyle('height','auto');
	var mySlide = new Fx.Slide('login').hide();  //para que el panel comienze cerrado 

    $('toggleLogin').addEvent('click', function(e){
		e = new Event(e);
		mySlide.toggle();
		e.stop();
	});

    $('closeLogin').addEvent('click', function(e){
		e = new Event(e);
		mySlide.slideOut();
		e.stop();
	});

});



