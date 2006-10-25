<?php
/**
 * Print number of registered users.
 */ 
$userdata = $this->LoadSingle("SELECT count(*) as num FROM ".$this->config["table_prefix"]."users ");
echo $userdata["num"];
?>