// JavaScript Document
/*!
 * jquery.overlay 1.0.1. Overlay HTML with eyecandy.
 * 
 * Copyright (c) 2009 Tero Piirainen
 * http://flowplayer.org/tools/overlay.html
 *
 * Dual licensed under MIT and GPL 2+ licenses
 * http://www.opensource.org/licenses
 *
 * Launch  : March 2008
 * Version : 1.0.1 - Wed Feb 18 2009 05:18:27 GMT-0000 (GMT+00:00)
 */
(function($) { 
		
	var instances = [];
		
	function fireEvent(opts, name, self, arg) {
		var fn = opts[name];
		
		if ($.isFunction(fn)) {
			try {  
				return fn.call(self, arg);
				
			} catch (error) {
				if (opts.alert) {
					alert("Error calling overlay." + name + ": " + error);
				} else {
					throw error;		
				}
				return false;
			} 					
		}
		return true;			
	}
	
	
	function Overlay(el, opts) {
		
		var self = this; 
		var trigger = null;
		var w = $(window);  
		
		
		// get trigger and overlayed element
		var jq = opts.target || el.attr("rel");
		var o = jq ? $(jq) : null;

		if (!o) { o = el; }	
		else { trigger = el; }
		
		// get growing image
		var bg = o.attr("overlay");
		
		if (!bg) {
			bg = o.css("backgroundImage");
			bg = bg.substring(bg.indexOf("(") + 1, bg.indexOf(")"));
			o.css("backgroundImage", "none");
			o.attr("overlay", bg);			
		}
		
		// growing image is required (on this version) 
		if (!bg) {
			throw "background-image CSS property not set for overlay element: " + jq;
		}
		
		// replace hyphens so that Opera/IE works
		bg = bg.replace(/\"/g, "");
		
		
		// automatic preloading of images
		if (opts.preload) {
			$(window).load(function() { 
				setTimeout(function() {
					var img = new Image();
					img.src = bg;					
				}, 2000);
			});
		}
		
		
		// set initial growing image properties
		var oWidth = o.outerWidth({margin:true});
		var oHeight = o.outerHeight({margin:true});
		
		var img = $('<img src="' + bg + '"/>');
		img.css({border:0,position:'absolute'}).width(oWidth).hide(); 
		
	

		$('body').append(img);   
		

		// trigger action
		if (trigger) {
			trigger.bind("click.overlay", function(e) {
				self.load(e.pageY - w.scrollTop(), e.pageX - w.scrollLeft());
				return e.preventDefault();
			});
		}   		
				
		// close button
		if (!opts.close || !o.find(opts.close).length) {
			o.prepend('<div class="close"></div>');
			opts.close = "div.close";
		} 
		
		var closeButton = o.find(opts.close);		

				
		// API methods  
		$.extend(self, {

			load: function(top, left) {
				
				// one instance visible at once
				if (self.isOpened()) {
					return self;	
				}
				
				if (opts.oneInstance) {
					$.each(instances, function() {
						this.close();
					});
				}
				
				// onBeforeLoad
				if (fireEvent(opts, "onBeforeLoad", self) === false) {
					return self;	
				}				
				
				// start position			
				top = top   || opts.start.top; 					
				left = left || opts.start.left;
				
				
				// finish position 
				var toTop = opts.finish.top;
				var toLeft = opts.finish.left;

				
				if (toTop == 'center') { toTop = Math.max((w.height() - oHeight) / 2 - 30, 0); }
				if (toLeft == 'center') { toLeft = Math.max((w.width() - oWidth) / 2, 0); }
				
				// adjust positioning relative to scrolling position
				if (!opts.start.absolute)  {
					top += w.scrollTop();
					left += w.scrollLeft();
				}
				
				if (!opts.finish.absolute)  {
					toTop += w.scrollTop();
					toLeft += w.scrollLeft();
				}

				
				// initialize background image  
				img.css({top:top, left:left, width: opts.start.width, zIndex: opts.zIndex}).show();
				
				// begin growing
				img.animate({top:toTop, left:toLeft, width: oWidth}, opts.speed, function() { 
		
					// set content on top of the image
					o.css({position:'absolute', top:toTop, left:toLeft}); 
					var z = img.css("zIndex");
					closeButton.add(o).css("zIndex", ++z);
					
					o.fadeIn(opts.fadeInSpeed, function() {  
						fireEvent(opts, "onLoad", self); 	 
					});
					
				});		
				
				
				return self;
				
			}, 
			
			getBackgroundImage: function() {
				return img;	
			},
			
			getContent: function() {
				return o;	
			}, 
			
			getTrigger: function() {
				return trigger;	
			},

			isOpened: function()  {
				return o.is(":visible")	;
			},
			
			// manipulate start, finish and speeds
			getConf: function() {
				return opts;	
			},
			
			close: function() {
				
				if (!self.isOpened()) { return self; }
				
				if (fireEvent(opts, "onClose", self) === false) { return self; }
				
				if (img.is(":visible")) {
					img.hide();
					o.hide();
				}
				
				return self;
			},  
			
			getVersion: function() {
				return [1, 0, 0];	
			},
			
			// @deprecated
			expose: function() {
				img.expose();	
			}
			
		});
		
		
		closeButton.bind("click.overlay", function() { 
			self.close();  
			//$.expose.close();
		});  
				
		
		// keyboard::escape
		w.bind("keypress.overlay", function(evt) {
			if (evt.keyCode == 27) {
				self.close();	
			}
		});		

		
		// when window is clicked outside overlay, we close
		if (opts.closeOnClick) {					
			w.bind("click.overlay", function(evt) {
				if (!o.is(":visible, :animated")) { return; }
				var target = $(evt.target);
				if (target.attr("overlay")) { return; }
				if (target.parents("[overlay]").length) { return; }					
				//self.close(); 
			});						
		}		
		
	}
	
	// jQuery plugin initialization
	jQuery.prototype.overlay = function(conf) {   
		
		// already constructed --> return API
		var api = this.eq(typeof conf == 'number' ? conf : 0).data("overlay");
		if (api) { return api; }	
		
		var w = $(window);  		
		
		var opts = { 
		
			/*
			CALLBACKS: 
			 - onBeforeLoad 
			 - onLoad
			 - onBeforeClose 
			 - onClose 
			*/			
			
			start: {
				// by default: button position || center
				top: Math.round(w.height() / 2), 
				left: Math.round(w.width() / 2),				
				width: 0,
				absolute: false
			},
			
			finish: {
				top: 'center', 
				left: 'center',
				absolute: false
			},   
			
			speed: 'normal',
			fadeInSpeed: 'fast',
			close: null,	
			oneInstance: true,
			closeOnClick: true, 
			preload: true, 
			zIndex: 9999,
			
			// target element to be overlayed. by default taken from [rel]
			target: null, 
			alert: true
		};
		
		if ($.isFunction(conf)) {
			conf = {onBeforeLoad: conf};	
		}
		
		$.extend(true, opts, conf);  
		
		
		this.each(function() {			
			var instance = new Overlay($(this), opts);
			instances.push(instance);
			$(this).data("overlay", instance);	
		});

		
		return this; 
	}; 
	
})(jQuery);

