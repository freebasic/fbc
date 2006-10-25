<?php


class SilentCompilerDirectiveTag extends CompilerComponent {
	
	function generate(&$code) {
					}

	
	function generateNow(&$code) {
		return parent::generate($code);
	}
}
?>