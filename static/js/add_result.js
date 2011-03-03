var AddMongoResult = function(trigger, hook) {
	this.trigger = $(trigger);
	this.hook = $(hook);
	this.setup();
};

AddMongoResult.prototype = {
	setup: function() {
		var self = this;
		this.trigger.bind('click', function(){
			self.click();
		});
	},
	
	click: function() {
		var self = this;
		console.log('new blood');
		self.hook.append(self.getDatePicker);
	},
	
	getDatePicker: function() {
		return $('<input type="text" id="id_date" name="date">').clone().datepicker();
	}
};