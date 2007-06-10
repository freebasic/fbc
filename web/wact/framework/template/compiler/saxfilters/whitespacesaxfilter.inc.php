<?php


require_once WACT_ROOT . 'template/compiler/saxfilters/basesaxfilter.inc.php';

class WhitespaceSaxFilter extends BaseSaxFilter {

	
	var $inHtml = FALSE;

	
	var $inPre = FALSE;
	
	
	function startElement($tag, $attrs) {
		switch ( strtolower($tag) ) {
			case 'textarea':
			case 'script':
			case 'pre':
				$this->inPre = TRUE;
			break;
			case 'html':
				$this->inHtml = TRUE;
			break;
		}
		parent::startElement($tag, $attrs);
	}

	
	function endElement($tag) {
		switch ( strtolower($tag) ) {
			case 'textarea':
			case 'script':
			case 'pre':
				$this->inPre = FALSE;
			break;
			case 'html':
				$this->inHtml = FALSE;
			break;
		}
		parent::endElement($Parser, $tag, $empty);
	}

	
	function characters($text) {
		if ( !$this->inPre && $this->inHtml ) {
			$text = trim($text);
			$text = preg_replace('/\s+/', ' ', $text);
		}
		parent::characters($Parser, $text);
	}
}
?>