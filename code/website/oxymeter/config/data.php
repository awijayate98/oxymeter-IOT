<?php
	include('login.php');
    //baca data tabel
    $waktuupdate = mysqli_query($konek,"SELECT * FROM t_energy ORDER BY ID ASC");
    $datakwh = mysqli_query($konek,"SELECT kwh FROM t_energy ORDER BY ID ASC");
    $datavolt = mysqli_query($konek,"SELECT Volt FROM t_energy ORDER BY ID ASC");
    $dataamper = mysqli_query($konek,"SELECT Amper FROM t_energy ORDER BY ID ASC");
    $datawatt = mysqli_query($konek,"SELECT watt FROM t_energy ORDER BY ID ASC");
	  $datafrek = mysqli_query($konek,"SELECT Frek FROM t_energy ORDER BY ID ASC");
?>

<script type="text/javascript">
  ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9", "b55b025e438fa8a98e32482b5f768ff5"]; // DEFINE CHART LOCATIONS (IDS)
		    // -----------------------------
		    // Main chart render location
		    let chart1Id = 'chart1';
		    let chart2Id = 'chart2';
		    let chart3Id = 'chart3';
		
		    // CHART DATA
		    // -----------------------------
		
		    
		    let sales = [
		      [19.98],
		      [9.99],
		      [9.99],
		      [29.97],
		      [9.99]
		    ];
		    let income = [
		      500, 1000, 2500, 700, 3500, 600, 1000, 1000, 1000, 800, 3000, 4500, 5000,
		    ];
		    let dates = [
		      '01/07',
		      '02/07',
		      '03/07',
		      '04/07',
		      '05/07',
		      '06/07',
		      '07/07',
		      '08/07',
		      '09/07',
		      '10/07',
		      '11/07',
		      '12/07',
		      '13/07',
		    ];
		
		    // CHART CONFIG
		    // -----------------------------
		
		    // Chart 1
		    let chart1Data = {
		      type: 'ring',
		      globals: {
		        fontFamily: 'Poppins',
		      },
		      backgroundColor: 'transparent',
		      plot: {
		        valueBox: {
		          text: '81%<br>On Time',
		          fontSize: '24px',
		          fontStyle: 'normal',
		          fontWeight: 'normal',
		          placement: 'center',
		        },
		        slice: '80%',
		      },
		      plotarea: {
		        margin: '0px 0px 0px 0px',
		      },
		      series: [{
		          values: [81],
		          backgroundColor: 'var(--yellow)',
		          borderWidth: '0px',
		          shadow: false,
		        },
		        {
		          values: [29],
		          backgroundColor: 'var(--red)',
		          borderWidth: '0px',
		          shadow: false,
		        },
            {
		          values: [29],
		          backgroundColor: 'var(--green)',
		          borderWidth: '0px',
		          shadow: false,
		        },
            {
		          values: [29],
		          backgroundColor: 'var(--)',
		          borderWidth: '0px',
		          shadow: false,
		        },
		      ],
		    };
		
		    // Chart 2
		    let chart2Data = {
		      type: 'hbar',
		      globals: {
		        fontFamily: 'Poppins',
		      },
		      backgroundColor: 'transparent',
		      title: {
		        text: 'Orders',
		        align: 'left',
		        fontColor: 'var(--lightGray)',
		        fontWeight: 'normal',
		        padding: '16px',
		      },
		      plot: {
		        tooltip: {
		          visible: false,
		        },
		        barSpace: '32px',
		        barWidth: '12px',
		        borderWidth: '0px',
		      },
		      plotarea: {
		        margin: '40px 56px 16px 56px',
		      },
		      scaleY: {
		        visible: false,
		      },
		      scaleX: {
		        labels: [],
		        lineWidth: '0px',
		        tick: {
		          visible: false,
		        },
		      },
		      scaleX2: {
		        values: [
		          '$' + sales[0],
		          '$' + sales[1],
		          '$' + sales[2],
		          '$' + sales[3],
		          '$' + sales[4],
		        ],
		        lineWidth: '0px',
		        tick: {
		          visible: false,
		        },
		      },
		      series: [{
		          values: sales[0],
		          backgroundColor: 'var(--yellow)',
		        },
		        {
		          values: sales[1],
		          backgroundColor: 'var(--yellow)',
		        },
		        {
		          values: sales[2],
		          backgroundColor: 'var(--yellow)',
		        },
		        {
		          values: sales[3],
		          backgroundColor: 'var(--yellow)',
		        },
		        {
		          values: sales[4],
		          backgroundColor: 'var(--yellow)',
		        },
		      ],
		    };
		
		    // Chart 3
		    let chart3Data = {
		      type: 'line',
		      globals: {
		        fontFamily: 'Poppins',
		      },
		      backgroundColor: 'transparent',
		      scaleX: {
		        labels: dates,
		        tick: {
		          visible: false,
		        },
		      },
		      scaleY: {
		        values: '0: 5000: 2500',
		        guide: {
		          lineStyle: 'solid',
		          lineColor: 'var(--lightGray)',
		        },
		        lineWidth: '0px',
		        tick: {
		          visible: false,
		        },
		      },
		      series: [{
		        values: income,
		        lineColor: 'var(--yellow)',
		        lineWidth: '5px',
		        marker: {
		          backgroundColor: 'var(--lightPurple)',
		          borderColor: 'var(--yellow)',
		          borderWidth: 3,
		          size: 8,
		        },
		      }, ],
		    };
		
		    // RENDER CHARTS
		    // -----------------------------
		
		    // Chart 1
			zingchart.render({
        id: chart1Id,
        data: chart1Data,
        height: '300px',
        width: '100%',
      });
		
		    // Chart 2
		    zingchart.render({
		      id: chart2Id,
		      data: chart2Data,
		      height: '300px',
		      width: '100%',
		    });
		
		    // Chart 3
		    zingchart.render({
		      id: chart3Id,
		      data: chart3Data,
		      height: '250px',
		      width: '100%',
		    });
	</script>