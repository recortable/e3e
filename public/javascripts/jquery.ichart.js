(function($) {

    $.fn.ichart = function(options) {
        log("Init");
        var chart = $.extend({}, $.fn.ichart.defaults, options);
        var target = $(this);
        target.data("chart", chart)
        createCanvas(target, chart);
        redraw(chart);
    }

    $.fn.ichart.defaults = {
        data : {
            values : [],
            names : []
        },
        bars : {
            color: "#c00",
            width: 30,
            margin: {
                left: 5,
                right: 0
            }
        },
        grid : {
            width: 740,
            height: 260,
            padding: {
                top: 20,
                bottom: 20,
                left: 30,
                right: 30
            },
            space: {
                vertical: 10
            }
        },
        yaxis : {
            name: 'Yaxis',
            min: 0,
            max: 4000
        },
        xaxis : {
            name: 'Xaxis'
        }
    }

    // PRIVATE
    function createCanvas(target, chart) {
        target.html("").css("position", "relative");
        var width = chart.grid.width + chart.grid.padding.left + chart.grid.padding.right;
        var height = chart.grid.height + chart.grid.padding.top + chart.grid.padding.bottom;
        var canvas = $('<canvas width="' + width + '" height="' + height + '"></canvas>').appendTo(target).get(0);
        if ($.browser.msie) // excanvas hack
            canvas = window.G_vmlCanvasManager.initElement(canvas);
        chart.ctx = canvas.getContext("2d");
    }

    function redraw(chart) {
        //     drawGrid(chart);
        drawBars(chart);
    }

    function drawGrid(chart) {
        var ctx = chart.ctx;
        for (var y=chart.grid.padding.top; y < chart.grid.height; y += chart.grid.space.vertical) {
            rect(ctx, chart.grid.padding.left, y, chart.grid.width, 1);
        }

        ctx.fillText(chart.xaxis.name, 120, 30)
        ctx.rotate(- Math.PI*2 / 4);
        ctx.fillText(chart.yaxis.name, -120, 30);
        ctx.restore();
    }

    function drawBars(chart) {
        var xOffset = chart.bars.width + chart.bars.margin.left + chart.bars.margin.right;
        var yOffset = chart.grid.height + chart.grid.padding.top;
        chart.ctx.fillStyle = chart.bars.color;
        var x = chart.grid.padding.left;
        
        var values = chart.data.values;
        var max = values.length
        for(var index = 0 ; index < max; index++) {
            var height = chart.grid.height * (values[index] / chart.yaxis.max)
            rect(chart.ctx, x, yOffset - height, chart.bars.width, height);
            x += xOffset;
        }
    }

    // LOG
    function log() {
        var output = "LOG (" + arguments.length + "): ";
        for ( var i = 0; i < arguments.length; i++) {
            output = output + arguments[i] + ",";
        }
        console.log(output);
    }

    // SVG LIBRARY
    function rect(ctx, x,y,w,h) {
        ctx.beginPath();
        ctx.rect(x,y,w,h);
        ctx.closePath();
        ctx.fill();
    }

})(jQuery);