<?php

if (is_array($vars)) {

    foreach ($vars as $param => $value) {
        if ($param == 'text')
        {
        $mytext= $value;
        }
        if ($param == 'c')
        {
        	$colorcode=$value;
        }
        elseif ($param == 'hex')
        {
        	$colorcode=$value;
        }

    }
    echo "<span style=\"color: $colorcode\">".$mytext."</span>";
}
?>