var LocalCache = function() {
	this.initCache();
	this.debug = true;
};

LocalCache.prototype = {
		initCache: function() {
			if (Modernizr.localstorage) {
				window.log('ready for local storage');
				this.enabled = true;
			} 
			else {
				  window.log('not ready for local storage');
				  this.enabled = false;
			}
		},
		
		update: function(key) {
			if (this.enabled) {
				if (this.debug) window.log('update ' + key);
				//if request.user = localStorage.getItem("user");
				//window.log(localStorage.getItem(key));
				localStorage.setItem(key, $('#canvas').html());
			}
		},
		
		get: function(key) {
			if (this.enabled) {
				if (this.debug) window.log('get ' + key);
				$('#canvas').html(localStorage.getItem(key));
			}
		},
		
		has: function(key) {
			if (this.enabled) {
				if (this.debug) window.log('has ' + key);
				if (localStorage.getItem(key)){
					return true;
				}
			}
		},
		
		remove: function(key) {	
			if (this.enabled) {
				if (this.debug) window.log('remove ' + key);
				localStorage.removeItem(key);
			}
		}
};