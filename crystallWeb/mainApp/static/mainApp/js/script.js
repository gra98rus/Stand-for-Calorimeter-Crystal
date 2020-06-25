var ADC_WIDTH = 128;

var chartsData = []
var spectraList = []
var allChartsData = []

var chartType = "bar"
//setInterval(readStatus, 1000);

function writeDataToReg() {
  var sendData = document.getElementById('write_data');
  var sendRegNum = document.getElementById('write_reg_num');
  var writeReadData = document.getElementById('write_read_data');
  var data = sendData.value;
  var regNumber = sendRegNum.value;

  var request = new XMLHttpRequest();

  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';

  var json = {"command" : "writeRegister",
              "regNumber" : regNumber,
              "data" : data};
  var str = JSON.stringify(json)
  request.send(str);
  console.log("send POST")
}

function readDataFromReg() {
  var readData = document.getElementById('read_data');
  var readRegNum = document.getElementById('read_reg_num');

  var regNumber = readRegNum.value;

  var request = new XMLHttpRequest();

  request.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var json = JSON.parse(this.responseText);
      readData.value = json.data;
      console.log(this.responseText);
      console.log("receive json");
    }
  }

  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';

  console.log({"regNumber": regNumber });
  var json = {"command" : "readRegister", "regNumber" : regNumber};
  var str = JSON.stringify(json);
  request.send(str);
  console.log("send POST")

}

function start() {
  var request = new XMLHttpRequest();

  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';

  var json = {"command" : "sendStartEvent"};
  var str = JSON.stringify(json);
  request.send(str);

  request = new XMLHttpRequest();
  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';

  json = {"command" : "readCharts"};
  str = JSON.stringify(json);
  request.send(str);

  request.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var json = JSON.parse(this.responseText);
      chartsData = [];
      for (var i = 0; i < 4*ADC_WIDTH; i++) {
        chartsData[i] = json[i];
      }
      var copy = chartsData;
      allChartsData.push(copy);

      drawCharts();  //FIXME: ИЗменить то что все графики рисуются, на рисование только выделенного
      drawADC("adc_graph_1_1",1,chartsData);
      drawADC("adc_graph_2_2",2,chartsData);
      drawADC("adc_graph_3_3",3,chartsData);
      drawADC("adc_graph_4_4",4,chartsData);
      for (var i = 0; i < spectraList.length; i++)
        drawSpectrum(i+1);
      //readStatus();
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
  for (i = 0; i < ADC_WIDTH; i++) {
    //data.addRow([i,chartsData[ADC_WIDTH*(num-1)+i]]);
    x.push(i);
    y.push(chartsData[ADC_WIDTH*(num-1)+i]);
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
      title: num + " канал АЦП",
      showlegend: false
  };

  console.log(data)

  Plotly.newPlot(id, data, layout);

  document.getElementById("spectrumInfo").setAttribute("hidden","true");
      //1if (chartType=="line")
      //  var chart = new google.visualization.LineChart(document.getElementById(id));
      //if (chartType=="column")
      //  var chart = new google.visualization.ColumnChart(document.getElementById(id));
      //chart.draw(data, options);
}

function drawCharts() {
        drawADC("adc_graph_1",1,chartsData);
        drawADC("adc_graph_2",2,chartsData);
        drawADC("adc_graph_3",3,chartsData);
        drawADC("adc_graph_4",4,chartsData);
}

function drawSpectra() {
  for (var i = 0; i < (spectraList.length+1); i++)
    drawSpectrum(i);
}

  function saveCharts() {
    var txt = "";
    console.log(allChartsData)
    for (var i = 0; i < allChartsData.length; i++) {
      for (var j = 0; j < allChartsData[i].length; j++) {
        txt += j + " " + allChartsData[i][j] + "\r\n";
      }
    }
    for (var i = 0; i < spectraList.length; i++) {
      for (var j = 0; j < spectraList[i].data.length; j++) {
        txt += j + " " + spectraList[i].data[j] + "\r\n";
      }
    }
    console.log(txt);
    var blob = new Blob([txt], {type: "text/plain;charset=utf-8"});
    saveAs(blob, "data.txt");
  }

  function readStatus() {

    var regNumber = 16;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        var json = JSON.parse(this.responseText);

        if (json.data==1) {
          document.getElementById('status_text').innerHTML = "Статус: Готово!";
          document.getElementById("start_button").disabled = false;
        }
        if (json.data==2) {
        document.getElementById('status_text').innerHTML = "Статус: В работе!";
        document.getElementById("start_button").disabled = true;
      }
        console.log(this.responseText);
        console.log("receive json");
      }
    }

    request.open("POST", "", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.responseType = 'text';

    console.log({"regNumber": regNumber });
    var json = {"command" : "readRegister", "regNumber" : regNumber};
    var str = JSON.stringify(json);
    request.send(str);
    console.log("send POST")
  }


function addSpectrum(channel, point, bin_num, mode){
  var elem = document.createElement('a');
  elem.setAttribute("class","dropdown-item");
  var href = "#" + (spectraList.length+1) + "-spectrum-tab-pane"
  elem.setAttribute("href", href);
  elem.innerHTML='Спектр '+ (spectraList.length+1) + ' (Канал:' + channel + ', режим:' + mode + ')';
  elem.addEventListener('click',function(event){
    var i = event.target.href.split("/")[3].replace(/\D+/g,"");
    drawSpectrum(i);
    $(this).tab('show');
  });

  var sp_menu = document.getElementById("spectra-menu")
  sp_menu.appendChild(elem);

  var sp_item = document.getElementById("add-spectrum-item")
  sp_item.className = "dropdown-item";

  var id = "spectrum_graph_" + (spectraList.length+1);
  var text = '<table class="table table-bordered"><tbody><tr><td width="100%"><div id="' + id + '"></div></td></table>';
  var elem1 = document.createElement('div');
  elem1.setAttribute("class","tab-pane fade");
  elem1.setAttribute("id",+ (spectraList.length+1) + "-spectrum-tab-pane");
  elem1.innerHTML += text
  $('a[href="'+href+'"]').on('shown.bs.tab', function (event) {
    var i = event.target.href.split("/")[3].replace(/\D+/g,"");
    drawSpectrum(i);
  });

  var tab = document.getElementsByClassName("tab-content")
  tab[0].appendChild(elem1);

  document.getElementById(id).setAttribute("style","height:800px;")


  var sp = {channel : channel, point : point, bin_num: bin_num, mode: mode}
  spectraList.push(sp)

  console.log(spectraList)
}
function sendTriggLevel() {
    
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var level  = parseInt(document.getElementById('triggLevel0').value, 10);
        var json = {"command" : "setTriggerLevel",
                    "regNumber" : "",
                    "data" : level};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
        
        request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        level  = parseInt(document.getElementById('triggLevel1').value, 10) + 16384;
        var json = {"command" : "setTriggerLevel",
                    "regNumber" : "",
                    "data" : level};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
           
        request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        level  = parseInt(document.getElementById('triggLevel2').value, 10) + 32768;
        var json = {"command" : "setTriggerLevel",
                    "regNumber" : "",
                    "data" : level};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
        
        request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        level  = parseInt(document.getElementById('triggLevel3').value, 10) + 49152;
        var json = {"command" : "setTriggerLevel",
                    "regNumber" : "",
                    "data" : level};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
}

function deleteSpectrum(channel, point){
  var add = document.getElementById("add-spectrum-item")
  var sp = document.getElementById("spectra-menu")
  var elem = document.createElement('a');


  elem.setAttribute("class","dropdown-item");
  elem.setAttribute("href","#");
  elem.innerHTML='Спектр '+ (spectraList.length+1)
  sp.appendChild(elem);
  add.className = "dropdown-item";

  console.log(elem)
}

function drawSpectrum(num){
  var x = [];
  var y = [];
  var spectrumData = [];
  for (i = 0; i < spectraList[num-1].bin_num; i++) {
    x.push(i);
    y.push(i);
  }
  var data = [
    {
      x: x,
      y: y,
      type: "bar"
    }
  ];

  var layout = {
    title: "Амплитудный спектр " + num,
    showlegend: false
  };
  console.log(data)
  Plotly.newPlot("spectrum_graph_" + num, data, layout);

  document.getElementById("spectrumInfo").removeAttribute("hidden");
  document.getElementById("channelInfo").innerHTML = "Канал АЦП: " + spectraList[num-1].channel;
  document.getElementById("modeInfo").innerHTML = "Режим работы: " + spectraList[num-1].mode;
  if (spectraList[num-1].mode == "point")
    document.getElementById("pointInfo").innerHTML = "Опорная точка: " + spectraList[num-1].point;
  if (spectraList[num-1].mode == "maxAmpl")
  document.getElementById("pointInfo").innerHTML = "Опорной точки нет ";
  document.getElementById("basketInfo").innerHTML = "Количество корзин: " + spectraList[num-1].basketNum;

}

  $(document).ready(function(){
    drawCharts();

    $('.nav-tabs a[href="#add-spectrum"]').on('shown.bs.tab', function(event){ //FIXME: ЗАМЕНИТЬ АЛЕРТ НА МОДАЛ!!!!!!!!!!!!!!!
      $('#Modal').modal('show');
    });

    $('.nav-tabs a[href="#delete-spectrum"]').on('shown.bs.tab', function(event){ //FIXME: ЗАМЕНИТЬ АЛЕРТ НА МОДАЛ!!!!!!!!!!!!!!!
      var num = prompt("Введите номер спектра", "");
      if (num == null || num == "" || num <= 0 || num > (spectraList.length+1)) {
          txt = "Неверное значение";
      } else {
        deleteSpectrum(channel,point);
      }
    });

    $('.nav-tabs a').on('shown.bs.tab', function(event){
      var cutHref = event.target.href.split("/")[3];
      console.log(cutHref)
        switch(cutHref) {
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
            console.log(cutHref);
            break;
        }

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
      if ($('#channelADC1').prop("checked") == true)
        ch = 1;
      if ($('#channelADC2').prop("checked") == true)
        ch = 2;
      if ($('#channelADC3').prop("checked") == true)
        ch = 3;
      if ($('#channelADC4').prop("checked") == true)
        ch = 4;
      if ($('#pointMode').prop("checked") == true) {
        mode = "point";
        pt = $("#pointADC").val();
      }
      if ($('#maxAmplMode').prop("checked") == true) {
        mode = "maxAmpl";
        pt = null;
      }
      smpl = $("#basketNumber > .active").text();

      if (ch > 4 || ch < 1) {
        alert("Неправильный канал!");
        $('#add-spectrum-item').attr("class", "dropdown-item");
      } else {
        if (pt < 0 || pt > ADC_WIDTH) {
          alert("Неправильная опорная точка!");
          $('#add-spectrum-item').attr("class", "dropdown-item");
        } else {
          if (smpl < 0 || smpl > 4096 || smpl == "") {
            alert("Выберите количество корзин!");
            $('#add-spectrum-item').attr("class", "dropdown-item");
          } else {
            console.log("create Spectra");
            
            var request = new XMLHttpRequest();
            request.open("POST", "", true);
            request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.responseType = 'text';
            var json = {"command" : "setBasketNum",
                        "regNumber" : "",
                        "data" : smpl};
            var str = JSON.stringify(json)
            request.send(str);
            console.log("send POST")
            
            addSpectrum(ch,pt,smpl,mode);
          }
        }
      }
      $('#Modal').modal('hide');
    });

    $('#Modal').on('hide.bs.modal', function(event) {
      $('#add-spectrum-item').attr("class", "dropdown-item");
    });

    $("input[name='options']").change( function() {
      var value = $('#histogram_but').prop("checked");
      if (value == true)
        chartType="bar";
      if (value == false)
        chartType="line";
      drawCharts();
      drawADC("adc_graph_1_1",1,chartsData);
      drawADC("adc_graph_2_2",2,chartsData);
      drawADC("adc_graph_3_3",3,chartsData);
      drawADC("adc_graph_4_4",4,chartsData);
    });

    $("input[name='trigger_type']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#force_but').prop("checked");
        if (value == true)
            data = 1;
        if (value == false)
            data = 0;
        var json = {"command" : "setTriggerType",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });

    $("input[name='first_channel']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#first_channel_01').prop("checked");
        if (value == true)
            data = 0b0001;
        else{
            value = $('#first_channel_02').prop("checked");
            if (value == true)
                data = 0b0010;
            else
                data = 0b0011;
        }
        var json = {"command" : "setShapersConfig",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });
    
    $("input[name='second_channel']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#second_channel_01').prop("checked");
        if (value == true)
            data = 0b0101;
        else{
            value = $('#second_channel_02').prop("checked");
            if (value == true)
                data = 0b0110;
            else
                data = 0b0111;
        }
        var json = {"command" : "setShapersConfig",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });
    
    $("input[name='third_channel']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#third_channel_01').prop("checked");
        if (value == true)
            data = 0b1001;
        else{
            value = $('#third_channel_02').prop("checked");
            if (value == true)
                data = 0b1010;
            else
                data = 0b1011;
        }
        var json = {"command" : "setShapersConfig",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });

    $("input[name='fourth_channel']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#fourth_channel_01').prop("checked");
        if (value == true)
            data = 0b1101;
        else{
            value = $('#fourth_channel_02').prop("checked");
            if (value == true)
                data = 0b1110;
            else
                data = 0b1111;
        }
        var json = {"command" : "setShapersConfig",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });

    $("input[name='level_num_checkbox']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var dataCheck0 = $('#level0').prop("checked") ? 1 : 0;
        var dataCheck1 = $('#level1').prop("checked") ? 1 : 0;
        var dataCheck2 = $('#level2').prop("checked") ? 1 : 0;
        var dataCheck3 = $('#level3').prop("checked") ? 1 : 0;
        var dataCheck = dataCheck0 + dataCheck1 * 2 + dataCheck2 * 4 + dataCheck3 * 8;
        var json = {"command" : "setSelectedChannels",
                    "regNumber" : "",
                    "data" : dataCheck};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
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

//    $(window).focus(function() { 
        function funonload(){
        var trigg_type_but = document.getElementById('force_but').checked;
        var level_type_but = document.getElementById('level_but').checked;
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var json = {"command" : "updateConfigOnPage",
                    "regNumber" : "",
                    "data" : ""};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
        request.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var json = JSON.parse(this.responseText);
                console.log(this.responseText);
                console.log("receive json");
                if (json.trigger_type == "1"){
                    console.log("pipiska");
                    document.getElementById('force_but').checked = true;
                    document.getElementById('css_force_but').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_level_but').setAttribute("class", "btn btn-primary");
                }
                else{
                    document.getElementById('force_but').checked = false;
                    document.getElementById('css_force_but').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_level_but').setAttribute("class", "btn btn-primary active");
                }
                document.getElementById('level0').checked = json.selected_level&1 ? true : false;
                document.getElementById('level1').checked = json.selected_level&2 ? true : false;
                document.getElementById('level2').checked = json.selected_level&4 ? true : false;
                document.getElementById('level3').checked = json.selected_level&8 ? true : false;
                document.getElementById('triggLevel0').value = json.trigger_level_0;
                document.getElementById('triggLevel1').value = json.trigger_level_1 & 0x3FFF;
                document.getElementById('triggLevel2').value = json.trigger_level_2 & 0x3FFF;
                document.getElementById('triggLevel3').value = json.trigger_level_3 & 0x3FFF;
                if(json.shapers_config_0 == 1){
                    document.getElementById('first_channel_01').checked = true;
                    document.getElementById('css_first_channel_01').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_first_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_0 == 2){
                    document.getElementById('first_channel_02').checked = true;
                    document.getElementById('css_first_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_channel_02').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_first_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_0 == 3){
                    document.getElementById('first_channel_05').checked = true;
                    document.getElementById('css_first_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_channel_05').setAttribute("class", "btn btn-primary active");
                }

                if(json.shapers_config_1 == 1){
                    document.getElementById('second_channel_01').checked = true;
                    document.getElementById('css_second_channel_01').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_second_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_1 == 2){
                    document.getElementById('second_channel_01').checked = true;
                    document.getElementById('css_second_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_channel_02').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_second_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_1 == 3){
                    document.getElementById('second_channel_01').checked = true;
                    document.getElementById('css_second_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_channel_05').setAttribute("class", "btn btn-primary active");
                }

                if(json.shapers_config_2 == 1){
                    document.getElementById('third_channel_01').checked = true;
                    document.getElementById('css_third_channel_01').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_third_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_2 == 2){
                    document.getElementById('third_channel_01').checked = true;
                    document.getElementById('css_third_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_channel_02').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_third_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_2 == 3){
                    document.getElementById('third_channel_01').checked = true;
                    document.getElementById('css_third_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_channel_05').setAttribute("class", "btn btn-primary active");
                }

                if(json.shapers_config_3 == 1){
                    document.getElementById('fourth_channel_01').checked = true;
                    document.getElementById('css_fourth_channel_01').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_fourth_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_fourth_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_3 == 2){
                    document.getElementById('fourth_channel_01').checked = true;
                    document.getElementById('css_fourth_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_fourth_channel_02').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_fourth_channel_05').setAttribute("class", "btn btn-primary");
                }
                else if(json.shapers_config_3 == 3){
                    document.getElementById('fourth_channel_01').checked = true;
                    document.getElementById('css_fourth_channel_01').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_fourth_channel_02').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_fourth_channel_05').setAttribute("class", "btn btn-primary active");
                }
            }
        }
    };
//function funonload() {
//    $("#block").css("background-color", "yellow");
//}
window.onfocus  = funonload; 
window.onload = funonload;
  });
console.log($("input[type=radio]"))
