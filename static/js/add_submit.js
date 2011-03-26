var AddSubmit = function(sets, form) {
	this.sets = $(sets);
	this.form = $(form);
	this.setup();
	this.cache = new LocalCache();
};

AddSubmit.prototype = {
		setup: function(){
			var self = this;
//			var myObject = {
//			    workout: {
//			    	name: 'some workout',
//			    	sets: ['sdsdsd', 'sdsd']
//			    }  
//			};
//			    
//			    
//			myJSONText = JSON.stringify(myObject);
//
			window.log('setup');
			$('#add_w_form').submit(function(e){
				self.cache.update('wod');
				window.log('STOP SUBMITTING!!!');
				//e.preventDefault();
				//ENABLE!!!!!!!
				if ($("#add_w_form").validationEngine('validate')) {
					window.log(self.form.find('#jsoninput').length);
					if (self.form.find('#jsoninput').length > 0) {
						window.log('actually submit?');
						window.log(self.form);
						//e.enableDefault();
						return true;
					}
					self.submit2();
					return false;
				}
				return false;
			});
		},
		
		submit2: function(){
			window.log("SUBMIT");
			var self = this;
			var myObject = {
			    //workout: {
			    	name: $('#wod_title').html(),
			    	desc: $('#wod_desc textarea').val(),
			    	measures: self.getMeasures(),
			    	sets: self.getSets(self.sets)
			    //}  
			};
			
			var json = JSON.stringify(myObject);
			window.log(json);
			try {
				window.log('in try');
				jQuery.parseJSON(json);
				self.post(json);
			
			} catch(e) {
				window.log(e);
				alert('there was an error submitting');
			} 
		},
		
		getJsonForm: function(json) {
			return $('<input id="jsoninput" value="' + json + '"></input>').clone();
		},
		
		
		post: function(json) {
//			var self = this;
//			window.log('have json');
//			window.log(json);
//			var input = self.getJsonForm(json);
//			//input.val(json);
//			input.hide();
//			window.log('ready to submit');
//			window.log(json);
//			self.form.append(input);
//			window.log(input);
//			window.log(self.form);
//			self.form.submit();
			window.log('in post');
			$.ajax({
				type: 'POST',
				url: '/ajax/add2/',
				success: function(data) {
					//self.addSelectInputIds(data);
					window.log('back?');
					$('#header').find('h2').html('Workout Added');
					$('#canvas').html('put workout desc here or something');
				},
				data: { 'data': json }
			});
		},
		
		getMeasures: function() {
			var mArray = [];
			$('#wod_measure').find('.ui-selected').each(function() {
				var m = $(this);
				mArray.push({
					id: m.metadata().id,
					m: m.html()
				});
			});
			window.log('measures');
			window.log(mArray);
			return mArray;
		},
		
		getSets: function(sets){
			var self = this;
			var setsArray = [];
			
			window.log('getting sets');
			sets.find('div.section').each(function(){
				setsArray.push(self.getRounds($(this)));
			});
			
			return setsArray;
		},
		
		getRounds: function(rounds) {
			var self = this;
			var roundsArray = [];
			rounds.find('div.round').each( function() {
				roundsArray.push(self.getRound($(this)));
			});
			
			var roundsObj = {
				'name': rounds.find('span.setname').html(),
				'rds': roundsArray	
			};
			
			return roundsObj;
		},
		
		getRound: function(round) {
			var self = this;
			var roundArray = [];
			
			round.find('div.ex-line').each( function() {
				roundArray.push(self.getExLine($(this)));
			});
			
			var roundObj = {
					'exs': roundArray
			};
			
			return roundObj;
			
		},
		
		getExLine: function(line) {
			window.log('1');
			window.log(line);
			var type = line.find('span.type-data input');
			var amount = line.find('span.amount-holder');
			var amount_name = type.metadata().type_name;
			var measure;
			try {
				measure = line.find('select.measure-options:visible option:selected');
				measure.metadata().type_id;
			} catch(e) {
				window.log('c');
				window.log(e);
				measure = line.find('.measure-options option:eq(1)');
			}
			
			
			window.log(measure);
			window.log('getting ex');
			var ex = {
				'name': line.find('input.ex-name').val(),
				'type': amount_name,
				'type_id': type.metadata().type_id,
				'amount': amount.find('input.amount-val').val(),
				'measure': measure.val(),
				'measure_id': measure.metadata().type_id
			};
			
			window.log('rep[s: ');
			window.log(type.metadata().type_has_reps);
			if (type.metadata().type_has_reps === 'True') {
				ex.reps = line.find('.add-reps').find('input').val();
			}
			
			return ex;
			
//			var json = '{"name":"' + line.find('input.ex-name').val() + '","' 
//						+ amount_name + '":"' + amount.find('input.amount-val').val() + '",'
//						+ '"type_id":' + type.metadata().type_id + ','
//						+ 'measure'
//						+ '}';
//			window.log(json);
//			return eval( "(" + json + ")" );

		}
};


$(document).ready(function() {
	//new AddSubmit('#sets_container', '#add_w_form');
});