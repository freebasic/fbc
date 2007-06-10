<?php


function file_get_contents($filename) {
	$fd = fopen("$filename", 'rb');
	$content = fread($fd, filesize($filename));
	fclose($fd);
	return $content;
}
?>