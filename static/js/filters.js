window.Ex = Backbone.Model.extend({
	defaults: {
		'active': false
	},
	
	toggle: function() {
		this.set({'active': !this.get('active')}, {silent: true});
	}
});

window.ExList = Backbone.Collection.extend({
	model: Ex,
	url: '/xml/exercise/',
	
	checkAll: function(instance) {
		var changed = [instance];
		console.log(instance.get('pk'));
		if (instance.get('pk') == 0) {
			this.each(function(e) {
				if (e.get('active') && e.get('pk') != 0) {
					e.set({'active': false});
				}
			});
		}
		else {
			var all = this.find(function(e) { return e.get('pk') == 0; });
			if (all.get('active') == true ) {
				all.set({'active': false});
			}
		}
		instance.change();
		
	}
});

window.TodoView = Backbone.View.extend({
	tagName:  "p",
	template: _.template($('#ex-template').html()),
	
	initialize: function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
		this.model.view = this;
	},
	
	events: {
		"click": "toggleActive"
	},
	
	toggleActive: function() {
		console.log('toggleActive');
		this.model.toggle();
		Exes.trigger('change:all', this.model);
		//Exes.checkAll(this.model);
	},
	
	render: function() {
		//console.log('rendering');
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	}
});

window.Exes = new ExList;

Exes.bind("change:all", function(instance){
	this.checkAll(instance);
});

	
$(function() {
	console.log(Exes.length);
	Exes.each( function(ex) {
		var view = new TodoView({model: ex});
		this.$("#exfilters").append(view.render().el);

	});
});

/*

var inputs = {
	exes: Array(),
	timing: new Date().getTime()
};

var WodList = function(section) {
	this.section = $(section);
	this.waitTime = 1000;
	this.now = new Date().getTime();
};

WodList.prototype = {
	update: function() {
		if (this.canUpdate()) {
			this.section.empty();
			console.log(inputs.exes);
			var req = $.ajax('/ajax/wods_list.json/', {
	            data : { 'json' : JSON.stringify(inputs) },
	            //dataType : 'json',
	            type : 'POST'
			});
		}
	},
	
	canUpdate: function() {
		now = new Date().getTime();
		if (now - this.now < this.waitTime) {
			console.log('should not update');
			return setTimeout(this.canUpdate, this.waitTime/4)
		}

		this.now = new Date().getTime();
		return true;
	}
};

var CheckboxFilter = function(section) {
	this.section = $(section);
	this.exes = this.section.find('.ex');
	this.all = this.section.find('.exall');
	this.setup();
};

CheckboxFilter.prototype = {
	setup: function() {
		var self = this;
		console.log(self.section.find('.ex'));
		self.exes.live('change', function() {
			self.fixAll($(this));
			self.getChecked();
		});
	},
	
	getChecked: function() {
		var self = this;
		var exes = Array();
		console.log(this.section.find(".ex:checked"));
		this.section.find(".ex:checked").each( function() {
			exes.push($(this).data('id'));
		});
		console.log(exes);
		console.log("!");
		//$.publish('/filter/exes', [exes]);
		inputs.exes = exes;
		$.publish('/filter/go', null);
	},
	
	fixAll: function(box) {
		var self = this;
		if (box.is(':checked')) {
			if(box.data('id') == 0 ){
				self.section.find(".ex:checked").not(box).each( function() {
					$(this).attr('checked', false);
				});
			}
			else {
				self.all.attr('checked', false);
			}
		}
	},
	
	disable: function() {
		this.exes.attr("disabled", true);

	},
	
	enable: function() {
		this.exes.removeAttr("disabled");
	}
};



$(function() {
	var exChoice = new CheckboxFilter('#exfilters');
	var main = new WodList('#main');

	$.subscribe('/filter/go', function(results) {
		$.publish('/ui/disable', null);
		//ajaxness
		main.update();
		$.publish('/ui/enable', null);
	});
	
	$.subscribe('/ui/disable', function(results) {
		exChoice.disable();
	});
	
	$.subscribe('/ui/enable', function(results) {
		exChoice.enable();
	});
	
});*/