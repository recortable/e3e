
(function ($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {
            }
        };
    }
    
    String.prototype.trim = function () {
        return this.replace(/^\s*/, "").replace(/\s*$/, "");
    }

    var validators = {
        not_empty : function (ctx, text) {
            if (text == "") {
                addError("no puede estar vac&iacute;o", this, ctx);
            }
        },
        warning_less_100 : function(ctx, text) {
            if (text.length > 0 && text.length < 100) {
                if (!confirm("El texto es muy corto... ¿estás segura de que quieres guardar esto?")) {
                    addError("texto muy corto", this, ctx);
                }
            }
        },
        length_more_than_4 : function(ctx, text) {
            if (text.length > 0 && text.length < 4) {
                addError("debería tener al menos 4 caracteres", this, ctx)
            }
        }
    };


    $.fn.validate = function(msg) {
        $(this).submit(function() {
            var button = $(this).find(":input[type=submit]");
            var original = button.val();
            button.val(msg);
            button.attr('disabled', true);
            if (valida($(this)) != 0) {
                button.val(original);
                button.attr('disabled', false);
                return false;
            } else {
                return true;
            }
        });
    }

    var valida = function(form) {
        var ctx = {
            errors : 0
        };

        $(form).find("p.error_message").remove();
        $(form).each(function() {
            $(this).find(":input").each(function () {
                var element = $(this);
                element.removeClass("error");
                validate(element, ctx);
            });
        });

        return ctx.errors;
    };


    var validate = function (e, ctx) {
        var args = [];
        args.push(ctx);
        args.push($.trim(e.val()));
        var methods = e.attr('class').split(' ');
        $.each(methods, function() {
            var method = validators[this];
            if (method != null) {
                method.apply(e, args)
            }
        });
    };


    var addError = function(message, element, ctx) {
        element.addClass("error");
        element.after('<p class="error_message">' + message +'</p>');
        element.parent().addClass("error");
        ctx.errors++;
    };

})(jQuery);

(function ($) {
    $.prevent = function() {
        window.onbeforeunload = function() {
            return "Los datos no han sido guardados.";
        };
        $("form").submit(function() {
            var submit = $(this).find("input[type=submit]");
            submit.val("Un momento por favor...");
            submit.attr("disabled", "true");
            window.onbeforeunload = null;
            return true;
        });

    }
})(jQuery);



