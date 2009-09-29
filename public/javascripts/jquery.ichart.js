(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function() {}
        };
    }

    $.fn.ichart = function(options) {
        var target = $(this);
        var chart = target.data("chart");
        if (chart == null) {
            chart = $.extend(true, {
                panel : {
                    width: 0,
                    height: 0
                }
            }, $.fn.ichart.defaults, options);
            target.data("chart", chart)
            createCanvas(target, chart);
        }
        redraw(chart);
    }

    $.fn.ichart.defaults = {
        data : {
            values : [],
            names : []
        },
        bars : {
            color: "#c00",
            width: 34,
            margin: {
                left: 3,
                right: 3
            }
        },
        grid : {
            width: 740, // width of the grid
            height: 260, // height of the grid
            steps: 100, // number of steps when normalizing the event value
            fontHeight: 11, // size of the font in pixels
            padding: {
                top: 20,
                bottom: 50,
                left: 60,
                right: 10
            },
            editable : true
        },
        yaxis : {
            name: 'Yaxis',
            min: 0,
            max: 4000,
            division: 500,
            zero: 0 // value to display at 0
        },
        xaxis : {
            name: 'Xaxis'
        }
    }

    // PRIVATE
    function toColumn(chart, x) {
        var col = Math.floor(x / chart.bars.space);
        var offset = x - (col * chart.bars.space);
        var colLeftMargin = chart.bars.margin.left;
        if (offset > colLeftMargin && offset < (colLeftMargin + chart.bars.width))
            return col;
        else
            return null;
    }

    function toValue(chart, y) {
        return chart.yaxis.max - (y / chart.grid.ratio);
    }



    function createCanvas(target, chart) {
        target.html("").css("position", "relative");
        chart.panel.width = chart.grid.width + chart.grid.padding.left + chart.grid.padding.right;
        chart.panel.height = chart.grid.height + chart.grid.padding.top + chart.grid.padding.bottom;
        var canvas = $('<canvas width="' + chart.panel.width + '" height="' + chart.panel.height + '"></canvas>').appendTo(target).get(0);
        if ($.browser.msie) // excanvas hack
            canvas = window.G_vmlCanvasManager.initElement(canvas);
        chart.ctx = canvas.getContext("2d");
        $(canvas).click(function (evt) {
            if (chart.grid.editable) {
                var offset = $(this).offset();
                var x = evt.pageX - offset.left - chart.grid.padding.left;
                var y = evt.pageY - offset.top - chart.grid.padding.top;
                var col = toColumn(chart, x);
                if (col != null) {
                    var step = chart.grid.stepSize;
                    var val = toValue(chart, y);
                    var normalized = Math.floor(val / step) * step;
                    normalized = (normalized > 0 && normalized < chart.yaxis.max) ? normalized : null;
                    changeColumn(chart, col, normalized);
                    target.trigger("ichart.changed", [chart.data.names[col], normalized]);
                }
            }
        });
    }

    function changeColumn(chart, column, value) {
        chart.data.values[column] = value;
        redraw(chart);
    }


    function redraw(chart) {
        var ctx = chart.ctx;
        ctx.save();
        reset(chart, ctx);
        drawGrid(chart, ctx);
        drawBars(chart, ctx);
        drawLabels(chart, ctx);
        ctx.restore();
    }

    function reset(chart, ctx) {
        chart.grid.ratio = chart.grid.height / chart.yaxis.max;
        chart.grid.stepSize = 50; // TODO: calcuate this from steps property
        chart.bars.count = chart.data.values.length;
        chart.bars.space = chart.bars.width + chart.bars.margin.left + chart.bars.margin.right;
        
        ctx.clearRect(0, 0, chart.panel.width, chart.panel.height);
        ctx.font = chart.grid.fontHeight + "px sans-serif";
        ctx.shadowOffsetX = 0;
        ctx.shadowOffsetY = 0;
        ctx.lineWidth = 0.2;
        ctx.shadowBlur = 0;
    }

    function drawGrid(chart, ctx) {
        ctx.strokeStyle = "gray";
        var left = chart.grid.padding.left;
        var top = chart.grid.padding.top;
        //ctx.strokeRect(left, top, chart.grid.width, chart.grid.height);

        var division = chart.yaxis.division;
        var width = chart.grid.width;
        var bottom = top + chart.grid.height;
        var yFont = chart.grid.fontHeight / 3;
        for (var value = chart.yaxis.max; value >= 0; value -= division) {
            var text = ((value == 0) ? chart.yaxis.zero : "" + value) + " ";
            var y = bottom - (value * chart.grid.ratio);
            ctx.strokeRect(left, y, width, 0.1);
            var textWidth = ctx.measureText(text).width;
            ctx.fillText(text, left - textWidth, y + yFont);
        }
      
    }

    function drawBars(chart, ctx) {
        var xOffset = chart.bars.space;
        var yOffset = chart.grid.height + chart.grid.padding.top;
        var middle = chart.bars.width / 2;
        var x = chart.grid.padding.left + chart.bars.margin.left;
        
        var values = chart.data.values;
        var labels = chart.data.names;
        var max = chart.bars.count;

        ctx.fillStyle = chart.bars.color;
        for(var index = 0 ; index < max; index++) {
            var value = values[index];
            if (!isNaN(value)) {
                var height = value * chart.grid.ratio;
                rect(ctx, x, yOffset - height, chart.bars.width, height);
            }
            ctx.textAlign = "center";
            ctx.fillStyle = "#000000";
            var display = (isNaN(value) || value == null) ? chart.yaxis.zero : value;
            ctx.fillText(display, x + middle, yOffset - 2, xOffset);
            ctx.fillStyle = chart.bars.color;
            var label = labels[index];
            ctx.fillText(label, x + middle, yOffset + chart.grid.fontHeight, xOffset);

            x += xOffset;
        }
    }

    function drawLabels(chart, ctx) {
        ctx.fillText(chart.xaxis.name, 120, 30);
        ctx.save();
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