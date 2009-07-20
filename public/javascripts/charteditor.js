(function($) {
    var padding = [50, 30, 30, 40];
    var size = [800, 300];
    var columnCount = 18;
    var charts = [];

    $.chart = function(dataset, containerId) {
        var chart = getChart(containerId, dataset);
        repaint(chart, dataset);
    };

    var repaint = function(chart, dataset) {
        var data = getData(dataset);
        chart.setDataArray(data);
        chart.draw();
    };

    var getChart = function(containerId, dataset) {
        if (charts[containerId] == null) {
            charts[containerId] = createChart(containerId);
            addClickHandler(charts[containerId], containerId, dataset);
        }
        return charts[containerId]
    };

    var createChart = function(containerId) {
        var current = new JSChart(containerId, 'bar');
        current.setTitle("")
        current.setAxisNameX("");
        current.setAxisNameY("")
        current.setBarOpacity(0.6);
        current.setSize(size[0], size[1]);
        current.setBarColor(barColor);
        current.setBarValues(false);
        current.setAxisValuesNumberY(1);
        current.setAxisPaddingTop(padding[0]);
        current.setAxisPaddingRight(padding[1]);
        current.setAxisPaddingBottom(padding[2]);
        current.setAxisPaddingLeft(padding[3]);
        return current;
    };

    var addClickHandler = function(chart, containerId, dataset) {
        var container = $("#" + containerId);
        var offset = container.offset();
        var columnWidth = Math.floor(((size[0] - padding[1] - padding[3]) / columnCount));
        var ndVertical = size[1] - padding[0] - padding[2];
        console.log("Column width: " + columnWidth);
        container.click(function(event) {
            var x = event.pageX - offset.left - padding[3] - 3;
            var y = event.pageY - offset.top - padding[0];
            console.log("XY: " + x + ", " + y);
            var current = (x / columnWidth);
            var column = Math.floor(current);
            console.log("Column: " + column);
            if (column >= 0 && column < columnCount) {
                var currentData = getData(dataset);
                var currentValue = currentData[column];
                var maxValue = getMaxValue(currentData);
                var newValue = -1;
                if (y > 0 && y < ndVertical) {
                    var ratio = 1 - (y / ndVertical);
                    newValue = maxValue[1] * ratio;
                } else if (y > ndVertical) {
                    $("#" + currentValue[0]).val(0);
                    repaint(chart, dataset);
                } else if (y < 0) {
                    var perPixel = maxValue[1] / ndVertical;
                    var amount = y * perPixel;
                    newValue = maxValue[1] - amount;
                }

                newValue = Math.floor(newValue / 10) * 10;
                console.log("NewValue: " + newValue);
                changeValue(chart, dataset, currentValue, newValue);
            }
        });
    };

    var changeValue = function(chart, dataset, currentValue, newValue) {
        if (newValue > 0) {
            $("#" + currentValue[0] + "-inline").html(newValue);
            $("#" + currentValue[0]).val(newValue);
            repaint(chart, dataset);
        } else {
            $("#" + currentValue[0] + "-inline").html('N/D');
        }
    };

    var getData = function(dataset) {
        var data = new Array();
        $(dataset).find("input.data").each(function() {
            var value = parseInt($(this).val());
            if (isNaN(value) || value == 0) {
                $(this).val('N/D');
                value = 0;
            }
            data.push([$(this).attr('id'), value]);
        });
        return data;
    };

    var getMaxValue = function(data) {
        var max = null;
        $.each(data, function() {
            if (max == null || max[1] < this[1]) {
                max = this;
            }
        });
        return max;
    };
})(jQuery);