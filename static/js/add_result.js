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
		self.hook.empty();
		self.hook.append(self.getDatePicker());
		var mongoId = self.trigger.parent().parent().attr('id');
		console.log(mongoId);
		$.ajax({
				type: 'GET',
				dataType: 'json',
				url: '/ajax/get_wod.json/',
				data: { 'wod': mongoId },
				success: function(resp) {
					self.hook.append(self.getSets(resp));
				}
		});

	},
	
	getDatePicker: function() {
		var picker =  $('<div><p>Date<p><input type="text" id="id_date" name="date"></div>').clone();
		picker.find('#id_date').datepicker();
		
		return picker;
	},
	
	getSets: function(root) {
		var html = '<section class="sets>"';
		
		for (var i = 0; i < root.sets.length; i++) {
			set = root.sets[i];
			html += '<div class="set>"' +
					'<h4>' + set.name + '</h4>';
			html += this.getRounds(set.rds);
			html += '<hr><hr></div>';
		}
		
		html += '<hr><hr><hr></section>';
		
		return $(html);
	},
	
	getRounds: function(rounds) {
		var html = '';
		//console.log(rounds);
		for (var i = 0; i < rounds.length; i++) {
			html += '<div class="round">';
			html += this.getEx(rounds[i]);
			html += '<hr></div>';
		}
		return html;
	},
	
	getEx: function(rnd) {
		console.log(rnd);
		var html = '<div class="ex">';
		html += 'cool';
		html += '</div>';
		
		return html;
	}
};