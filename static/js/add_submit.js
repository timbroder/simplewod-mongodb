var AddSubmit = function(sets, form) {
	this.sets = $(sets);
	this.form = $(form);
	this.setup();
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
			console.log('setup');
			$('#add_w_form').submit(function(e){
				console.log('STOP SUBMITTING!!!');
				//e.preventDefault();
				//ENABLE!!!!!!!
				if ($("#add_w_form").validationEngine('validate')) {
					console.log(self.form.find('#jsoninput').length);
					if (self.form.find('#jsoninput').length > 0) {
						console.log('actually submit?');
						console.log(self.form);
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
			var self = this;
			var myObject = {
			    //workout: {
			    	name: $('#wod_title').html(),
			    	sets: self.getSets(self.sets)
			    //}  
			};
			
			var json = JSON.stringify(myObject);
			console.log(json);
			try {
				jQuery.parseJSON(json);
				self.post(json);
			
			} catch(e) {
				console.log(e);
				alert('there was an error submitting');
			} 
		},
		
		getJsonForm: function(json) {
			return $('<input id="jsoninput" value="' + json + '"></input>').clone();
		},
		
		
		post: function(json) {
//			var self = this;
//			console.log('have json');
//			console.log(json);
//			var input = self.getJsonForm(json);
//			//input.val(json);
//			input.hide();
//			console.log('ready to submit');
//			console.log(json);
//			self.form.append(input);
//			console.log(input);
//			console.log(self.form);
//			self.form.submit();
			
			$.ajax({
				type: 'POST',
				url: '/ajax/add2/',
				success: function(data) {
					//self.addSelectInputIds(data);
					console.log('back?');
					$('#header').find('h2').html('Workout Added');
					$('#canvas').html('put workout desc here or something')
				},
				data: { 'data': json }
			});
		},
		
		getSets: function(sets){
			var self = this;
			var setsArray = [];
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
			var type = line.find('span.type-data input');
			var amount = line.find('span.amount-holder');
			var amount_name = type.metadata().type_name;
			var measure = line.find('select.measure-options:visible option:selected');
			var ex = {
				'name': line.find('input.ex-name').val(),
				'type': amount_name,
				'type_id': type.metadata().type_id,
				'amount': amount.find('input.amount-val').val(),
				'measure': measure.val(),
				'measure_id': measure.metadata().type_id
			};
			
			console.log('rep[s: ');
			console.log(type.metadata().type_has_reps);
			if (type.metadata().type_has_reps == 'True') {
				ex.reps = line.find('.add-reps').find('input').val();
			}
			
			return ex;
			
//			var json = '{"name":"' + line.find('input.ex-name').val() + '","' 
//						+ amount_name + '":"' + amount.find('input.amount-val').val() + '",'
//						+ '"type_id":' + type.metadata().type_id + ','
//						+ 'measure'
//						+ '}';
//			console.log(json);
//			return eval( "(" + json + ")" );

		}
};


$(document).ready(function() {
	//new AddSubmit('#sets_container', '#add_w_form');
});