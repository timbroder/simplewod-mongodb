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
			result.slideUp();
			rtxt.html('Want to add a result also?');
			hasResult.val('False');
		}
		else{
			result.slideDown();
			rtxt.html('Add Workout Only?');
			hasResult.val('True');
		}
	}
};

var TagSync = function(from, to) {
	this.to = $(to);
	this.from = $(from);
	this.msg = 'Tags included from Workout: ';
	this.setup();
};

TagSync.prototype = {
	setup: function(){
		var self = this;
		self.from.keyup(function() {
			self.update(this.value );
		});
		self.from.blur(function() {
		    self.update(this.value );
		});
		self.from.click(function() {
		    self.update(this.value );
		});
		
		/*$('.ac_results').live('click', function() {
			console.log('hi');
		    //self.update(this.value );
		});*/
		$('body').bind('autocompleteClick', function(e) {
			self.update(self.from.val() );
		});

	},
	update: function(msg){
		this.to.html(this.msg + msg.replace('-', ' '));
	}
};

$(document).ready(function() {
	new ResultToggle('#toggle_result');
	new TagSync('#id_wod_tags', '#tags_from_wod');
});


$(function(){
	$("#addform").form();
	//date picker
	var d = new Date();
	$("#id_date").datepicker();
});