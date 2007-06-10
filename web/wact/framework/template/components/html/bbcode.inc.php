<?php


if (!@include_once 'HTML/BBCodeParser.php') {
    RaiseError('runtime', 'LIBRARY_REQUIRED', array(
        'library' => 'PEAR::HTMLBBCodeParser v1.1+',
        'path' => 'include path: '.ini_get('include_path').': HTML/'));
}

class HtmlBBCodeComponent extends Component {
	
	var $options;
		
	var $text;
	
	function setText($text) {
		$this->text = $text;
	}
		
	function display() {
		$text = $this->text;
		if ( $this->options['wordwrap'] ) {
			$text = wordwrap($text,$this->options['wordwrap'],"\n");
		}
		if ( $this->options['htmlentities'] ) {
			$text = htmlentities($text, ENT_QUOTES);
		}
		$Parser = new HTML_BBCodeParser($this->options);
		$Parser->setText($text);
		$Parser->parse();
		$text = $Parser->getParsed();
		$text = str_replace('javascript','java_script',$text);
		if ( $this->options['nl2br'] ) {
			return nl2br($text);
		} else {
			return $text;
		}
	}
}
?>