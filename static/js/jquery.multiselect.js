var MultiSelect = function(hook) {
	this.hook = $(hook);
	this.setup();
};

MultiSelect.prototype = {
	setup: function() {
		this.hook.find('.ui-widget-content').live('click', function() {
			$(this).toggleClass("ui-selected");
		});
	
	
		this.hook.find('li').live('mouseenter mouseleave', function(event) {
			if (event.type == 'mouseenter') {
				$(this).css('cursor', 'pointer');
			}
			else {
			
			}
		});
	},
	
	getSelected: function() {
		var selectArray = [];
		var self = this;
		this.hook.find('.ui-selected').each( function(){ 
			selectArray.push(self.getLi($(this)));
		});
			
		return selectArray;
	},
	
	getLi: function(li) {
		var o = {
				'id': li.metadata().id,
				'score': li.html()
		};
		
		return o;
	}
};