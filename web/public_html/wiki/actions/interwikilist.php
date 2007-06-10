<?php
$file = implode("", file("interwiki.conf", 1));
print($this->Format("%%".$file."%%"));
?>