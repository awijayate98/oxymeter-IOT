<?php
include "login.php";
date_default_timezone_set('Asia/Jakarta');
$update_time = date("Y-j-M H:i:s");
$api_key_value = "tPmAT5Ab3j7F1";
$api_key= $heart = $temp = $spo = $r = $g = $b = $kondisi = "";
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $api_key = test_input($_GET['api_key']);
    if($api_key == $api_key_value) {
            $heart = test_input($_GET['heart']);
            $temp = test_input($_GET['temp']);
            $spo = test_input($_GET['spo']);
            $r = test_input($_GET['r']);
            $g = test_input($_GET['g']);
            $b = test_input($_GET['b']);
            $kondisi = test_input($_GET['status_s']);
            $simpan = mysqli_query($konek, "INSERT INTO t_data(heart,spo,temp,value_r,value_g,value_b,update_time,s_kondisi)VALUES('$heart','$spo','$temp','$r',' $g','$b','$update_time','$kondisi')");
    }
    else {
        echo "Wrong API Key provided.";
    }

}
else {
    echo "No data posted with HTTP POST.";
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}