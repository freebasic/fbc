<?php


require_once WACT_ROOT . 'template/compiler/compilerdirective.inc.php';

class TextNode extends CompilerDirectiveTag {
	
	var $contents;

	
	function TextNode($text) {
		$this->contents = $text;
	}

	
	function append($text) {
		$this->contents .= $text;
	}

	
	function generate(&$code) {
		$code->writeHTML($this->contents);
	}
}

?>