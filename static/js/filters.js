var CheckboxFilter = function(section) {
	this.section = $(section);
	this.exes = this.section.find('.ex');
	this.all = this.section.find('.exall');
	this.setup();
};

CheckboxFilter.prototype = {
	setup: function() {
		var self = this;
		console.log(self.section.find('.ex'));
		self.exes.live('change', function() {
			console.log($(this));
			self.fixAll($(this));
		});
	},
	
	getChecked: function() {
		
	},
	
	fixAll: function(box) {
		var self = this;
		if (box.is(':checked')) {
			console.log('checked');
			if(box.data('id') == 0 ){
				self.exes.not(box).each( function() {
					$(this).attr('checked', false);
				});
			}
			else {
				self.all.attr('checked', false);
			}
		}
		

	}
};