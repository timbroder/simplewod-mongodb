/** sidebar filters **/

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
	Exes.each( function(ex) {
		var view = new TodoView({model: ex});
		this.$("#exfilters").append(view.render().el);

	});
});

/** main wod filtering **/
window.Wod = Backbone.Model.extend({});

window.WodList = Backbone.Collection.extend({
	model: Wod,
	url: 'http://localhost:27080/simplewod/wods/'
});
