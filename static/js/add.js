var ResultToggle = function(trigger) {
	this.trigger = $(trigger);
	this.setup();
};

ResultToggle.prototype = {
	setup: function(){
		var self = this;
		this.trigger.bind('click', function(){
			console.log('click');
			self.click();
		});
	},
	click : function(){
		var hasResult = $('#id_has_result');
		console.log(hasResult.val());
	}
};



$(document).ready(function() {
	new ResultToggle('#toggle_result')
});


$(function(){
	$("#addform").form();
	//date picker
	var d = new Date();
	$("#id_date").datepicker();
});