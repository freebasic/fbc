<?php


function str_split($string, $length=1) {
	if ($length < 1) {
	    return false;
	}
	preg_match_all('/('.str_repeat('.', $length).')/Uims', $string, $matches);
    return $matches[1];
}
?>