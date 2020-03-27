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
      function addValueToSpectra(chartsData, spectraList){
        for (var i = 0; i < spectraList.length; i++) {
          var channel = parseInt(spectraList[i].channel);
          if (spectraList[i].mode == "point") {
            var point = parseInt(spectraList[i].point);
            var value = chartsData[(channel-1)*ADC_WIDTH+point];
            for (var j = 0; j < parseInt(spectraList[i].basketNum) - 1; j++) {
              var minEdge = 4096/spectraList[i].basketNum*j;
              var maxEdge = 4096/spectraList[i].basketNum*(j+1);
              if (value > minEdge & value <= maxEdge) {
                spectraList[i].data[j+1] += 1;
                break;
              }
            }
          }
          if (spectraList[i].mode == "maxAmpl") {
            var value = chartsData[(channel-1)*ADC_WIDTH];
            for (l = 0; l < ADC_WIDTH; l++) {
              if (value < chartsData[(channel-1)*ADC_WIDTH+l])
                value = chartsData[(channel-1)*ADC_WIDTH+l];
            }
            for (var j = 0; j < parseInt(spectraList[i].basketNum) - 1; j++) {
              var minEdge = 4096/spectraList[i].basketNum*j;
              var maxEdge = 4096/spectraList[i].basketNum*(j+1);
              if (value > minEdge & value <= maxEdge) {
                spectraList[i].data[j+1] += 1;
                break;
              }
            }
          }
        }
      };

      addValueToSpectra(chartsData, spectraList);
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


function addSpectrum(channel, point, basketNum, mode){
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


  var maxAmpl = 100;
  var dat = []
  for (var i = 0; i < basketNum; i++)
    dat.push(0);
  var sp = {channel : channel, point : point, basketNum: basketNum, mode: mode ,data : dat}
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
  for (i = 0; i < spectraList[num-1].data.length; i++) {
    //data.addRow([i,chartsData[ADC_WIDTH*(num-1)+i]]);
    x.push(i);
    y.push(spectraList[num-1].data[i]);
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

  });
console.log($("input[type=radio]"))
