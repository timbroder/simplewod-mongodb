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
        console.log('self.click');
        var id = self.trigger.attr('id');
        $.ajax({
            method: 'post',
            url: '/ajax/addresultform/',
            success: function(data) {
                self.callback(data);
            },
            data: { 'wod_id': id },
            
        });
    },
    callback: function(data){
        this.hook.html(data);
    }
}

var ResultFormSubmit = function(form, button) {
    this.form = $(form)
    this.button = $(button);
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
        console.log(self.form.find('#id_date').val());
        console.log(this.form.find('#id_results').val());
        console.log(self.form.find('#id_tags').val());
       /* $.ajax({
            method: 'post',
            url: '/ajax/addresultform/',
            success: function(data) {
                self.callback(data);
            },
            data: { 'wod_id': id },
            
        });*/
    },
    callback: function() {
    
    }
}

$(document).ready(function() {
	new ResultToggle('#toggle_result');
	new TagSync('#id_wod_tags', '#tags_from_wod');
    new AddResultForm('.add_result', '#result_form');
    new ResultFormSubmit('#ajaxaddform', '#ajaxaddform #submit');
    
    var d = new Date();
	$("#id_date").live('click', function(){
        $(this).datepicker();
    });
});


$(function(){
	//$("#addform").form();
	//date picker
	//var d = new Date();
	//$("#id_date").datepicker();
});