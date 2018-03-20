// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require materialize
//= require rails-ujs
//= require_tree .

$(document).ready(function() {

	$('#save-bio').on('click', function() {
		var bioData = $('#add-bio').val();
		console.log("Success update");
		$.ajax({
			url: 'http://localhost:3000/user/update-bio/<%= current_user.id %>',
			method: 'put',
			data: { bio : bioData } , 
			success: function() {
				console.log("Success update");
			}
		});
	});
	
	// MaterializeCSS Initializations
	$('.modal').modal();
	$('.dropdown-button').dropdown({
	    inDuration: 300,
	    outDuration: 225,
	    constrainWidth: true, // Does not change width of dropdown to that of the activator
	    hover: false, // Activate on hover
	    gutter: 0, // Spacing from edge
	    belowOrigin: false, // Displays dropdown below the button
	    alignment: 'left', // Displays dropdown with edge aligned to the left of button
	    stopPropagation: false // Stops event propagation
	  }
	);
});