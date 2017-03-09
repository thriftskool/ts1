(function($){
	$.fn.ariyValidate = function (options) {
		return this.each(function () {
			$.ariyValidate(this,options); 
		});
	};   
	$.ariyValidate = function(inp,options) {
		var defaults = {
			type: "price",
			error_message: "Price only",
			disable_message: false,
			on_error: function(str) {}
		}
		options = jQuery.extend(defaults, options);
		inp.options = options;
		if (!inp.options.disable_message) inp.errmes = $('<span style="color: red;"></span>');
		switch (inp.options.type) {
			case "price":
                            	
                                inp.rexp = /^-*(-?[0-9])*[0-9]*(\.[0-9]{0,4})?$/;
				break;
			case "integer":
				inp.rexp = /^[0-9]*$/;
				break;
			case "float":
				inp.rexp = /^[0-9]*(\.[0-9]*)?$/;
				break;
			default:
				inp.rexp = /\d*/;
				break
		}
		
		$(inp).after(inp.errmes);
		inp.check = function() {
			if  (!inp.rexp.test($(inp).val())) {
				if (!inp.options.disable_message) 
					inp.errmes.html(inp.options.error_message).show().fadeOut("slow"); 
				inp.options.on_error($(inp).val());
				$(inp).val(inp.old);
			}
		}

		$(inp).keypress(function (e) {
			setTimeout(inp.check, 1);
			inp.old = $(inp).val();
                        
			return true;
		});
		inp.old = $(inp).val();
                
	}
})(jQuery);