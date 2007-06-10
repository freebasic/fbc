<?php


require_once WACT_ROOT . 'template/compiler/compilerdirective.inc.php';

class PHPNode extends CompilerDirectiveTag {
	
	var $contents;

	
	function PHPNode($text) {
		$this->contents = $text;
	}

	
	function generate(&$code) {
		$code->writePHP($this->contents);
	}
}
?>