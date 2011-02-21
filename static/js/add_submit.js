var AddSubmit = function(sets, form) {
	this.sets = $(sets);
	this.form = $(form);
	this.setup();
};

AddSubmit.prototype = {
		setup: function(){
			var self = this;
			console.log('form');
			console.log(this.form);
//			
//			console.log('start');
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
//			console.log(myJSONText);
			
			this.form.submit(function(e){
				e.preventDefault();
				if ($("#add_w_form").validationEngine('validate')) {
					console.log('yea');
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
			console.log('getSets');
			console.log(sets);
			var setsArray = [];
			sets.find('div.section').each(function(){
//				var setOb = 
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
			return 'an ex';
		}
};


$(document).ready(function() {
	//new AddSubmit('#sets_container', '#add_w_form');
});