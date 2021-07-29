var OSCILLOGRAM_WIDTH = 128;

var chartsData = []
var allChartsData = []

var spectra_list = []
for(var i = 0; i < 12; i++){
    var sp = {channel : -1, point : -1, bin_num: -1, mode: -1}
    spectra_list.push(sp);
}
var spectrum_data = []
var chartType = "bar"

var current_page_mode = "#all-tab-pane";

function start() {
    var json = {"command" : "sendStartEvent"};
    send_http_request(json);

    var request = new XMLHttpRequest();
    request.open("POST", "", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.responseType = 'text';

    json = {"command" : "read_charts"};
    str = JSON.stringify(json);
    request.send(str);

    request.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200){
            var json = JSON.parse(this.responseText);
            chartsData = [];
            for (var i = 0; i < 4 * OSCILLOGRAM_WIDTH; i++)
                chartsData[i] = json[i];
            var copy = chartsData;
            allChartsData.push(copy);
            drawCharts();
        }
        var copy = spectrum_data;
        allChartsData.push(copy);
        for (var i = 0; i < spectra_list.length; i++){
            if(spectra_list[i].channel != -1)
                drawSpectrum(i);
        }
    }
}

function someStart() {
  var startCount = document.getElementById("startCount").value;
  if (startCount >= 1 && startCount <= 1000)
    for (var i = 0; i < startCount; i++)
      start();
}

function drawADC(id,num,chartsData) {
    var x = [];
    var y = [];
    var type;
    for (i = 0; i < OSCILLOGRAM_WIDTH; i++) {
        x.push(i);
        y.push(chartsData[i * 4 + (num-1)]);
    }
    if (chartType=="line")
        type="scatter";
    if (chartType=="bar")
        type="bar";
    var data = [
        {
            x: x,
            y: y,
            type: type
        }
    ];
    var layout = {
        title:      num + " канал АЦП",
        showlegend: false
    };
    Plotly.newPlot(id, data, layout);
    document.getElementById("spectrumInfo").setAttribute("hidden","true");
}

function drawCharts() {
    switch(current_page_mode) {
        case "#1-adc-tab-pane":
            drawADC("adc_graph_1_1",1,chartsData);
            break;
        case "#2-adc-tab-pane":
            drawADC("adc_graph_2_2",2,chartsData);
            break;
        case "#3-adc-tab-pane":
            drawADC("adc_graph_3_3",3,chartsData);
            break;
        case "#4-adc-tab-pane":
            drawADC("adc_graph_4_4",4,chartsData);
            break;
        case "#all-tab-pane":{
            drawADC("adc_graph_1",1,chartsData);
            drawADC("adc_graph_2",2,chartsData);
            drawADC("adc_graph_3",3,chartsData);
            drawADC("adc_graph_4",4,chartsData);
            break;
        }
        default:
            console.log(current_page_mode);
            break;
    }
}

function drawSpectrum(num){

    request = new XMLHttpRequest();
    request.open("POST", "", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.responseType = 'text';

    json = {"command"      : "readSpectrum",
            "spectrum_num" : num};
    str = JSON.stringify(json);
    request.send(str);

    request.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var json = JSON.parse(this.responseText);
            spectrum_data = [];
            for (var i = 0; i < 4096; i++)
                spectrum_data[i] = json[i];
        }
    }
    var x = [];
    var y = [];
    var spectrumData = [];
    var yc = 0;
    for (i = -spectra_list[num].bin_num / 2; i < spectra_list[num].bin_num/2; i++) {
        x.push(i);
        yc = (i < 0) ? i + Number(spectra_list[num].bin_num) : i;
        y.push(spectrum_data[yc]);
    }

    if (chartType=="line")
        type="scatter";
    if (chartType=="bar")
        type="bar";

    var data = [
        {
            x    : x,
            y    : y,
            type : type
        }
    ];

    var layout = {
        title      : "Амплитудный спектр " + num,
        showlegend : false};
    Plotly.newPlot("spectrum_graph_" + num, data, layout);

    document.getElementById("spectrumInfo").removeAttribute("hidden");
    document.getElementById("channelInfo").innerHTML = "Канал АЦП: " + spectra_list[num].channel;
    document.getElementById("modeInfo").innerHTML = "Режим работы: " + spectra_list[num].mode;
    if (spectra_list[num].mode == "point")
        document.getElementById("pointInfo").innerHTML = "Опорная точка: " + spectra_list[num].point;
    if (spectra_list[num].mode == "maxAmpl")
        document.getElementById("pointInfo").innerHTML = "Опорной точки нет ";
    document.getElementById("basketInfo").innerHTML = "Количество корзин: " + spectra_list[num].bin_num;
}

function drawSpectra(){
    for (var i = 0; i < (spectra_list.length); i++){
        if(spectra_list[i].channel != -1)
            drawSpectrum(i);
    }
}

function saveCharts(){
    var txt = "";
    console.log(allChartsData)
    for (var i = 0; i < allChartsData.length; i++) {
        for (var j = 0; j < allChartsData[i].length; j++) {
            txt += j + " " + allChartsData[i][j] + "\r\n";
        }
    }
    for (var i = 0; i < spectra_list.length; i++) {
        for (var j = 0; j < spectra_list[i].data.length; j++) {
            txt += j + " " + spectra_list[i].data[j] + "\r\n";
        }
    }
    console.log(txt);
    var blob = new Blob([txt], {type: "text/plain;charset=utf-8"});
    saveAs(blob, "data.txt");
}

function addSpectrum(channel, point, bin_num, mode, spectrum_num){
    var json = {"command"      : "set_spectrum_conf",
                "spectrum_num" : spectrum_num,
                "point"        : point,
                "bins_num"     : Math.log2(bin_num) - 5};
    send_http_request(json);

    var elem = document.createElement('a');
    elem.setAttribute("class","dropdown-item");
    var href = "#" + (spectrum_num) + "-spectrum-tab-pane"
    elem.setAttribute("href", href);
    elem.id = spectrum_num + "_spectrum_tab_icon";
    elem.innerHTML='Спектр '+ (spectrum_num) + ' (Канал:' + channel + ', режим:' + mode + ')';
    elem.addEventListener('click',function(event){
        var i = event.target.href.split("/")[3].replace(/\D+/g,"");
        drawSpectrum(i);
        $(this).tab('show');
    });

    var sp_menu = document.getElementById("spectra-menu")
    sp_menu.appendChild(elem);
    var sp_item = document.getElementById("add-spectrum-item")
    sp_item.className = "dropdown-item";

    var id = "spectrum_graph_" + (spectrum_num);
    var text = '<table class="table table-bordered"><tbody><tr><td width="100%"><div id="' + id + '"></div></td></table>';
    var elem1 = document.createElement('div');
    elem1.setAttribute("class","tab-pane fade");
    elem1.id = (spectrum_num) + "-spectrum-tab-pane";
    elem1.innerHTML += text
    $('a[href="'+href+'"]').on('shown.bs.tab', function (event) {
        var i = event.target.href.split("/")[3].replace(/\D+/g,"");
        drawSpectrum(i);
    });

    var tab = document.getElementsByClassName("tab-content");
    tab[0].appendChild(elem1);
    document.getElementById(id).setAttribute("style","height:800px;");

    var sp = {channel : channel, point : point, bin_num: bin_num, mode: mode};
    spectra_list[spectrum_num] = sp;
}

function deleteSpectrum(num){
    var elem = document.getElementById( num + "-spectrum-tab-pane");
    elem.remove();
    elem = document.getElementById( num + "_spectrum_tab_icon");
    elem.remove();
    spectra_list[num].channel = -1;
}

function send_http_request(json){
    var request = new XMLHttpRequest();
    request.open("POST", "", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.responseType = 'text';
    request.send(JSON.stringify(json));
    console.log(json)
}

function sendTriggLevel() {
    var level = (0b011111111111111 & parseInt(document.getElementById('triggLevel0').value, 10) + 0);
    var json = {"command" : "set_trigger_level",
                "data"    : level};
    send_http_request(json);

    level  = (0b011111111111111 & parseInt(document.getElementById('triggLevel1').value, 10) + 0) | 16384;
    json = {"command" : "set_trigger_level",
            "data"    : level};
    send_http_request(json);

    level  = (0b011111111111111 & parseInt(document.getElementById('triggLevel2').value, 10) + 0) | 32768;
    json = {"command" : "set_trigger_level",
            "data"    : level};
    send_http_request(json);

    level  = (0b011111111111111 & parseInt(document.getElementById('triggLevel3').value, 10) + 0) | 49152;
    json = {"command" : "set_trigger_level",
               "data" : level};
    send_http_request(json);
}

function sync_deser() {
    var json = {"command" : "sync_deser"};
    send_http_request(json);
}

function rst_spectrum(){
    var json = {"command"   : "rst_spectrum"};
    send_http_request(json);
}

function signed_ext(value, valid_bit_num){
    if(value & (1 << (valid_bit_num - 1)))
        return value | ~((1 << valid_bit_num) - 1);
    else
        return value & ((1 << valid_bit_num) - 1);
}

function set_shaper_config(channel, mnemonic){
    var data;
    if      ($('#' + mnemonic + '_channel_00').prop("checked")) data = 0b00;
    else if ($('#' + mnemonic + '_channel_01').prop("checked")) data = 0b01;
    else if ($('#' + mnemonic + '_channel_02').prop("checked")) data = 0b10;
    else if ($('#' + mnemonic + '_channel_05').prop("checked")) data = 0b11;
    data = data | (channel << 2);
    var json = {"command" : "setShapersConfig",
                "data"    : data};
    send_http_request(json);
}

function set_ampl_config(channel, mnemonic){
    var data;
    if      ($('#' + mnemonic + '_ampl_1').prop("checked")) data = 0;
    else if ($('#' + mnemonic + '_ampl_2').prop("checked")) data = 1;
    else if ($('#' + mnemonic + '_ampl_4').prop("checked")) data = 2;
    else data = 3;
    data = data | (channel << 2);
    var json = {"command" : "set_ampl_config",
                "data"    : data};
    send_http_request(json);
}

function update_button(names, select){
    document.getElementById(names[select]).checked = true;
    document.getElementById("css_" + names[select]).setAttribute("class", "btn btn-primary active");
    for (var i = 0; i < names.length; i++){
        if(i != select)
        document.getElementById('css_' + names[i]).setAttribute("class", "btn btn-primary");
    }
}

$(document).ready(function(){
    drawCharts();
    $('.nav-tabs a[href="#add-spectrum"]').on('shown.bs.tab', function(event){
        $('#Modal').modal('show');
    });

    $('.nav-tabs a[href="#delete-spectrum"]').on('shown.bs.tab', function(event){
        var num = prompt("Введите номер спектра", "");
        console.log(num);
        if (num == null || num == "" || num < 0 || num > (spectra_list.length) || spectra_list[num].channel == -1) {
            txt = "Неверное значение";
        } else {
            deleteSpectrum(num);
        }
    });

    $('.nav-tabs a').on('shown.bs.tab', function(event){
        current_page_mode = (event.target.href.split("/")[3] == "#") ? current_page_mode : event.target.href.split("/")[3];
        drawCharts();
    });

    $('.dropdown-menu a').on('shown.bs.tab', function(event){
        //drawSpectra();
        console.log("3")
    });

    $(".nav-tabs a").click(function(){
        $(this).tab('show');
        console.log("click on tab")
    });

    $("#createSpectrum").click(function(){
        var ch;
        var mode;
        var pt;
        var smpl;
        var spectrum_num;
        if ($('#channelADC1').prop("checked") == true)
            ch = 1;
        if ($('#channelADC2').prop("checked") == true)
            ch = 2;
        if ($('#channelADC3').prop("checked") == true)
            ch = 3;
        if ($('#channelADC4').prop("checked") == true)
            ch = 4;
        if ($('#pointMode').prop("checked") == true){
            mode = 1;
            pt = $("#pointADC").val();
        }
        if ($('#maxAmplMode').prop("checked") == true){
            mode = 0;
            pt = 0;
        }
        smpl = $("#basketNumber > .active").text();
        console.log(pt);
        if (ch > 4 || ch < 1) {
            alert("Неправильный канал!");
            $('#add-spectrum-item').attr("class", "dropdown-item");
        }
        else{
            if (pt < 0 || pt > OSCILLOGRAM_WIDTH ) {
                alert("Неправильная опорная точка!");
                $('#add-spectrum-item').attr("class", "dropdown-item");
            }
            else{
                if (smpl < 0 || smpl > 4096 || smpl == "") {
                    alert("Выберите количество корзин!");
                    $('#add-spectrum-item').attr("class", "dropdown-item");
                }
                else{
                    spectrum_num = (ch-1)*3 + mode;

                    if(spectra_list[spectrum_num].channel == -1)
                        addSpectrum(ch, pt, smpl, mode, spectrum_num);
                    else if (mode == 1 && spectra_list[spectrum_num+1].channel == -1)
                        addSpectrum(ch, pt, smpl, mode, spectrum_num + 1);
                    else
                        alert("Невозможно создать гистограмму по данному каналу. Пожалуйста, удалите уже имеющуюся гистограмму.");
                }
            }
        }
        $('#Modal').modal('hide');
    });

    $('#Modal').on('hide.bs.modal', function(event) {
        $('#add-spectrum-item').attr("class", "dropdown-item");
    });

    $("input[name='options']").change( function() {
        if ($('#histogram_but').prop("checked")) chartType="bar";
        else                                     chartType="line";
        drawCharts();
    });

    $("input[name='adc_mode']").change( function() {
        var data;
        if ($('#work_mode').prop("checked")) data = 1;
        else                                 data = 0;
        var json = {"command" : "adc_mode",
                    "data"    : data};
        send_http_request(json);
    });

    $("input[name='trigger_type']").change( function() {
        var data;
        if ($('#force_but').prop("checked")) data = 1;
        else                                 data = 0;
        var json = {"command" : "setTriggerType",
                    "data"    : data};
        send_http_request(json);
    });

    $("input[name='first_channel']").change (function() {set_shaper_config(0, 'first' )});
    $("input[name='second_channel']").change(function() {set_shaper_config(1, 'second')});
    $("input[name='third_channel']").change (function() {set_shaper_config(2, 'third' )});
    $("input[name='fourth_channel']").change(function() {set_shaper_config(3, 'fourth')});

    $("input[name='first_ampl']").change (function() {set_ampl_config(0, 'first' )});
    $("input[name='second_ampl']").change(function() {set_ampl_config(1, 'second')});
    $("input[name='third_ampl']").change (function() {set_ampl_config(2, 'third' )});

    $("input[name='level_num_checkbox']").change( function() {
        var dataCheck0 = $('#level0').prop("checked") ? 1 : 0;
        var dataCheck1 = $('#level1').prop("checked") ? 1 : 0;
        var dataCheck2 = $('#level2').prop("checked") ? 1 : 0;
        var dataCheck3 = $('#level3').prop("checked") ? 1 : 0;
        var dataCheck = dataCheck0 + dataCheck1 * 2 + dataCheck2 * 4 + dataCheck3 * 8;
        var json = {"command" : "setSelectedChannels",
                    "data"    : dataCheck};
        send_http_request(json);
    });

    $("#basketNumber").children().on("click",function(event) {
        $("#basketNumber").children().attr("class", "dropdown-item");
        $(event.target).attr("class", "dropdown-item active");
    });

    $("input[name='mode']").change( function() {
        var value = $('#pointMode').prop("checked");
        if (value == true){
            $("fieldset").removeAttr("disabled");
        }
        if (value == false){
            $("fieldset").attr("disabled","true");
        }
    });
    window.onfocus  = update_page;
    window.onload = update_page;
});

function update_page(){
    var trigg_type_but = document.getElementById('force_but').checked;
    var level_type_but = document.getElementById('level_but').checked;
    var request = new XMLHttpRequest();
    request.open("POST", "", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.responseType = 'text';
    var json = {"command" : "update_page_config"};
    request.send(JSON.stringify(json));
    console.log(json)
    request.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var json = JSON.parse(this.responseText);
            if (json.trigger_type == "1"){
                document.getElementById('force_but').checked = true;
                document.getElementById('css_force_but').setAttribute("class", "btn btn-primary active");
                document.getElementById('css_level_but').setAttribute("class", "btn btn-primary");
            }
            else{
                document.getElementById('force_but').checked = false;
                document.getElementById('css_force_but').setAttribute("class", "btn btn-primary");
                document.getElementById('css_level_but').setAttribute("class", "btn btn-primary active");
            }
            if(json.adc_mode == "1"){
                document.getElementById('work_mode').checked = true;
                document.getElementById('css_adc_work_mode').setAttribute("class", "btn btn-primary active");
                document.getElementById('css_adc_test_mode').setAttribute("class", "btn btn-primary");
            }
            else{
                document.getElementById('work_mode').checked = false;
                document.getElementById('css_adc_work_mode').setAttribute("class", "btn btn-primary");
                document.getElementById('css_adc_test_mode').setAttribute("class", "btn btn-primary active");
            }
            document.getElementById('level0').checked = json.selected_level&1 ? true : false;
            document.getElementById('level1').checked = json.selected_level&2 ? true : false;
            document.getElementById('level2').checked = json.selected_level&4 ? true : false;
            document.getElementById('level3').checked = json.selected_level&8 ? true : false;
            document.getElementById('triggLevel0').value = signed_ext(json.trigger_level_0, 14);
            document.getElementById('triggLevel1').value = signed_ext(json.trigger_level_1, 14);
            document.getElementById('triggLevel2').value = signed_ext(json.trigger_level_2, 14);
            document.getElementById('triggLevel3').value = signed_ext(json.trigger_level_3, 14);

            update_button(["first_channel_00",
                           "first_channel_01",
                           "first_channel_02",
                           "first_channel_05"], json.shapers_config_0);

            update_button(["second_channel_00",
                           "second_channel_01",
                           "second_channel_02",
                           "second_channel_05"], json.shapers_config_1);

            update_button(["third_channel_00",
                           "third_channel_01",
                           "third_channel_02",
                           "third_channel_05"], json.shapers_config_2);

            update_button(["fourth_channel_00",
                           "fourth_channel_01",
                           "fourth_channel_02",
                           "fourth_channel_05"], json.shapers_config_3);

            update_button(["first_ampl_1",
                           "first_ampl_2",
                           "first_ampl_4",
                           "first_ampl_5"], json.ampl_config_0);

            update_button(["second_ampl_1",
                           "second_ampl_2",
                           "second_ampl_4",
                           "second_ampl_5"], json.ampl_config_1);

            update_button(["third_ampl_1",
                           "third_ampl_2",
                           "third_ampl_4",
                           "third_ampl_5"], json.ampl_config_2);
        }
    }
};
