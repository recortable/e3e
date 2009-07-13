(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {},
            debug : function() {}
        };
    }

    var rules = {};

    $.rule = function(name, method) {
        console.log("Adding rule: " + name);
        rules[name] = method;
    }


    $.fn.fires = function() {
        var names = arguments;
        return this.change(function() {
            for (var index = 0; index < names.length; index++) {
                var name = names[index];
                console.log("Applying " + name);
                rules[name].apply();
            }
        });
    };

    $.when = function(condition, action) {
        return function() {
            if (condition.call()) action.call();
        }
    };

    $.checked = function(selector) {
        return function() {
            $(selector).attr('checked');
        }
    };
    $.not_checked = function(selector) {
        return function() {
            $(selector).attr('checked');
        }
    };

    $.enable = function(selector) {
        return function() {
            setEnabled(true, selector);
        }
    }
    $.disable = function(selector) {
        return function() {
            setEnabled(false, selector); 
        }
    }

    $.applyRules = function() {
        console.log("Init activeform");
        $.each(rules, function(name) {
            console.log("Applying rule: " + name);
            this.apply();
        });
    };

    var setEnabled = function(isEnabled, selector) {
        console.log("Enabled: " + isEnabled);
        console.debug(selector);
        if (isEnabled) {
            $(selector).removeClass("disabled");
        } else {
            $(selector).addClass("disabled");
        }
        $(selector).find("input").attr("disabled", !isEnabled);
    };
})(jQuery);
