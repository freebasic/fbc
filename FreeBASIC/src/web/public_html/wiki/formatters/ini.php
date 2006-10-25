<?php
/**
 * INI language file for Wikka highlighting (configuration file).
 */

$text = htmlspecialchars($text, ENT_QUOTES);

$text = preg_replace("/([=,\|]+)/m","<span style=\"color:#4400DD\">\\1</span>",$text);
$text = preg_replace("/^([;#].+)$/m","<span style=\"color:#226622\">\\1</span>",$text);
$text = preg_replace("/([^\d\w#;:>])([;#].+)$/m","<span style=\"color:#226622\">\\2</span>",$text);
$text = preg_replace("/^(\[.*\])/m","<strong style=\"color:#AA0000;background:#EEE0CC\">\\1</strong>",$text);
print "<pre>".$text."</pre>";

?>
