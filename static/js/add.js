var ResultToggle = function(trigger) {
	this.trigger = $(trigger);
	this.setup();
};

ResultToggle.prototype = {
	setup: function(){
		var self = this;
		this.trigger.bind('click', function(){
			self.click();
		});
	},
	click : function(){
		var hasResult = $('#id_has_result');
		var result = $('#form_result');
		var rtxt = $('#result_text');
		
		if(hasResult.val() == 'True'){
			result.hide();
			rtxt.html('Want to add a result also?');
			hasResult.val('False');
		}
		else{
			result.show();
			rtxt.html('Add Workout Only?');
			hasResult.val('True');
		}
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