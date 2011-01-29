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
}

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
}

var ResultFormSubmit = function(form, button, hook) {
    this.form = $(form);
    this.button = $(button);
    this.button = $(hook);
    this.setup();
}

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
        console.log($(this.form));
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
            data: { 'wod_id': id },
            
        });
    },
    callback: function() {
    	console.log('callback');
    }
}

var Mongo = function(canvas, trigger) {
	this.canvas = $(canvas);
	this.cord = null;
	this.help = null;
	this.multiset = false;
	this.numSets = 1;
	this.setCount = 1;
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
			console.log(type);
			console.log(type.metadata().type_id);
			console.log(type.metadata().type_name);
			console.log(this);
			var typeData = '<input type="hidden" data-type_id="' + type.metadata().type_id + '" data-type_name="' + type.metadata().type_name + '"/>';
			$(this).parent().find('input:hidden').remove();
			$(this).parent().append(typeData);

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
			}
		
		self.setChoice();
		
	},
	setChoice: function() {
		var self = this;
		console.log("YEO");
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
	
	addSet: function() {
		var self = this;
		console.log('Add Set');
		console.log(self.setCount);
		var set = $('<div id="' + self.setCount + '">Set ' + self.setCount + '</div>');
		//self.getRounds().appendTo(set);
		set.append(self.getRoundsNum());
		set.append(self.getRounds());
		set.append(self.getExBox());
		self.sc.append(set);


		
	},
	
	getRoundsNum: function() {
		return $('<p class="num-rounds">Number of Rounds: <input type="text"></p>');
	},
	
	getRounds: function() {
		return $('<div class="round"></div>');
	},
	
	getExBox: function() {
		var ex = $('<div class="ex-line"><span class="excersize">Exercise: <input type="text" class=ex-name></span><span class="ex-data"></span></div>');
		
		ex.find(".ex-name").autocomplete("/ajax/list_exercises/", { multiple: false })
			.result(function(event, item) {
				console.log(event);
				console.log(item[0]);
		        $.ajax({
		            type: 'get',
		            url: '/ajax/get_ex/',
		            success: function(data) {
		            	//console.log($(data).find('select'));
		            	//TIM bind this properly or move it
		            	$('.measurement').live('change', function() {
		            		
		            	});
		            	if(!ex.find('.ex-data').is(':empty')) {
		            		ex.find('.ex-data').empty();
		            	}
		            	ex.find('.ex-data').append(data);
		            	
		            	
		            },
		            data: { 'name': item[0] }	            
		        });
			});
		
		return ex;
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