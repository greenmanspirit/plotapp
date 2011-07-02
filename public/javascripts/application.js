// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	$("#plotpoints").sortable({
		handle:	'.smallIndexCardTop',
		opacity: 0.7,
		revert: true,
		tolerance: 'pointer',
		update: function(event, ui) {
				$.ajax({
					type: "POST",
					url: "plotpoints/sort",
					data: $('#plotpoints').sortable("serialize"),
				})
			}
	});
});
