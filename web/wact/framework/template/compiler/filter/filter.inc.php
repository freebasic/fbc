<?php


class CompilerFilter {

    var $base;
    var $parameters = array();

    function registerBase(&$base) {
        $this->base =& $base;
    }
    
    function registerParameter(&$parameter) {
        $this->parameters[] =& $parameter;
    }

	
	function isConstant() {
	    $isConstant = $this->base->isConstant();
		foreach( array_keys($this->parameters) as $key) {
			$isConstant = $isConstant && $this->parameters[$key]->isConstant();
		}
	    return $isConstant;
    }
    
	
	function getValue() {
    }

	
	function generatePreStatement(&$code) {
	    $this->base->generatePreStatement($code);
		foreach( array_keys($this->parameters) as $key) {
			$this->parameters[$key]->generatePreStatement($code);;
		}
    }

	
	function generateExpression(&$code) {
    }
    
	
	function generatePostStatement(&$code) {
	    $this->base->generatePostStatement($code);
		foreach( array_keys($this->parameters) as $key) {
			$this->parameters[$key]->generatePostStatement($code);;
		}
    }

	function prepare() {
	    $this->base->prepare();
		foreach( array_keys($this->parameters) as $key) {
			$this->parameters[$key]->prepare();;
		}
    }

}

?>