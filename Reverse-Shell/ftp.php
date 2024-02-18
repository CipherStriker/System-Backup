<?php
                     
$ftp_server = "ftp.nuwave.com";
$ftp_user = "anonymous";
$ftp_pass = "";

// set up a connection or die
$ftp = ftp_connect($ftp_server) or die("Couldn't connect to $ftp_server"); 

// try to login
if (@ftp_login($ftp, $ftp_user, $ftp_pass)) {
    echo "Connected as $ftp_user@$ftp_server\n";
} else {
    echo "Couldn't connect as $ftp_user\n";
}

// close the connection
ftp_close($ftp);  
?>
