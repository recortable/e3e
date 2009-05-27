(function($) {
    var rules = [];

    $.disableWhen = function(group, value, selector) {
        rules.push({
            'group': group,
            'value': value,
            'selector': selector
        });
        $(group).change(function() {
            $.applyRules();
        });
    };

    $.applyRules = function() {
        $.each(rules, function() {
            var rule = this;
            $("" + rule.group + " input").each(function() {
                var ruleApplies = $(this).attr('checked') == true && $(this).val() == rule.value;
                setEnabled(!ruleApplies, rule.selector);
            });
        });
    }

    var setEnabled = function(isEnabled, selector) {
        if (isEnabled) {
            $(selector).removeClass("disabled");
        } else {
            $(selector).addClass("disabled");
        }
        $(selector + " input").attr("disabled", !isEnabled);
    };
})(jQuery);
