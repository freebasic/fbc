<?php


function scandir($directory, $sorting_order=0) {
	$dh  = opendir($directory);
    if ($dh === false) {
        return false;
    }
    $files = array();
    while (false !== ($filename = readdir($dh))) {
        $files[] = $filename;
    }
    closedir($dh);
    if ($sorting_order) {
        rsort($files);
    } else {
        sort($files);
    }
    return $files;
}
?>