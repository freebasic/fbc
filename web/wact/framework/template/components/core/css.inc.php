<?php


class CoreCssComponent extends Component {
	
	var $css;

	
	function writeCSS($css) {
		$this->css.=$css;
	}

	
	function readCSS() {
		return $this->css;
	}

}
?>