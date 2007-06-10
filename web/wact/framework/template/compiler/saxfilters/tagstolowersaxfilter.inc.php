<?php


if (!function_exists('array_change_key_case')) {
	require_once WACT_ROOT . 'util/phpcompat/array_change_key_case.php';
}

require_once WACT_ROOT . 'template/compiler/saxfilters/basesaxfilter.inc.php';


class TagsToLowerSaxFilter extends BaseSaxFilter {

	
	function startElement($tag, $attrs) {
		parent::startElement(strtolower($tag), array_change_key_case($attrs,CASE_LOWER));
	}


	
	function endElement($tag) {
		parent::endElement(strtolower($tag));
	}

	
	function emptyElement($tag, $attrs) {
		$this->ChildSaxFilter->emptyElement(strtolower($tag), $attrs);
	}

}
?>