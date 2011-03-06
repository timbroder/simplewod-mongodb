var AddMongoResult = function(trigger, hook) {
	this.trigger = $(trigger);
	this.hook = $(hook);
	this.idCounter = 1;
	this.setup();
};

AddMongoResult.prototype = {
	setup: function() {
		var self = this;
		this.trigger.bind('click', function(){
			self.click();
		});
		
		$('#addresult').live('click', function(e){
			e.preventDefault();
			self.submit();
		});
	},
	
	
	click: function() {
		var self = this;
		self.hook.empty();
		
		var form = self.getForm();
		form.append(self.getDatePicker());
		self.hook.append(form);
		var mongoId = self.trigger.parent().parent().attr('id');
		$.ajax({
				type: 'GET',
				dataType: 'json',
				url: '/ajax/get_wod.json/',
				data: { 'wod': mongoId },
				success: function(resp) {
					form.append(self.getSets(resp));
					form.append(self.getOptional);
					form.append(self.getSubmit());
				}
		});

	},
	
	getOptional: function() {
		var html = '<div>Location: <input type="text" id="loc" /></div>';
		html += '<div><p>Notes</p><textarea id="notes" />';
		
		html += '<br/>';
		return $(html);
	},
	
	getForm: function() {
		var form = $('<form id="resultform"></form>');
		form.validationEngine();
		return form.clone();
	},
	
	getSubmit: function() {
		return $('<input id="addresult" type="submit" name="submit" value="submit" />').clone();
	},
	
	getDatePicker: function() {
		var picker =  $('<div>Date <input type="text" id="id_date" name="date" class="validate[required]"></div>').clone();
		picker.find('#id_date').datepicker();
		
		return picker;
	},
	
	getSets: function(root) {
		var html = '<section class="sets">',
			i;
		
		for (i = 0; i < root.sets.length; i++) {
			set = root.sets[i];
			html += '<div class="set">' +
					'<h4 class="set-name">' + set.name + '</h4>';
			html += this.getRounds(set.rds);
			html += '<hr><hr></div>';
		}
		
		html += '<hr><hr><hr></section>';
		
		return $(html);
	},
	
	getRounds: function(rounds) {
		var html = '',
			i;
		
		for (i = 0; i < rounds.length; i++) {
			html += '<div class="round">';
			html += this.getEx(rounds[i]);
			html += '<hr></div>';
		}
		return html;
	},
	
	getEx: function(rnd) {
		var html = '',
			i;
		for (i = 0; i < rnd.exs.length; i++){
			var ex = rnd.exs[i];
			html += '<div class="ex-line" data-ex="\'' + ex.name + '\'" data-type_id="' + ex.type_id + '" data-type="\'' + ex.type + '\'" data-measure="\'' + ex.measure + '\'" data-type_has_reps="\'' + ex.type_has_reps + '\'">';
			html += ex.name + ' ';
			html += '<input type="text" class="amount-val validate[required]" value="' + ex.amount + '"' + this.getInputId() + '>';
			html += ' 	' + ex.measure;
			if (ex.reps) {
				html += ' x ';
				html += '<input type=text class="num-reps validate[required]" value="' + ex.reps + '"' + this.getInputId() + '>';
				html += ' reps';
			}

			html += '</div>';
		}
		
		
		return html;
	},
	
	submit: function() {
		if ($("#resultform").validationEngine('validate')) {
			var parent = this.hook.parent();
			var title = parent.find('.wod-title').html();
			var d = parent.find('form #id_date').val();
			var sets = this.hook.find('.sets');
			var myObject = {
		    	name: title,
		    	wod: parent.attr('id'),
		    	date: d,
		    	sets: this.getSetsJson(sets)
			};
			
			var json = JSON.stringify(myObject);
			console.log(json);
			try {
				jQuery.parseJSON(json);
				//self.post(json);
			
			} catch(e) {
				console.log(e);
				alert('there was an error submitting');
			} 
		}
		
	},
	
	getSetsJson: function(sets){
		var self = this;
		var setsArray = [];
		sets.find('div.set').each(function(){
			setsArray.push(self.getRoundsJson($(this)));
		});
		
		return setsArray;
	},
	
	
	
	getRoundsJson: function(rounds) {
		var self = this;
		var roundsArray = [];
		rounds.find('div.round').each( function() {
			roundsArray.push(self.getRoundJson($(this)));
		});
		var roundsObj = {
			'name': rounds.find('.set-name').html(),
			'rds': roundsArray	
		};
		
		return roundsObj;
	},
	
	getRoundJson: function(round) {
		var self = this;
		var roundArray = [];
		
		round.find('div.ex-line').each( function() {
			roundArray.push(self.getExLineJson($(this)));
		});
		
		var roundObj = {
				'exs': roundArray
		};
		
		return roundObj;
		
	},
	
	getExLineJson: function(line) {
		var ex = {
			'name': line.metadata().ex,
			'type': line.metadata().type,
			'type_id': line.metadata().type_id,
			'amount': line.find('.amount-val').val(),
			'measure': line.metadata().measure //,
			//'measure_id': line.metadata().type_id
		};
		
		return ex;
	},
	
	getInputId: function() {
		var id = ' id="id_' + this.idCounter++ + '"';
		return id;
	}
};