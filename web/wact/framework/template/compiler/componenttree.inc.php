<?php


class ComponentTree extends CompilerDirectiveTag {
	
	var $tagIds = array();
	
	function preGenerate(&$code) {
		parent::preGenerate($code);
		$code->writePHP($this->getComponentRefCode() . '->prepare();');
	}

	
	function getComponentRefCode() {
		return '$root';
	}

	
	function getDataSourceRefCode() {
		return '$root';
	}

	
	function &getDataSource() {
		return $this;
	}

	
	function isDataSource() {
	    return TRUE;
	}

}
?>