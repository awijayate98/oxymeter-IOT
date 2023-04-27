<?php
include "login.php";
      $kode = $_POST['kode'];
      if($kode == "set_data")
      {
        $first_name = mysqli_real_escape_string($konek, $_POST["first_name"]);
        $last_name = mysqli_real_escape_string($konek, $_POST["last_name"]);
        $email = mysqli_real_escape_string($konek, $_POST["email"]);
        $school = mysqli_real_escape_string($konek, $_POST["school"]);
        $prodi = mysqli_real_escape_string($konek, $_POST["prodi"]);
        $about = mysqli_real_escape_string($konek, $_POST["about"]);
        $nim = mysqli_real_escape_string($konek, $_POST["nim"]);
        $userid = mysqli_real_escape_string($konek, $_POST["id"]);
        $query= "UPDATE `t_user` SET first_name='$first_name',last_name ='$last_name', email ='$email', school ='$school', prodi='$prodi',about ='$about',nim ='$nim' where id = '$userid'";
      }elseif ($kode == "set_oxy") {
        $userid = mysqli_real_escape_string($konek, $_POST["id"]);
        $counter = mysqli_real_escape_string($konek, $_POST["counter"]);
        $millis = mysqli_real_escape_string($konek, $_POST["millis"]);
        $parameter1 = mysqli_real_escape_string($konek, $_POST["parameter1"]);
        $parameter2 = mysqli_real_escape_string($konek, $_POST["parameter2"]);
        $textnormal = mysqli_real_escape_string($konek, $_POST["textnormal"]);
        $text_tidaknormal = mysqli_real_escape_string($konek, $_POST["text_tidaknormal"]);
        $query= "UPDATE `t_setting` SET counter='$counter',millis ='$millis' ,parameter1='$parameter1',parameter2 ='$parameter2', status_cek ='$text_tidaknormal', status_normal ='$textnormal'  where id = '$userid'";
      
      }

      mysqli_query($konek, $query);
      if($query)
      {
          echo "TERKIRIM";
      }


?>