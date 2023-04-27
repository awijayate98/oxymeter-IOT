type = ['primary', 'info', 'success', 'warning', 'danger'];
demo2 = {
initDashboardPageCharts: function() {
  $.getJSON("config/upall.php",
      function(result) {
          var akhir = result.length - 1;

          let update = result[akhir].update_time;
          let heart = result[akhir].heart;
          let spo = result[akhir].spo;
          let temp = result[akhir].temp;
          let r = result[akhir].value_r;
          let g = result[akhir].value_g;
          let b = result[akhir].value_b;
          let arr_update = [];
          let arr_heart  =[];
          let arr_spo  =[];
          let arr_temp  =[];

          for (var i in result)
          {
            arr_update.push(result[i].update_time);
            arr_heart.push(result[i].heart);
            arr_spo.push(result[i].spo);
            arr_temp.push(result[i].temp);
           }
           console.log(arr_update);

           gradientChartOptionsConfigurationWithTooltipBlue = {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
            tooltips: {
              backgroundColor: '#f5f5f5',
              titleFontColor: '#333',
              bodyFontColor: '#666',
              bodySpacing: 4,
              xPadding: 12,
              mode: "nearest",
              intersect: 0,
              position: "nearest"
            },
            responsive: true,
            scales: {
              yAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.0)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  suggestedMin: 60,
                  suggestedMax: 125,
                  padding: 20,
                  fontColor: "#2380f7"
                }
              }],
      
              xAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  padding: 20,
                  fontColor: "#2380f7"
                }
              }]
            }
          };
      
          gradientChartOptionsConfigurationWithTooltipPurple = {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
      
            tooltips: {
              backgroundColor: '#f5f5f5',
              titleFontColor: '#333',
              bodyFontColor: '#666',
              bodySpacing: 4,
              xPadding: 12,
              mode: "nearest",
              intersect: 0,
              position: "nearest"
            },
            responsive: true,
            scales: {
              yAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.0)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  suggestedMin: 60,
                  suggestedMax: 125,
                  padding: 20,
                  fontColor: "#9a9a9a"
                }
              }],
      
              xAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(225,78,202,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  padding: 20,
                  fontColor: "#9a9a9a"
                }
              }]
            }
          };
      
          gradientChartOptionsConfigurationWithTooltipOrange = {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
      
            tooltips: {
              backgroundColor: '#f5f5f5',
              titleFontColor: '#333',
              bodyFontColor: '#666',
              bodySpacing: 4,
              xPadding: 12,
              mode: "nearest",
              intersect: 0,
              position: "nearest"
            },
            responsive: true,
            scales: {
              yAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.0)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  suggestedMin: 50,
                  suggestedMax: 110,
                  padding: 20,
                  fontColor: "#ff8a76"
                }
              }],
      
              xAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(220,53,69,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  padding: 20,
                  fontColor: "#ff8a76"
                }
              }]
            }
          };
      
          gradientChartOptionsConfigurationWithTooltipGreen = {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
      
            tooltips: {
              backgroundColor: '#f5f5f5',
              titleFontColor: '#333',
              bodyFontColor: '#666',
              bodySpacing: 4,
              xPadding: 12,
              mode: "nearest",
              intersect: 0,
              position: "nearest"
            },
            responsive: true,
            scales: {
              yAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.0)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  suggestedMin: 50,
                  suggestedMax: 125,
                  padding: 20,
                  fontColor: "#9e9e9e"
                }
              }],
      
              xAxes: [{
                barPercentage: 1.6,
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(0,242,195,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  padding: 20,
                  fontColor: "#9e9e9e"
                }
              }]
            }
          };
      
      
          gradientBarChartConfiguration = {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
      
            tooltips: {
              backgroundColor: '#f5f5f5',
              titleFontColor: '#333',
              bodyFontColor: '#666',
              bodySpacing: 4,
              xPadding: 12,
              mode: "nearest",
              intersect: 0,
              position: "nearest"
            },
            responsive: true,
            scales: {
              yAxes: [{
      
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  suggestedMin: 60,
                  suggestedMax: 120,
                  padding: 20,
                  fontColor: "#9e9e9e"
                }
              }],
      
              xAxes: [{
      
                gridLines: {
                  drawBorder: false,
                  color: 'rgba(29,140,248,0.1)',
                  zeroLineColor: "transparent",
                },
                ticks: {
                  padding: 20,
                  fontColor: "#9e9e9e"
                }
              }]
            }
          };
      
          var ctx = document.getElementById("chartLinePurple").getContext("2d");
      
          var gradientStroke = ctx.createLinearGradient(0, 230, 0, 50);
      
          gradientStroke.addColorStop(1, 'rgba(72,72,176,0.2)');
          gradientStroke.addColorStop(0.2, 'rgba(72,72,176,0.0)');
          gradientStroke.addColorStop(0, 'rgba(119,52,169,0)'); //purple colors
      
          var data = {
            labels: arr_update,
            datasets: [{
              label: "Data",
              fill: true,
              backgroundColor: gradientStroke,
              borderColor: '#d048b6',
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              pointBackgroundColor: '#d048b6',
              pointBorderColor: 'rgba(255,255,255,0)',
              pointHoverBackgroundColor: '#d048b6',
              pointBorderWidth: 20,
              pointHoverRadius: 4,
              pointHoverBorderWidth: 15,
              pointRadius: 4,
              data: arr_heart,
            }]
          };
      
          var myChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: gradientChartOptionsConfigurationWithTooltipPurple
          });

          var ctx = document.getElementById("chartLinePurple2").getContext("2d");
      
          var gradientStroke = ctx.createLinearGradient(0, 230, 0, 50);
      
          gradientStroke.addColorStop(1, 'rgba(72,72,176,0.2)');
          gradientStroke.addColorStop(0.2, 'rgba(72,72,176,0.0)');
          gradientStroke.addColorStop(0, 'rgba(119,52,169,0)'); //purple colors
      
          var data = {
            labels: arr_update,
            datasets: [{
              label: "Data",
              fill: true,
              backgroundColor: gradientStroke,
              borderColor: '#d048b6',
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              pointBackgroundColor: '#d048b6',
              pointBorderColor: 'rgba(255,255,255,0)',
              pointHoverBackgroundColor: '#d048b6',
              pointBorderWidth: 20,
              pointHoverRadius: 4,
              pointHoverBorderWidth: 15,
              pointRadius: 4,
              data: arr_temp,
            }]
          };
      
          var myChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: gradientChartOptionsConfigurationWithTooltipPurple
          });


      
      
          var ctxGreen = document.getElementById("chartLineGreen").getContext("2d");
      
          var gradientStroke = ctx.createLinearGradient(0, 230, 0, 50);
      
          gradientStroke.addColorStop(1, 'rgba(66,134,121,0.15)');
          gradientStroke.addColorStop(0.4, 'rgba(66,134,121,0.0)'); //green colors
          gradientStroke.addColorStop(0, 'rgba(66,134,121,0)'); //green colors
      
          var data = {
            labels: arr_update,
            datasets: [{
              label: "My First dataset",
              fill: true,
              backgroundColor: gradientStroke,
              borderColor: '#00d6b4',
              borderWidth: 2,
              borderDash: [],
              borderDashOffset: 0.0,
              pointBackgroundColor: '#00d6b4',
              pointBorderColor: 'rgba(255,255,255,0)',
              pointHoverBackgroundColor: '#00d6b4',
              pointBorderWidth: 20,
              pointHoverRadius: 4,
              pointHoverBorderWidth: 15,
              pointRadius: 4,
              data: arr_spo,
            }]
          };
      
          var myChart = new Chart(ctxGreen, {
            type: 'line',
            data: data,
            options: gradientChartOptionsConfigurationWithTooltipGreen
      
          });
      
    
          var ctx = document.getElementById("chartBig1").getContext('2d');
      
          var gradientStroke = ctx.createLinearGradient(0, 230, 0, 50);
      
          gradientStroke.addColorStop(1, 'rgba(72,72,176,0.1)');
          gradientStroke.addColorStop(0.4, 'rgba(72,72,176,0.0)');
          gradientStroke.addColorStop(0, 'rgba(119,52,169,0)'); //purple colors
          var config = {
            type: 'line',
            data: {
              labels: arr_update,
              datasets: [{
                label: "Hearts bpm",
                fill: true,
                backgroundColor: gradientStroke,
                borderColor: '#d346b1',
                borderWidth: 2,
                borderDash: [],
                borderDashOffset: 0.0,
                pointBackgroundColor: '#d346b1',
                pointBorderColor: 'rgba(255,255,255,0)',
                pointHoverBackgroundColor: '#d346b1',
                pointBorderWidth: 20,
                pointHoverRadius: 4,
                pointHoverBorderWidth: 15,
                pointRadius: 4,
                data: arr_heart,
              }]
            },
            options: gradientChartOptionsConfigurationWithTooltipPurple
          };
          var myChartData = new Chart(ctx, config);
          $("#0").click(function() {
            var data = myChartData.config.data;
            data.datasets[0].label = "Hearts bpm";
            data.datasets[0].data = arr_heart;
            myChartData.update();
          });
          $("#1").click(function() {
            var data = myChartData.config.data;
            data.datasets[0].data = arr_spo;
            data.datasets[0].label = "SPO";
            myChartData.update();
          });
          $("#2").click(function() {
            var data = myChartData.config.data;
            data.datasets[0].data = arr_temp;
            data.datasets[0].label = "Temperature";
            myChartData.update();
          });
          document.getElementById("heart1").innerHTML = result[akhir].heart;
          document.getElementById("spo1").innerHTML = spo;
          document.getElementById("temp1").innerHTML = temp;
          
      });
    },
    showNotification: function(from, align) {
      color = Math.floor((Math.random() * 4) + 1);
  
      $.notify({
        icon: "tim-icons icon-bell-55",
        message: "<b>MENGUPDATE DATA</b>"

      }, {
        type: type[color],
        timer: 8000,
        placement: {
          from: from,
          align: align
        }
      });
    }
    
}

