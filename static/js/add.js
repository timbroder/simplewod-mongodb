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
		this.to.html(this.msg + msg.replace('-', ' '));
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
	            data: { 'wod_id': id },	            
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
            method: 'post',
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
	this.start();
};

Mongo.prototype = {
	start: function(){
		var self = this;
		$('#create_new').live('click', function(){
			self.to1();
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
		
		//self.to1();
	},
	to1: function() {
		var self = this;
		console.log("YEO");
		$.ajax({
			url: '/ajax/add1/',
			success: function(data) {
				self.canvas.html(data);
				self.cord = $('#accordion');
				var setsD = $('#sets_help_msg');
				self.cord.accordion({
					autoHeight: false,
					navigation: true,
					icons: false,
					event: null
				});
				
				
				setsD.dialog(self.help);
				
				$('#sets_help_click').click(function(){
					console.log('click');
					setsD.dialog('open');
					return false;
				});

				

			}
		});
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