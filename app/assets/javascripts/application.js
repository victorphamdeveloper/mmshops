// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require private_pub
//= require_tree .

$(document).ready(function(){
	/*var fade = function (node) {
		var level = 1;
	
		var step = function () {
			var hex = level.toString(16); 
			node.style.backgroundColor = '#FFFF' + hex + hex; 
			if (level < 15) {
				level += 1;
				setTimeout(step, 100);
			}
		};
	
		setTimeout(step, 100);
  };

  fade(document.body);*/
  	var x = document.getElementById("city_name");
		x.onchange = function () {
			window.location.href = "/products?city=" + this.value;
  	};
  
 
});

