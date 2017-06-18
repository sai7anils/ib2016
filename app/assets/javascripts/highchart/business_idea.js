$(function () {
  var y = 0;
  var dataName = [];
  var dataX = [];
  var arrChart1 = [];
  var arrChart2 = [];
  var arrChart3 = [];
  var monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
  ];
  var totalValOfParam1  = 0;
  var totalValOfParam2 = 0;
  var totalValOfParam3 = 0;
  try{
    /*while(y < term){
      dataName.push(year_at+y);
      y++;
    }*/
    switch(term){
      case 1:
        dataName = ['1st Year'];
        break;
      case 3:
        dataName = ['1st Year', '2nd Year', '3rd Year'];
        break;
      case 5:
        dataName = ['1st Year', '2nd Year', '3rd Year', '4rd Year', '5rd Year'];
        break;
    }

    for(var i = month_at; i < 12 + month_at; i++){
      if(i > 11){
        c = i - 12;
      }else{
        c = i;
      }
      dataX.push(monthNames[c]);
    }
    if(revenue_type != 2){
      totalValOfParam1 = sumValOfArr(paramsData1);
    }else{
      totalValOfParam1 = minutesToHour(sumValOfArr(paramsData1));
    }
    totalValOfParam2 = sumValOfArr(paramsData2);
    totalValOfParam3 = sumValOfArr(paramsData3);
  }catch(err){}

  $('.btn-show-all').click(function(event) {
    $('.show-all-section .form-info').toggleClass('active');
    $('.btn-show-all').toggleClass('active');
    renderChart();
    $('.view-total-val').text('Total : '+totalValOfParam1);
    event.stopPropagation();
  });

  $('.tab-param-action').on('click', function(){
    var tab = $(this).attr('id');
    $('.tab-param').removeClass('active');
    $('.tab-param-action').removeClass('active');
    $('.'+tab).addClass('active');
    $(this).addClass('active');
    renderChart();
    var data_id = parseInt($(this).attr('data-id'));
    switch(data_id){
      case 1:
        $('.view-total-val').text('Total : '+totalValOfParam1);
        break;
      case 2:
        $('.view-total-val').text('Total : '+totalValOfParam2);
        break;
      case 3:
        $('.view-total-val').text('Total : '+totalValOfParam3);
        break;
    }
  });

  function renderChart(){
    arrChart1 = [];
    arrChart2 = [];
    arrChart3 = [];
    switch(revenue_type){
      case 1:
        revenueType1();
        break;
      case 2:
        revenueType2();
        break;
      case 3:
        revenueType3();
        break;
      case 4:
        revenueType4();
        break;
    }
  }

  function revenueType1(){
    var v = 1;
    for(var k = 0; k < term; k ++){
      var arrData1 = [];
      var arrData2 = [];
      for(var i = month_at; i < 12 + month_at; i++){
        if(i > 11){
          c = i - 12;
        }else{
          c = i;
        }
        var arr1 = [monthNames[c], parseInt(paramsData1[v])]
        var arr2 = [monthNames[c], parseInt(paramsData2[v])]
        arrData1.push(arr1);
        arrData2.push(arr2);
        v++;
      }
      arrChart1.push({name: dataName[k], data: arrData1});
      arrChart2.push({name: dataName[k], data: arrData2});
    }
    normalAreaChart($('#container-chart-1'), arrChart1, dataX);
    normalAreaChart($('#container-chart-2'), arrChart2, dataX);
  }

  function revenueType2(){
    var v = 1;
    for(var k = 0; k < term; k ++){
      var arrData1 = [];
      var arrData2 = [];
      for(var i = month_at; i < 12 + month_at; i++){
        if(i > 11){
          c = i - 12;
        }else{
          c = i;
        }
        var arr1 = [monthNames[c], parseInt(paramsData1[v])*60]
        var arr2 = [monthNames[c], parseInt(paramsData2[v])]
        arrData1.push(arr1);
        arrData2.push(arr2);
        v++;
      }
      arrChart1.push({name: dataName[k], data: arrData1});
      arrChart2.push({name: dataName[k], data: arrData2});
    }
    hoursAreaChart($('#container-chart-1'), arrChart1, dataX);
    normalAreaChart($('#container-chart-2'), arrChart2, dataX);
  }

  function revenueType3(){
    var v = 1;
    for(var k = 0; k < term; k ++){
      var arrData1 = [];
      var arrData2 = [];
      var arrData3 = [];
      for(var i = month_at; i < 12 + month_at; i++){
        if(i > 11){
          c = i - 12;
        }else{
          c = i;
        }
        var arr1 = [monthNames[c], parseInt(paramsData1[v])]
        var arr2 = [monthNames[c], parseInt(paramsData2[v])]
        var arr3 = [monthNames[c], parseInt(paramsData3[v])]
        arrData1.push(arr1);
        arrData2.push(arr2);
        arrData3.push(arr3);
        v++;
      }
      arrChart1.push({name: dataName[k], data: arrData1});
      arrChart2.push({name: dataName[k], data: arrData2});
      arrChart3.push({name: dataName[k], data: arrData3});
    }
    normalAreaChart($('#container-chart-1'), arrChart1, dataX);
    normalAreaChart($('#container-chart-2'), arrChart2, dataX);
    normalAreaChart($('#container-chart-3'), arrChart3, dataX);
  }

  function revenueType4(){
    var v = 1;
    for(var k = 0; k < term; k ++){
      var arrData1 = [];
      for(var i = month_at; i < 12 + month_at; i++){
        if(i > 11){
          c = i - 12;
        }else{
          c = i;
        }
        var arr1 = [monthNames[c], parseInt(paramsData1[v])]
        arrData1.push(arr1);
        v++;
      }
      arrChart1.push({name: dataName[k], data: arrData1});
    }
    normalAreaChart($('#container-chart-1'), arrChart1, dataX);
  }
});

function normalAreaChart($element, data, dataX){
  try{
    $element.highcharts({
      chart: {
        type: 'areaspline'
      },
      title: {
        text: '',
      },
      credits: {
        enabled: false
      },
      xAxis: {
        labels: {
          formatter: function() {
            return dataX[this.value];
          }
        }
      },
      yAxis: {
       title: {
        text: '',
        style: {
          fontFamily: 'Arial'
          },
        align:'high',
        rotation:0,
        y: 5,
        offset: -50
        }
      },
      series: data
    });
  }catch(err){}
}

function hoursAreaChart($element, data, dataX){
  try{
    $element.highcharts({
      chart: {
        type: 'areaspline'
      },
      title: {
        text: '',
      },
      credits: {
        enabled: false
      },
      xAxis: {
        labels: {
          formatter: function() {
            return dataX[this.value];
          }
        }
      },
      tooltip: {
         formatter: function() {
            var time = this.point.y;
            var hours1=parseInt(time/3600);
            var mins1=parseInt((parseInt(time%3600))/60);
            if (mins1 == 0 ){
              mins1 = "00";
            }
            return hours1 + ':' + mins1;
         }
      },
      yAxis: {
        labels:{
         formatter: function () {
              var time = this.value;
              var hours1=parseInt(time/3600);
              var mins1=parseInt((parseInt(time%3600))/60);
              return hours1 + ':' + mins1;
          }
       },
       title: {
        text: '',
        style: {
          fontFamily: 'Arial'
          },
          align:'high',
          rotation:0,
          y: 0,
          offset: 0
        }
      },
      series: data
    });
  }catch(err){}
}

function sumValOfArr(myData) {
  var myTotal = 0;
  for(var i = 1, len = Object.keys(myData).length; i <= len; i++) {
   myTotal = myTotal + parseInt(myData[i]);
  }
  return myTotal;
}

function minutesToHour(time){
  time = time * 60;
  var hours1=parseInt(time/3600);
  var mins1=parseInt((parseInt(time%3600))/60);
  if (mins1 == 0 ){
    mins1 = "00";
  }
  return hours1 + ':' + mins1;
}
