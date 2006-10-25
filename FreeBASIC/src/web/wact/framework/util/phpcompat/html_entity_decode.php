<?php


function html_entity_decode($str, $style=NULL) {
    static $table;
    if (!isset($table)) {
        $table = array_flip(get_html_translation_table(HTML_ENTITIES));
    }
	return strtr($str, $table);
}
?>