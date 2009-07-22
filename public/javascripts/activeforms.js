

(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined" || typeof console.debug == "undefined" ) {
        console = {
            log : function() {},
            debug : function() {}
        };
    };

    var logger = console.log;

    var rules = {};

    var rulify = function(name, action, condition) {
        return function() {
            logger("Rule: " + name)
            var isActive = condition.call();
            logger("Condition: " + isActive);
            action.call(null, isActive);
        }
    };

    $.rule = function(name, action, condition) {
        logger("Adding rule: " + name);
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
            logger(this);
            for (var index = 0; index < names.length; index++) {
                var name = names[index];
                logger("Fired rule: " + name);
                rules[name].apply();
            }
        });
    };

    $.checked = function(selector) {
        return function() {
            var isChecked = $(selector).attr('checked');
            logger("Checked?: " + selector + " => " + isChecked);
            return isChecked;
        }
    };
    $.not_checked = function(selector) {
        return function() {
            logger("Not checked?: " + selector);
            return !$(selector).attr('checked');
        }
    };

    $.enable = function(selector) {
        return function(active) {
            logger("Enable with: " + active);
            setEnabled(active, selector);
        }
    }
    $.disable = function(selector) {
        return function(active) {
            logger("Disable with: " + active);
            setEnabled(!active, selector);
        }
    };

    $.applyRules = function() {
        logger("Init activeform");
        $.each(rules, function(name) {
            logger("Applying rule: " + name);
            this.apply();
        });
    };

    var setEnabled = function(isEnabled, selector) {
        logger("Enabled: " + isEnabled);
        if (isEnabled) {
            $(selector).removeClass("disabled");
        } else {
            $(selector).addClass("disabled");
        }
        $(selector).find("input").attr("disabled", !isEnabled);
    };
})(jQuery);
