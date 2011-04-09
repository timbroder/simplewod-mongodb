var inputs = {
	exes: []
};

var WodList = function(section) {
	this.section = $(section);
};

WodList.prototype = {
	update: function() {
		this.section.empty();
	}
};

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
			self.fixAll($(this));
			self.getChecked();
		});
	},
	
	getChecked: function() {
		var self = this;
		var exes = [];
		console.log(this.section.find(".ex:checked"));
		this.section.find(".ex:checked").each( function() {
			exes.push($(this).data('id'));
		});
		console.log(exes);
		//$.publish('/filter/exes', [exes]);
		inputs.exes = [exes];
		$.publish('/filter/go', null);
	},
	
	fixAll: function(box) {
		var self = this;
		if (box.is(':checked')) {
			if(box.data('id') == 0 ){
				self.section.find(".ex:checked").not(box).each( function() {
					$(this).attr('checked', false);
				});
			}
			else {
				self.all.attr('checked', false);
			}
		}
	},
	
	disable: function() {
		this.exes.attr("disabled", true);

	},
	
	enable: function() {
		this.exes.removeAttr("disabled");
	}
};



$(function() {
	var exChoice = new CheckboxFilter('#exfilters');
	var main = new WodList('#main');

	$.subscribe('/filter/go', function(results) {
		$.publish('/ui/disable', null);
		//ajaxness
		main.update();
		$.publish('/ui/enable', null);
	});
	
	$.subscribe('/ui/disable', function(results) {
		exChoice.disable();
	});
	
	$.subscribe('/ui/enable', function(results) {
		exChoice.enable();
	});
	
});