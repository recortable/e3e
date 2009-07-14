

(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {},
            debug : function() {}
        };
    };

    var rules = {};

    var rulify = function(name, action, condition) {
        return function() {
            console.log("Rule: " + name)
            var isActive = condition.call();
            console.log("Condition: " + isActive);
            action.call(null, isActive);
        }
    };

    $.rule = function(name, action, condition) {
        console.log("Adding rule: " + name);
        rules[name] = rulify(name, action, condition);
    };

    $.OR = function() {
        var params = arguments;
        return function() {
            for(var index = 0; index < params.length; index++) {
                if (params[index].call() == true) {
                    return true;
                }
            }
            return false;
        }
    };

    $.AND = function() {
        var params = arguments;
        return function() {
            for(var index = 0; index < params.length; index++) {
                if (params[index].call() == false) {
                    return false;
                }
            }
            return true;
        }
    };

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

    $.checked = function(selector) {
        return function() {
            return $(selector).attr('checked');
        }
    };
    $.not_checked = function(selector) {
        return function() {
            return !$(selector).attr('checked');
        }
    };

    $.enable = function(selector) {
        return function(active) {
            console.log("Enable with: " + active);
            setEnabled(active, selector);
        }
    }
    $.disable = function(selector) {
        return function(active) {
            console.log("Disable with: " + active);
            setEnabled(!active, selector);
        }
    };

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
