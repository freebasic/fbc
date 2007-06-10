<?php


class BlockComponent extends Component {
	
	var $visible = TRUE;
	
	function IsVisible() {
		return $this->visible;
	}

	
	function show() {
		$this->visible = TRUE;
	}

	
	function hide() {
		$this->visible = FALSE;
	}
}
?>