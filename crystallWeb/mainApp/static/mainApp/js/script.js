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

  json = {"command" : "read_charts"};
  str = JSON.stringify(json);
  request.send(str);

  request.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var json = JSON.parse(this.responseText);
      chartsData = [];
      for (var i = 0; i < 4 * OSCILLOGRAM_WIDTH; i++) {
        chartsData[i] = json[i];
      }
      var copy = chartsData;
      allChartsData.push(copy);

      drawCharts();  //FIXME: ИЗменить то что все графики рисуются, на рисование только выделенного
   //   drawADC("adc_graph_1_1",1,chartsData);
   //   drawADC("adc_graph_2_2",2,chartsData);
   //   drawADC("adc_graph_3_3",3,chartsData);
   //   drawADC("adc_graph_4_4",4,chartsData);
    }
    

      var copy = spectrum_data;
      allChartsData.push(copy);

      for (var i = 0; i < spectra_list.length; i++){
          if(spectra_list[i].channel != -1)
        drawSpectrum(i);
      }
      //readStatus();
    //  }
   // }
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
    //data.addRow([i,chartsData[OSCILLOGRAM_WIDTH*(num-1)+i]]);
    x.push(i);
    y.push(chartsData[i * 4 + (num-1)]);
    console.log(chartsData[i * 4 + (num-1)]);
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

function drawSpectrum(num){  
 
  request = new XMLHttpRequest();
  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';

  json = {"command"      : "readSpectrum",
          "spectrum_num" : num
  };
  str = JSON.stringify(json);
  request.send(str);

  request.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var json = JSON.parse(this.responseText);
      spectrum_data = [];
      for (var i = 0; i < 4*OSCILLOGRAM_WIDTH; i++) {
        spectrum_data[i] = json[i];
      }
    }
  }
  var x = [];
  var y = [];
  var spectrumData = [];
  for (i = 0; i < spectra_list[num].bin_num; i++) {
    x.push(i);
    y.push(spectrum_data[i]);
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
    title: "Амплитудный спектр " + num,
    showlegend: false
  };
  console.log(data)
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

function drawSpectra() {
  for (var i = 0; i < (spectra_list.length); i++){
        if(spectra_list[i].channel != -1)
            drawSpectrum(i);
    }
}

  function saveCharts() {
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


function addSpectrum(channel, point, bin_num, mode, spectrum_num){
  var request = new XMLHttpRequest();
  request.open("POST", "", true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.responseType = 'text';
  var json = {"command" : "set_spectrum_conf",
              "spectrum_num" : spectrum_num,
              "point"   : point,
              "bins_num": bin_num};
  var str = JSON.stringify(json)
  request.send(str);
  console.log("send POST")
            
  var elem = document.createElement('a');
  elem.setAttribute("class","dropdown-item");
  var href = "#" + (spectrum_num) + "-spectrum-tab-pane"
  elem.setAttribute("href", href);
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
  elem1.setAttribute("id",+ (spectrum_num) + "-spectrum-tab-pane");
  elem1.innerHTML += text
  $('a[href="'+href+'"]').on('shown.bs.tab', function (event) {
    var i = event.target.href.split("/")[3].replace(/\D+/g,"");
    drawSpectrum(i);
  });

  var tab = document.getElementsByClassName("tab-content")
  tab[0].appendChild(elem1);

  document.getElementById(id).setAttribute("style","height:800px;")


  var sp = {channel : channel, point : point, bin_num: bin_num, mode: mode}
  spectra_list[spectrum_num] = sp

  console.log(spectra_list)
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

function deleteSpectrum(num){
    var add = document.getElementById("add-spectrum-item")
    var sp = document.getElementById("spectra-menu")
    var elem = document.createElement('a');


    elem.setAttribute("class","dropdown-item");
    elem.setAttribute("href","#");
    elem.innerHTML='Спектр '+ (num)
    sp.appendChild(elem);
    add.className = "dropdown-item";

    spectra_list[num].channel = -1;

    console.log(elem)
}


  $(document).ready(function(){
    drawCharts();

    $('.nav-tabs a[href="#add-spectrum"]').on('shown.bs.tab', function(event){ //FIXME: ЗАМЕНИТЬ АЛЕРТ НА МОДАЛ!!!!!!!!!!!!!!!
      $('#Modal').modal('show');
    });

    $('.nav-tabs a[href="#delete-spectrum"]').on('shown.bs.tab', function(event){ //FIXME: ЗАМЕНИТЬ АЛЕРТ НА МОДАЛ!!!!!!!!!!!!!!!
      var num = prompt("Введите номер спектра", "");
      if (num == null || num == "" || num <= 0 || num > (spectra_list.length) || spectra_list[num].channel == -1) {
          txt = "Неверное значение";
      } else {
        deleteSpectrum(num);
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
      var spectrum_num;
      if ($('#channelADC1').prop("checked") == true)
        ch = 1;
      if ($('#channelADC2').prop("checked") == true)
        ch = 2;
      if ($('#channelADC3').prop("checked") == true)
        ch = 3;
      if ($('#channelADC4').prop("checked") == true)
        ch = 4;
      if ($('#pointMode').prop("checked") == true) {
        mode = 1;
        pt = $("#pointADC").val();
      }
      if ($('#maxAmplMode').prop("checked") == true) {
        mode = 0;
        pt = null;
      }
      smpl = $("#basketNumber > .active").text();

      if (ch > 4 || ch < 1) {
        alert("Неправильный канал!");
        $('#add-spectrum-item').attr("class", "dropdown-item");
      } else {
        if (pt < 0 || pt > OSCILLOGRAM_WIDTH) {
          alert("Неправильная опорная точка!");
          $('#add-spectrum-item').attr("class", "dropdown-item");
        } else {
          if (smpl < 0 || smpl > 4096 || smpl == "") {
            alert("Выберите количество корзин!");
            $('#add-spectrum-item').attr("class", "dropdown-item");
          } else {
            console.log("create Spectra");
            
            spectrum_num = (ch-1)*3 + mode;
            
            if(spectra_list[spectrum_num].channel == -1)
                addSpectrum(ch, pt, smpl, mode, spectrum_num);
            else if (mode == 1 && spectra_list[spectrum_num+1].channel == -1)
                addSpectrum(ch, pt, smpl, mode, spectrum_num + 1);
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
      drawSpectra();
//      drawADC("adc_graph_1_1",1,chartsData);
//      drawADC("adc_graph_2_2",2,chartsData);
//      drawADC("adc_graph_3_3",3,chartsData);
//      drawADC("adc_graph_4_4",4,chartsData);
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

    $("input[name='first_ampl']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#first_ampl_1').prop("checked");
        if (value == true)
            data = 0b0000;
        else{
            value = $('#first_ampl_2').prop("checked");
            if (value == true)
                data = 0b0001;
            else{
                value = $('#first_ampl_4').prop("checked");
                if (value == true)
                    data = 0b0010;
                else
                    data = 0b0011;
            }
        }
        var json = {"command" : "set_ampl_config",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });

    $("input[name='second_ampl']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#second_ampl_1').prop("checked");
        if (value == true)
            data = 0b0100;
        else{
            value = $('#second_ampl_2').prop("checked");
            if (value == true)
                data = 0b0101;
            else{
                value = $('#second_ampl_4').prop("checked");
                if (value == true)
                    data = 0b0110;
                else
                    data = 0b0111;
            }
        }
        var json = {"command" : "set_ampl_config",
                    "regNumber" : "",
                    "data" : data};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
    });

    $("input[name='third_ampl']").change( function() {
        var request = new XMLHttpRequest();
        request.open("POST", "", true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.responseType = 'text';
        var data = 0;
        var value = $('#third_ampl_1').prop("checked");
        if (value == true)
            data = 0b1000;
        else{
            value = $('#third_ampl_2').prop("checked");
            if (value == true)
                data = 0b1001;
            else{
                value = $('#third_ampl_4').prop("checked");
                if (value == true)
                    data = 0b1010;
                else
                    data = 0b1011;
            }
        }
        var json = {"command" : "set_ampl_config",
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
        var json = {"command" : "update_config_on_page",
                    "regNumber" : "",
                    "data" : ""};
        var str = JSON.stringify(json)
        request.send(str);
        console.log("send POST")
        request.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var json = JSON.parse(this.responseText);
                console.log(this.responseText);
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

                if(json.ampl_config_0 == 0){
                    document.getElementById('first_ampl_1').checked = true;
                    document.getElementById('css_first_ampl_1').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_first_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_0 == 1){
                    document.getElementById('first_ampl_1').checked = true;
                    document.getElementById('css_first_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_2').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_first_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_0 == 2){
                    document.getElementById('first_ampl_1').checked = true;
                    document.getElementById('css_first_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_4').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_first_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_0 == 3){
                    document.getElementById('first_ampl_1').checked = true;
                    document.getElementById('css_first_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_first_ampl_5').setAttribute("class", "btn btn-primary active");
                }

                if(json.ampl_config_1 == 0){
                    document.getElementById('second_ampl_1').checked = true;
                    document.getElementById('css_second_ampl_1').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_second_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_1 == 1){
                    document.getElementById('second_ampl_1').checked = true;
                    document.getElementById('css_second_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_2').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_second_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_1 == 2){
                    document.getElementById('second_ampl_1').checked = true;
                    document.getElementById('css_second_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_4').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_second_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_1 == 3){
                    document.getElementById('second_ampl_1').checked = true;
                    document.getElementById('css_second_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_second_ampl_5').setAttribute("class", "btn btn-primary active");
                }

                if(json.ampl_config_2 == 0){
                    document.getElementById('third_ampl_1').checked = true;
                    document.getElementById('css_third_ampl_1').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_third_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_2 == 1){
                    document.getElementById('third_ampl_1').checked = true;
                    document.getElementById('css_third_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_2').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_third_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_2 == 2){
                    document.getElementById('third_ampl_1').checked = true;
                    document.getElementById('css_third_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_4').setAttribute("class", "btn btn-primary active");
                    document.getElementById('css_third_ampl_5').setAttribute("class", "btn btn-primary");
                }
                else if(json.ampl_config_2 == 3){
                    document.getElementById('third_ampl_1').checked = true;
                    document.getElementById('css_third_ampl_1').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_2').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_4').setAttribute("class", "btn btn-primary");
                    document.getElementById('css_third_ampl_5').setAttribute("class", "btn btn-primary active");
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
