var ResultToggle = function(trigger) {
	this.trigger = $(trigger);
	this.setup();
};

ResultToggle.prototype = {
		setup: function(){
			var self = this;
			this.trigger.bind('click', function(){
				self.click();
			});
		},
		click : function(){
			var hasResult = $('#id_has_result');
			var result = $('#form_result');
			var rtxt = $('#result_text');

			if(hasResult.val() == 'True'){
				result.slideUp();
				rtxt.html('Want to add a result also? ');
				hasResult.val('False');
			}
			else{
				result.slideDown();
				rtxt.html('Add Workout Only? ');
				hasResult.val('True');
			}
		}
};

var TagSync = function(from, to) {
	this.to = $(to);
	this.from = $(from);
	this.msg = 'Tags included from Workout: ';
	this.setup();
};

TagSync.prototype = {
		setup: function(){
			var self = this;
			self.from.keyup(function() {
				self.update(this.value );
			});
			self.from.blur(function() {
				self.update(this.value );
			});
			self.from.click(function() {
				self.update(this.value );
			});

			/*$('.ac_results').live('click', function() {
			console.log('hi');
		    //self.update(this.value );
		});*/
			$('body').bind('autocompleteClick', function(e) {
				self.update(self.from.val() );
			});

		},
		update: function(msg){
			//this.to.html(this.msg + msg.replace('-', ' '));
		}
};

var AddResultForm = function(trigger, hook) {
	this.trigger = $(trigger);
	this.hook = $(hook);
	this.setup();
};

AddResultForm.prototype = {
		setup: function() {
			var self = this;
			this.trigger.bind('click', function(){
				self.click();
			});
		},
		click: function() {
			var self = this;
			var id = self.trigger.attr('id');

			if (!this.hook.hasClass('shown') && !this.hook.hasClass('once')) {
				$.ajax({
					method: 'post',
					url: '/ajax/addresultform/',
					success: function(data) {
						self.callback(data);
					},
					data: { 'wod_id': id }        
				});
				this.hook.addClass('once');    		
				this.hook.addClass('shown');
			}
			else if (this.hook.hasClass('once') && this.hook.hasClass('shown')) {
				this.hook.hide();
				this.hook.removeClass('shown');
			}
			else {
				this.hook.show();
				this.hook.addClass('shown');
			}

		},
		callback: function(data){    
			var self = this;
			this.hook.html(data);
			this.hook.find('#cancel').bind('click', function(){
				self.click();
			});
		}
};

var ResultFormSubmit = function(form, button, hook) {
	this.form = $(form);
	this.button = $(button);
	this.button = $(hook);
	this.setup();
};

ResultFormSubmit.prototype = {
		setup: function() {
			var self = this;
			console.log(this);
			this.button.live('click', function(event){
				event.preventDefault();
				//self.button.disable();
				console.log('clicked');


				self.click();
				return false;
			});
		},
		click: function() {
			var self = this;
			console.log('self.clicked');
			//console.log($(this.form));
			var dt = $('#id_date').val();
			var results = $('#id_results').val();
			var tags = $('#id_tags').val();
			var wod_id = $('#wodid').val();
			$.ajax({
				type: 'get',
				url: '/ajax/addresultform/',
				success: function(data) {
					self.callback(data);
				},
				data: { 'wod_id': id }

			});
		},
		callback: function() {
			console.log('callback');
		}
};

var Mongo = function(canvas, trigger) {
	this.canvas = $(canvas);
	this.cord = null;
	this.help = null;
	this.multiset = false;
	this.numSets = 1;
	this.setCount = 1;
	this.fadeTime = 500;

	this.start();
};

Mongo.prototype = {
		start: function(){
			var self = this;
			$('#create_new').live('click', function(){
				self.setChoice();
			});

			$('.type-data select').live('change', function() {
				var type = $(this).find('option:selected');

				var typeData = '<input type="hidden" data-type_id="' + type.metadata().type_id + '" data-type_name="\'' + type.metadata().type_name + '\'"/>';
				$(this).parent().find('input:hidden').remove();
				$(this).parent().append(typeData);

				self.getExBox2($(this).parent().parent());
			});

			$('.add-ex').live('click', function() {
				self.addEx(this);
			});
			
			$('.add-rest').live('click', function() {
				self.addEx(this, true);
			});

			$('.remove-line').live('click', function(){
				self.removeEx($(this));
			});

			$('.add-round-control').live('click', function() {
				self.addRound($(this));
			});

			$('.remove-round-control').live('click', function() {
				self.removeRound($(this));
			});

			$('.add-all-rounds-control').live('click', function() {
				self.addAllRounds($(this));
			});

			$('.ex-name').live('click', function() {
				self.boxClick($(this));
			});

			$('.add-set-control').live('click', function() {
				self.addAnotherSet($(this));
			});

			this.help = {
					modal: true,
					draggable: false,
					resizable: false,
					autoOpen: false,
					show: "fade",
					hide: "fade",
					buttons: {
						Close: function() {
							$( this ).dialog( "close" );
						}
					}
			};

			self.setChoice();

		},
		setChoice: function() {
			var self = this;
			//console.log("YEO");
			$.ajax({
				url: '/ajax/add1/',
				success: function(data) {
					self.canvas.html(data);
					/*self.cord = $('#accordion');

				self.cord.accordion({
					autoHeight: false,
					navigation: true,
					icons: false,
					event: null
				});*/

					var setsD = $('#sets_help_msg');
					setsD.dialog(self.help);

					$('#sets_help_click').click(function(){
						console.log('click');
						setsD.dialog('open');
						return false;
					});
					$('#name_complete').click(function(){
						self.nameComplete();
					});

					$('#one_set').click(function(){
						self.setSingleSet();
					});

					$('#multiple_sets').click(function(){
						self.setMultiSet();
					});

					self.startSets();

				}
			});
		},

		setSingleSet: function() {
			console.log('single');
			this.afterSetChoice();
		},

		setMultiSet: function() {
			console.log('multi');
			this.multiset = true;
			$('#set1_header').html('Set 1 Rounds');
			this.afterSetChoice();
		},

		afterSetChoice: function() {
			var self = this;
			console.log('slide');
			console.log(self.cord);
			self.cord.accordion('activate' , 2);
		},

		nameComplete: function() {
			$('#name_header').html($('#wod_name').val());
			this.cord.accordion('activate' , 1);
		},

		startSets: function(){
			var self = this;
			self.sc = $('#sets_container');
			//console.log(sc);
			self.numSets++;
			console.log('Sets: ' + self.numSets);
			//$("#id_wod_tags").autocomplete("/tagging_autocomplete/json", { multiple: true });
			self.addSet();
		},

		getSet: function() {
			return $('<div class="section"><span class="setname">Set ' + this.setCount++ + '</span></div>').clone();
		},

		getSetControl: function() {
			return $('<div class="section-control"><hr><a href="#" class="add-set-control">Add Set</a></div>').clone();
		},

		addSet: function() {
			var self = this;
			console.log('Add Set');
			console.log(self.setCount);
			var set = self.getSet();
			var setControl = self.getSetControl();
			//self.getRounds().appendTo(set);
			//set.append(self.getRoundsNum());

			var round = self.getRound();
			round.append(self.getExBox());
			set.append(round);
			set.append(self.getRoundControl());
			self.sc.append(set);
			self.sc.append(setControl);



		},

		addAnotherSet: function(trigger) {
			var self = this;
			var currSet = trigger.parent();
			var set = self.getSet();
			var setControl = self.getSetControl();
			var round = self.getRound();

			round.append(self.getExBox());
			set.append(round);
			set.append(self.getRoundControl());

			currSet.after(setControl);
			currSet.after(set);



		},

		getRoundsNum: function() {
			return $('<p class="num-rounds">Number of Rounds: <input type="text"></p>');
		},

		getRound: function() {
			return $('<div class="round"></div>');
		},

		getRoundControl: function() {
			return $('<div class="round-control"><a href="#" class="add-round-control">Add Round</a> | <a href="#" class="add-all-rounds-control">Add all Rounds</a> | <a href="#" class="remove-round-control">Remove Round</a><hr></div>').clone();
		},
		
		getEx: function(){
			return $('<div class="ex-line"><span class="remove-ex-btn">(<a href="#" class="remove-line">X</a>)&nbsp;</span><span class="excersize">Exercise: <input type="text" class=ex-name></span><span class="ex-data"></span></div>').clone();
		},

		getExBox: function() {
			var self = this;
			var ex = self.getEx();

			ex.find(".ex-name").autocomplete("/ajax/list_exercises/", { multiple: false })
			.result(function(event, item) {
				//console.log(event);
				//console.log(item[0]);
				var box = $(this);

				console.log('selected');
				console.log(this);
				console.log(item[0]);


				/*box.bind('click', function(){ 
					console.log('clicked');
					var answer = confirm("Would you like to change this exercise? This will remove and reps and information you have added.");
					if (answer) {
						var remove = $(this).parent().parent().find('.ex-data');
						remove.fadeOut(self.fadeTime, function() { remove.empty(); });
						remove.fadeIn();
						box.removeAttr("readonly"); 
						box.unbind('click');
					}
				});*/

				//box.attr("disabled", "disabled");
				box.attr('readonly', true);
				//ex.find(".ex-name").autocomplete({ disabled: true });

				$.ajax({
					type: 'get',
					url: '/ajax/get_ex/',
					success: function(data) {
						self.getExBoxData(ex, data);
					},
					data: { 'name': item[0] }	            
				});
			});

			return ex;
		},
		
		getExBoxData: function(ex, data) {
			var self = this;
			console.log('back');
			var exdata = ex.find('.ex-data');
			console.log(exdata);
			//console.log($(data).find('select'));
			//TIM bind this properly or move it
			//$('.measurement').live('change', function() {

			//});
			if(!exdata.is(':empty')) {
				exdata.empty();
			}
			exdata.append(data);
			console.log('looking for single');
			console.log($(data).find('select:not(.opsbase)'));
			if (!$(data).find('select:not(.opsbase)').length) {
				console.log('single');
				console.log(exdata);
				//console.log(data);
				self.getExBox2(exdata);
			}
		},

		getAddButton: function() {
			return $('<span class="add-s">&nbsp; Add: <a href="#" class="add-ex">Exercise</a>, <a href="#" class="add-rest">Rest</a></span>');
		},

		getExBox2: function(hook) {
			console.log('continue');
			//console.log(hook);
			var self = this;
			if (!hook.find('.amount-holder').length) {
				hook.append('<span class="amount-holder"></span>');
			}
			else {
				hook.find('.amount-holder').empty();
			}
			amount = hook.find('.amount-holder');
			amount.append('<input type="text" class="amount-val"/>');
			var id = hook.find('.type-data input').metadata().type_id;
			hook.find('.measure-options:not(.opsbase)').remove();
			hook.find('.measure-all-options select[data-type_id=' + id + ']').clone().removeClass('opsbase').appendTo(hook);
			self.getAddButton().clone().appendTo(hook);

		},

		validateExRow: function() {
			return true;
		},

		areEmptyExs: function() {
			//check empty name, ---- in any selects, and values and shit
			console.log($('.ex-name:input[value=""]').length);
			if ($('.ex-name:input[value=""]').length > 0) {
				//validate
				alert('please fill in the empty exercize');
				return true;
			}
			return false;
		},

		addEx: function(start, rest) {
			rest = rest || false;
			var self = this;
			console.log('add ex');
			console.log(start);
			if (!self.validateExRow()) {
				return false;
			}

			if (self.areEmptyExs()) {
				return false;
			}


			hook = $(start).parent().parent().parent();

			//console.log(hook);
			if (rest) {
				var key = 'Rest';
				var r = this.getExBox();
				var input = r.find('input.ex-name');
				input.val(key);
				input.attr('readonly', true);
				$.ajax({
					type: 'get',
					url: '/ajax/get_ex/',
					success: function(data) {
						self.getExBoxData(r, data);
					},
					data: { 'name': key }	            
				});
				hook.after(r);
			}
			else {
				hook.after(this.getExBox());
				console.log($('.ex-name:input[value=""]').length);
			}

		},

		removeEx: function(trigger) {
			var line = trigger.parent().parent();
			console.log(line);
			console.log(line.find('.ex-name').val());
			var ques = 'Are you sure you want to delete this excersize?';
			if (line.find('.ex-name').val()) {
				ques += ' (' + line.find('.ex-name').val() + ')';
			}
			var answer = confirm(ques);

			if (answer) {
				var round = line.parent();
				console.log(round);
				line.remove();
				console.log(round.find('.ex-line'));
				if (round.find('.ex-line').length == 0) {
					round.append(this.getExBox());
				}
			}

		},

		addRound: function(trigger) {
			console.log('add round');
			this.addMultiRounds(trigger, 1);
		},

		addMultiRounds: function(trigger, num) {
			console.log("addrounds: " + num);
			var set = trigger.parent();//.parent();
			var round = null;
			var control = null;
			console.log(round);
			var self = this;
			if (self.areEmptyExs()) {
				return false;
			}
			for (var i=0; i<num; i++) {
				console.log('i ' + i);
				round = trigger.parent().prev().clone();
				control = trigger.parent().clone();
				set.after(control);
				set.after(round);
			}

		},

		removeRound: function(trigger) {
			var set = trigger.parent().parent();
			console.log(set);

			if (set.find('.round').length == 1) {
				alert('Cannot remove round, there has to be at least 1 in a set');
				return false;
			}

			var answer = confirm('Are you sure you want to remove the round?');

			if (answer) {
				var round = trigger.parent().prev();
				var control = trigger.parent();

				round.remove();
				control.remove();
			}

		},

		addAllRounds: function(trigger) {
			console.log('add all rounds');
			var self = this;
			if (self.areEmptyExs()) {
				return false;
			}
			if($('.round').length > 1) {
				alert('This will only work if you have 1 round in this set.');
				return;
			}
			var p = "Enter the total number of rounds for this set: ";
			var num = prompt(p, "");
			console.log(num);
			if (num == null || num == "") {
				alert('you must enter a number');
				return;
			}

			if (num != parseInt(num)) {
				alert('you must enter a number');
				return
			}

			if (num < 1) {
				alert('you must enter a number greater then 0');
				return;
			}

			this.addMultiRounds(trigger, num-1);
		},

		boxClick: function(trigger) {
			//trigger.bind('click', function(){ 
			console.log('clicked');
			console.log(trigger.attr('readonly'));
			if(trigger.attr('readonly')) {
				var answer = confirm("Would you like to change this exercise? This will remove and reps and information you have added.");
				if (answer) {
					var remove = trigger.parent().parent().find('.ex-data');
					remove.fadeOut(self.fadeTime, function() { remove.empty(); });
					remove.fadeIn();
					trigger.removeAttr("readonly"); 
					trigger.unbind('click');
				}
			}
			//});
		}
}

$(document).ready(function() {
	new ResultToggle('#toggle_result');
	new TagSync('#id_wod_tags', '#tags_from_wod');
	new AddResultForm('.add_result', '#result_form');
	//new ResultFormSubmit('#ajaxaddform', '#ajaxaddform #submit', '#result_form');
	new Mongo('#canvas');

	$("#id_date").live('focus', function(){
		$(this).datepicker();
	});

});


//$(function(){
//$("#addform").form();
//date picker
//var d = new Date();
//$("#id_date").datepicker();
//});