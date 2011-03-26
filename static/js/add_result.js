var LiveUpdate = function(input, output) {
	this.total = 0;
	this.input = input;
	this.output = output;
	this.setup();
};

LiveUpdate.prototype = {
	setup: function() {
		var self = this;
		this.update();
		
		this.input.live('keyup', function(){
			self.update();
		});
	},
	
	update: function() {
		var self = this,
			intRegex = /^\d+$/;
		self.total = 0;
		self.input.each(function() {
			if(intRegex.test($(this).val())) {
				self.total += parseInt($(this).val())*1;
			}
		});
		
		self.output.val(self.total);
		
	}
};


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
			$(this).hide();
		});
		
		$('#addresult').live('click', function(e){
			e.preventDefault();
			self.submit();
		});
		
		$('#cancelresult').live('click', function() {
			self.cancel();
		});
		
		//FIX
		//remove
		self.click();
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
					self.buildform(form, resp);
				}
		});

	},
	
	cancel: function() {
		this.hook.empty();
		$('a.add_result').show();
	},
	
	buildform: function(form, resp) {
		var self = this,
			html = '',
			totalweight = 0,
			totalreps = 0
			;
		
		html += self.getSets(resp);
		html += self.getMeasures(resp);
		html += self.getOptional();
		html += self.getSubmit();
		form.append(html);
		
		totalweight = $('input.totalweight');
		totalreps = $('input.totalreps');
		
		if (totalweight.length > 0) {
			new LiveUpdate($('.ex-line[data-type="Weight"] input.amount-val'), totalweight);
		}
		
		if (totalreps.length > 0) {
			new LiveUpdate($('input.num-reps'), totalreps);
		}
		
		$('.totaltime').timepicker({
			showSecond: true,
			timeFormat: 'hh:mm:ss'
		});

	},
	
	getMeasures: function(root) {
		var ids = [],
			i,
			l = root.measures.length,
			req,
			html = '';
		
		for (i=0; i<l; i++) {
			ids.push(root.measures[i].id);
		}
		req = $.ajax('/ajax/get_measures.json/', {
			data: { "ms": ids.toString() },
			type: 'GET',
			async: false
			//dataType: 'json'
		})
		.success( function(resp) {
			html = resp;
		});
		return html;
	},
	
	getOptional: function() {
		var html = '<div>Location: <input type="text" id="loc" /></div>';
		html += '<div><p>Notes</p><textarea id="notes" />';
		
		html += '<br/>';
		return html;
	},
	
	getForm: function() {
		var form = $('<form id="resultform"></form>');
		form.validationEngine();
		return form.clone();
	},
	
	getSubmit: function() {
		return '<input id="cancelresult" type="button" name="cancel" value="cancel" /> <input id="addresult" type="submit" name="submit" value="submit" />';
	},
	
	getDatePicker: function() {
		var picker =  $('<div>Date/Time Completed <input type="text" id="id_date" name="date" class="validate[required]"></div>').clone();
		picker.find('#id_date').datetimepicker({
			ampm: true
			//,
			//hourGrid: 4,
			//minuteGrid: 10
		});

		
		return picker;
	},
	
	getSets: function(root) {
		var html = '<section class="sets">',
			i,
			l = root.sets.length;
		
		for (i = 0; i < l; i++) {
			set = root.sets[i];
			html += '<div class="set">' +
					'<h4 class="set-name">' + set.name + '</h4>';
			html += this.getRounds(set.rds);
			html += '<hr><hr></div>';
		}
		
		html += '<hr><hr><hr></section>';
		
		return html;
	},
	
	getRounds: function(rounds) {
		var html = '',
			i,
			l = rounds.length;
		
		for (i = 0; i < l; i++) {
			html += '<div class="round">';
			html += this.getEx(rounds[i]);
			html += '<hr></div>';
		}
		return html;
	},
	
	getEx: function(rnd) {
		var html = '',
			i,
			l = rnd.exs.length;
		
		for (i = 0; i < l; i++){
			var ex = rnd.exs[i];
			html += '<div class="ex-line" data-ex="' + ex.name + '" data-type_id="' + ex.type_id + '" data-type="' + ex.type + '" data-measure="' + ex.measure + '" data-type_has_reps="' + ex.type_has_reps + '">';
			html += ex.name + ' ';
			if (ex.type != 'Count') {
				html += '<input type="text" class="amount-val validate[required]" value="' + ex.amount + '"' + this.getInputId() + '>';
				html += ' 	' + ex.measure;
			}
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
			try {
				jQuery.parseJSON(json);
				//self.post(json);
			
			} catch(e) {
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
			'name': line.data('ex'),
			'type': line.data('type'),
			'type_id': line.data('type_id'),
			'amount': line.find('.amount-val').val(),
			'measure': line.data('measure') //,
			//'measure_id': line.metadata().type_id
		};
		
		return ex;
	},
	
	getInputId: function() {
		var id = ' id="id_' + this.idCounter++ + '"';
		return id;
	}
};

//$(function(){
//	new AddResultForm('.add_result', '#result_form');
//});