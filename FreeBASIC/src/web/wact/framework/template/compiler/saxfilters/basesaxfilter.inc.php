<?php


class BaseSaxFilter {

	
	var $ChildSaxFilter;

	
	function setChildSaxFilter(&$SaxFilter) {
		$this->ChildSaxFilter =& $SaxFilter;
	}

	
	function setDocumentLocator(&$locator) {
		$this->ChildSaxFilter->setDocumentLocator($locator);
	}

	
	function startElement($tag, $attrs) {
		$this->ChildSaxFilter->startElement($tag, $attrs);
	}

	
	function endElement($tag) {
		$this->ChildSaxFilter->endElement($tag);
	}

	
	function emptyElement($tag, $attrs) {
		$this->ChildSaxFilter->emptyElement($tag, $attrs);
	}

	
	function characters($text) {
		$this->ChildSaxFilter->characters($text);
	}

	
	function cdata($text) {
		$this->ChildSaxFilter->cdata($text);
	}

	
	function processingInstruction($target, $instruction) {
		$this->ChildSaxFilter->processingInstruction($target, $instruction);
	}

	
	function escape($text) {
		$this->ChildSaxFilter->escape($text);
	}

	
	function comment($text) {
		$this->ChildSaxFilter->comment($text);
	}

	
	function doctype($text) {
		$this->ChildSaxFilter->doctype($text);
	}

	
	function jasp($text) {
		$this->ChildSaxFilter->jasp($text);
	}
	
	
	function unexpectedEOF($text) {
		$this->ChildSaxFilter->unexpectedEOF($text);
	}

	
	function invalidEntitySyntax($text) {
		$this->ChildSaxFilter->invalidEntitySyntax($text);
	}

	
	function invalidAttributeSyntax() {
		$this->ChildSaxFilter->invalidAttributeSyntax();
	}
	
}

?>