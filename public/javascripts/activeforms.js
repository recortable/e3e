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

    $.fn.disabled_if_checked = function(selector) {
        return this.disabled_if(function () {
            return $(selector).attr('checked');
        });
    };

    $.fn.disabled_if_not_checked = function(selector) {
        return this.disabled_if(function () {
            return !$(selector).attr('checked');
        });
    };


    $.fn.disabled_if = function(condition) {
        var selector = this;
        return function() {
            var isEnabled = !condition.call();
            setEnabled(isEnabled, selector);
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
