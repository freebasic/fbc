<?php


class HtmlAnchorComponent extends Component {
	
	var $clickHandler;
	
	var $clickField;

	
	function setClickHandler($handler) {
		$this->clickHandler = $handler;
	}
	
	function setClickField($field) {
		$this->clickField = $field;
	}
	
	function prepare() {
		if ( isset($this->clickHandler) && isset($this->clickField) ) {
			if ( isset ( $_GET[$this->clickField] ) ) {
				$call = $this->clickHandler;
				$args = array(&$this,array('clicked'=>$this->clickField));
				call_user_func_array($call,$args);
			}
		}
	}
}
?>