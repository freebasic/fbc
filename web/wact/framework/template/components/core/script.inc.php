<?php


class CoreScriptComponent extends Component {
	
	var $javascript;

	
	function writeJavaScript($javascript) {
		$this->javascript.=$javascript;
	}

	
	function readJavaScript() {
		return $this->javascript;
	}

}
?>