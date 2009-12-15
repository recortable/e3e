(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log : function(text) {
                alert("text");
            }
        };
    }

    Array.prototype.max = function() {
        var max = 0;
        var len = this.length;
        for (var i = 0; i < len; i++) if (this[i] > max) max = this[i];
        return max;
    }

    $.fn.ichart = function(options) {
        var target = $(this);
        var chart = target.data("chart");
        if (chart == null) {
            chart = $.extend(true, {
                ctx : null,
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
            fontSize: 11, // size of the font in pixels
            padding: {
                top: 20,
                bottom: 50,
                left: 60,
                right: 10
            },
            editable : true
        },
        yaxis : {
            label: 'Yaxis',
            min: 0,
            max: 1000,
            division: 100,
            zero: 0, // value to display at 0
            fontSize: 13
        },
        xaxis : {
            label: 'Xaxis',
            fontSize: 13
        }
    }

    // PRIVATE
    function redraw(chart) {
        var ctx = chart.ctx;
        ctx.save();
        reset(chart, ctx);
        drawGrid(chart, ctx);
        drawBars(chart, ctx);
        //        drawLabels(chart, ctx);
        ctx.restore();
    }

    // get Column from xOffset in px
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
        function makeCanvas(width, height) {
            var c = document.createElement('canvas');
            c.width = width;
            c.height = height;
            if ($.browser.msie) // excanvas hack
                c = window.G_vmlCanvasManager.initElement(c);
            return c;
        }

        if ($.browser.msie) {
            window.G_vmlCanvasManager.init_(document); // make sure everything is setup
        }


        target.html("");
        chart.panel.width = chart.grid.width + chart.grid.padding.left + chart.grid.padding.right;
        chart.panel.height = chart.grid.height + chart.grid.padding.top + chart.grid.padding.bottom;
        
        var canvas = $(makeCanvas(chart.panel.width, chart.panel.height)).appendTo(target).get(0);
        var context = canvas.getContext("2d");
        chart.ctx = context;
        addListeners(target, canvas, chart);
    }

    function addListeners(target, canvas, chart) {
        $(canvas).click(function (evt) {
            if (chart.grid.editable) {
                var offset = $(this).offset();
                var x = evt.pageX - offset.left - chart.grid.padding.left;
                var y = evt.pageY - offset.top - chart.grid.padding.top;
                var col = toColumn(chart, x);
                if (col != null) {
                    target.trigger("ichart.changed", [chart.data.names[col], changeColumn(chart, col, y)]);
                }
            }
        });
        $(target).bind("ichart.max_up", function() {
            chart.yaxis.max += chart.yaxis.division;
            $(target).trigger("ichart.scaleChanged", [chart.yaxis.max]);
            redraw(chart);
        });
        $(target).bind("ichart.max_down", function() {
            var maxValue = chart.data.values.max();
            chart.yaxis.max -= chart.yaxis.division;
            if (chart.yaxis.max < maxValue) {
                chart.yaxis.max += chart.yaxis.division;
            } else {
                $(target).trigger("ichart.scaleChanged", chart.yaxis.max);
                redraw(chart);
            }
        });
    }

    /**
     * Change the column value given the y position in pixels relative to the target.
     * If the value is greater than the max value for the axis, this max value is changed
     *
     * @returns The new value of the column
     */
    function changeColumn(chart, column, y) {
        var step = chart.grid.stepSize;
        var val = toValue(chart, y);
        var normalized = Math.floor(val / step) * step;
        if (normalized < 0) {
            chart.data.values[column] = null;
        } else if (normalized < chart.yaxis.max) {
            chart.data.values[column] = normalized;
        } else {
            chart.yaxis.max += chart.yaxis.division;
        }
        redraw(chart);
        return chart.data.values[column];
    }


    function reset(chart, ctx) {
        var maxValue = chart.data.values.max();
        var max = chart.yaxis.max;
        if (max < maxValue) {
            var division = chart.yaxis.division;
            max = maxValue + division;
            chart.yaxis.max = max - (max % division);
        }
        chart.grid.ratio = chart.grid.height / chart.yaxis.max;
        chart.grid.stepSize = 50; // TODO: calcuate this from steps property
        chart.bars.count = chart.data.values.length;
        chart.bars.space = chart.bars.width + chart.bars.margin.left + chart.bars.margin.right;
        
        ctx.clearRect(0, 0, chart.panel.width, chart.panel.height);
        ctx.font = chart.grid.fontSize + "px sans-serif";
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
        var division = calculeDivisionSize(chart);
        var width = chart.grid.width;
        var bottom = top + chart.grid.height;
        var yFont = chart.grid.fontSize / 3;
        var maxWidth = 0;
        for (var value = chart.yaxis.max; value >= 0; value -= division) {
            var text = ((value == 0) ? chart.yaxis.zero : "" + value) + " ";
            var y = bottom - (value * chart.grid.ratio);
            ctx.strokeRect(left, y, width, 0.1);
            var textWidth = ctx.measureText(text).width;
            maxWidth = (maxWidth > textWidth) ? maxWidth : textWidth;
            ctx.fillText(text, left - textWidth, y + yFont, 10000);
        }
        chart.yaxis.maxTextWidth = maxWidth;
    }

    /* ES CUTRE, PERO FUNCIONA */
    function calculeDivisionSize(chart) {
        var div = chart.yaxis.division;

        var lines = chart.yaxis.max / div;
        if (lines < 5) div = div / 2;
        if (lines > 10) div = div * 2;

        return div;
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
            ctx.fillText(label, x + middle, yOffset + chart.grid.fontSize, xOffset);

            x += xOffset;
        }
    }

    function drawLabels(chart, ctx) {
        ctx.fillStyle = "#000000";
        ctx.font = chart.xaxis.fontSize + 'px "Helvetica Neue", Helvetica, Arial, sans-serif';
        ctx.textAlign = "center";
        var y= chart.grid.height + chart.grid.padding.top + chart.grid.padding.bottom - chart.xaxis.fontSize;
        var x = chart.grid.padding.left + (chart.grid.width / 2);
        ctx.fillText(chart.xaxis.label, x, y);
        
        ctx.save();
        ctx.rotate(- Math.PI*2 / 4);
        ctx.textAlign = "center";
        ctx.font = chart.yaxis.fontSize + "px sans-serif";
        x = chart.grid.padding.left - chart.yaxis.fontSize - chart.yaxis.maxTextWidth;
        y = chart.grid.padding.top + (chart.grid.height / 2);
        ctx.fillText(chart.yaxis.label, -y,x);
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