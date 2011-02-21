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
			
			this.form.submit(function(e){
				e.preventDefault();
				//ENABLE!!!!!!!
				if ($("#add_w_form").validationEngine('validate')) {
					self.submit();
				}
			});
		},
		
		submit: function(){
			var self = this;
			var myObject = {
			    workout: {
			    	name: 'some workout',
			    	sets: self.getSets(self.sets)
			    }  
			};
			console.log(myObject);
			console.log(JSON.stringify(myObject));
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
				'set_name': rounds.find('span.setname').html(),
				'rounds': roundsArray	
			};
			
			return roundsObj;
		},
		
		getRound: function(round) {
			var self = this;
			var roundArray = [];
			
			round.find('div.ex-line').each( function() {
				roundArray.push(self.getExLine($(this)));
			});
			
			return roundArray;
			
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