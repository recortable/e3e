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
                left: 50,
                right: 10
            }
        },
        yaxis : {
            name: 'Yaxis',
            min: 0,
            max: 4000,
            division: 500
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
        chart.grid.ratio = chart.grid.height / chart.yaxis.max;
        reset(chart.ctx);
        drawGrid(chart);
        drawBars(chart);
        drawLabels(chart);
    }

    function reset(ctx) {
        ctx.shadowOffsetX = 0;
        ctx.shadowOffsetY = 0;
        ctx.lineWidth = 0.2;
        ctx.shadowBlur = 0;
    }

    function drawGrid(chart) {
        var ctx = chart.ctx;

        ctx.strokeStyle = "gray";
        ctx.strokeRect(chart.grid.padding.left, chart.grid.padding.top, chart.grid.width, chart.grid.height);

        var vspace = chart.yaxis.division * chart.grid.ratio;
        var max = chart.grid.height;
        for (var y = chart.grid.padding.top + vspace; y < max; y += vspace) {
            ctx.strokeRect(chart.grid.padding.left, y, chart.grid.width, 0.1);
        }
    }

    function drawBars(chart) {
        var xOffset = chart.bars.width + chart.bars.margin.left + chart.bars.margin.right;
        var yOffset = chart.grid.height + chart.grid.padding.top;
        chart.ctx.fillStyle = chart.bars.color;
        var x = chart.grid.padding.left + chart.bars.margin.left;
        
        var values = chart.data.values;
        var max = values.length
        for(var index = 0 ; index < max; index++) {
            var height = values[index] * chart.grid.ratio;
            rect(chart.ctx, x, yOffset - height, chart.bars.width, height);
            x += xOffset;
        }
    }

    function drawLabels(chart) {
        var ctx = chart.ctx;
        ctx.fillText(chart.xaxis.name, 120, 30)
        ctx.rotate(- Math.PI*2 / 4);
        ctx.fillText(chart.yaxis.name, -120, 30);
        ctx.restore();
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