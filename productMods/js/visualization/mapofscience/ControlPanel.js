
var ControlPanel = Class.extend({
	init: function(options) {
		this.options = $.extend({}, this.options, options);
		this.initDiv();
	},
	options: {
		divClass: null, // use this to set absolute position and style
		controlPositions: google.maps.ControlPosition.RIGHT_TOP, // Refer to API for alternative value
		map: null, // map to be add to
		jQueryDiv: null // add custom div
	},
	initDiv: function() {
		var opt = this.options;
		if (opt.jQueryDiv == null) {
			opt.jQueryDiv = $(document.createElement('div'));
		}
		
		if (opt.divClass) {
			opt.jQueryDiv.addClass(opt.divClass);
		}
		this.div = opt.jQueryDiv[0];
		opt.map.controls[opt.controlPositions].push(this.div);
	},
	getDiv: function() {
		/* Allow to edit everything start from div level by returning div jquery object */
		return this.options.jQueryDiv;
	},
	hide: function() {
		var div = this.div;
		if (div) {
			div.style.display = "none";
		}
	},
	show: function() {
		var div = this.div;
		if (div) {
			div.style.display = "block";
		}
	}
});

var SliderControlPanel = ControlPanel.extend({
	init: function(options) {
		this._super(options);
		this.initSlider();
	},
	initSlider: function() {
		var me = this;
		var label = $("<div />").width(20).css("font-size", "60%").css("float", "right").text("0");
		var slider = $("<div />").width(150).css("font-size","60%");
		slider.slider({
			slide:  function(event, ui) {
		    	me._setLabel(ui.value);
		    }
		});
		
		this.sliderDiv = slider;
		this.labelDiv = label;
		
		var div = me.getDiv();
		div.css("margin-right", "10px");
		div.append(slider);
		div.append(label);
	},
	getValue: function () {
		return this.sliderDiv.slider( "option", "value" );
	},
	setMin: function(min) {
		this.sliderDiv.slider({
			min: min
		});
	},
	setMax: function(max) {
		this.sliderDiv.slider({
			max: max
		});
	},
	setValue: function(value) {
		this.sliderDiv.slider({
			value: value
		});
		this._setLabel(value);
	},
	_setLabel: function(value) {
		if (value < 1) {
			this.labelDiv.text("0");
        } else {
        	this.labelDiv.text(value);                        
        }
	},
	setChangeEventHandler: function(handlerFunc) {
		this.sliderDiv.slider({ 
			change: handlerFunc
		});
	}
});
