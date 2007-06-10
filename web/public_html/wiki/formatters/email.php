<?php
/**
 * Email quoting file for Wikka highlighting.
 */

 $text = $this->htmlspecialchars_ent($text);
 $text = str_replace("&gt;", ">", $text);

 $text = preg_replace("/^([^\s\n>]*?(>{1}))([^>].*)$/m","<span style=\"color:#AA0000\">\\1\\3</span>",$text);
 $text = preg_replace("/^([^\s\n>]*?(>{2}))([^>].*)$/m","<span style=\"color:#0000AA\">\\1\\3</span>",$text);
 $text = preg_replace("/^([^\s\n>]*?(>{3}))([^>].*)$/m","<span style=\"color:#00AA00\">\\1\\3</span>",$text);
 $text = preg_replace("/^([^\s\n>]*?(>{4}))([^>].*)$/m","<span style=\"color:#AA0055\">\\1\\3</span>",$text);
 $text = preg_replace("/^([^\s\n>]*?(>{2})+>)([^>].*)$/m","<span style=\"color:#AAAAAA\">\\1\\3</span>",$text);
 $text = preg_replace("/^([^\s\n>]*?(>{2})+)([^>].*)$/m", "<span style=\"color:#DDAA00\">\\1\\3</span>",$text);
 print "<pre>".$text."</pre>";

?>
