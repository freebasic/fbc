<?php






class TextWidget extends Component {
	
	var $text;

	
	function TextWidget($text) {
		$this->text = $text;
		$this->IsDynamicallyRendered = TRUE;
	}

	
	function addChild() {
	    	}

	
	function render() {
		echo ( htmlspecialchars($this->text, ENT_NOQUOTES) );
	}
}


class TagWidget extends TagComponent {
	
	var $tag;
	
	
	var $closing = true;
	
	
	function TagWidget($tag,$closing=true) {
		$this->tag = htmlspecialchars($tag,ENT_QUOTES);
		$this->closing = $closing;
		$this->IsDynamicallyRendered = TRUE;
	}
	
	
	function addChild() {
	    	}

	
	function render() {
		echo ( '<'.$this->tag );
		echo ( $this->renderAttributes());
		if ( $this->closing )
			echo ( '/>' );
		else
			echo ( '>' );
	}
}


class TagContainerWidget extends TagComponent {
	
	var $tag;
	
	
	function TagContainerWidget($tag) {
		$this->tag = htmlspecialchars($tag, ENT_QUOTES);
		$this->IsDynamicallyRendered = TRUE;
	}
	
	
	function render() {
		echo ( '<'.$this->tag );
		echo ( $this->renderAttributes().'>');
		parent :: render();
		echo ( '</'.$this->tag.'>' );
	}
}
?>