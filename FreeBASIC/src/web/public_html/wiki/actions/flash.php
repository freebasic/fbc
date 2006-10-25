<?php

/*

Syntax:
   {{Flash url="http://example.com/example.swf" [width=x] [height=x]}}

Width and Height are optional arguments.

*/

if (!$width) $width = 550;
else $width = (int)$width;
if ($width>950) $width = 950;

if (!$height) $height = 400;
else $height = (int)$height;
if ($height>950) $height = 950;

if (!$url) $url = $vars[0];
$url = $this->cleanUrl(trim($url));

if ($url)
  echo '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="'.$width.'" height="'.$height.'">
	<param name="movie" value="'.$url.'" />
	<param name="quality" value="high" />
	<embed src="'.$url.'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="'.$width.'" height="'.$height.'"></embed>
</object>';
?>