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
			console.log('setup');
			$('#add_w_form').submit(function(e){
				self.cache.update('wod');
				console.log('STOP SUBMITTING!!!');
				//e.preventDefault();
				//ENABLE!!!!!!!
				if (self.validateInlineEdit() && $("#add_w_form").validationEngine('validate')) {
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
		
		validateInlineEdit: function() {
			console.log('editabletitle');
			console.log($('.editable input'));
			if ($('.editable input').length > 0) {
				alert('please save the edited title');
				return false;
			}
			
			return true;
		},	
		
		submit2: function(){
			console.log("SUBMIT");
			var self = this;
			var myObject = {
			    //workout: {
			    	name: $('#wod_title').html(),
			    	desc: $('#wod_desc textarea').val(),
			    	//measures: self.getMeasures(),
			    	sets: self.getSets(self.sets)
			    //}  
			};
			
			var json = JSON.stringify(myObject);
			console.log(json);
			try {
				console.log('in try');
				console.log('json');
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
			console.log('in post');
			
			
			
			/*$.ajax({
				type: 'POST',
				url: '/ajax/add2/',
				success: function(data) {
					//self.addSelectInputIds(data);
					console.log('back?');
					console.log(data);
					$('#header').find('h2').html('Workout Added');
					var h = '<p>Added: ' + data.title + ' <br>Click <a href="' + data.url + '">here</a> to add a result to it</p>';
					console.log(h);
					$('#canvas').html(h);
					setTimeout("window.location='" + data.url + "'",3000);
				},
				data: { 'data': json },
				dataType: 'json'
			});*/
		},
		
		getScores: function(set) {
			var mArray = [];
			
			console.log('getting scores');
			console.log(set);
			
			set.find('.ui-selected').each(function() {
				var m = $(this);
				mArray.push({
					id: m.data('id'),
					clazz: m.data('clazz'),
					m: m.html()
				});
			});
			console.log('measures');
			console.log(mArray);
			return mArray;
		},
		
		getSets: function(sets){
			var self = this;
			var setsArray = [];
			
			console.log('getting sets');
			sets.find('div.section').each(function(){
				setsArray.push(self.getRounds($(this)));
			});
			
			return setsArray;
		},
		
		getRounds: function(rounds) {
			var self = this,
				roundsArray = [];
			
			rounds.find('div.round').each( function() {
				roundsArray.push(self.getRound($(this)));
			});
			console.log(rounds);
			var roundsObj = {
				'name': rounds.find('span.setname').html(),
				//'scores': self.getScores(rounds.parent().find('.set_score')),
				'scores': self.getScores(rounds.next('.set_score')),
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
			console.log('1');
			console.log(line);
			var type = line.find('span.type-data input');
			var amount = line.find('span.amount-holder');
			var amount_name = type.metadata().type_name;
			var measure;
			try {
				measure = line.find('select.measure-options:visible option:selected');
				measure.metadata().type_id;
			} catch(e) {
				console.log('c');
				console.log(e);
				measure = line.find('.measure-options option:eq(1)');
			}
			
			
			console.log(measure);
			console.log('getting ex');
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
			if (type.metadata().type_has_reps === 'True') {
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