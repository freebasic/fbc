<?php


require_once WACT_ROOT . 'template/components/form/form.inc.php';


class InputAutoCompleteComponent extends InputFormElement {
	
	var $autocompletelist = array();

	
	function setAutoCompleteList($list) {
		$this->autocompletelist = $list;
	}

	
	function getAutoCompleteList() {
		$func = create_function('$item','return str_replace(\'"\',\'\"\',$item);');
		$autocompletelist = array_map($func,$this->autocompletelist);
		return $autocompletelist;
	}
}
?>
