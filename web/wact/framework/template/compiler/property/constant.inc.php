<?php



class ConstantProperty extends CompilerProperty {
    
    var $value;
    
    function ConstantProperty($value) {
        $this->value =& $value;
    }

	
	function isConstant() {
	    return TRUE;
    }

	
	function getValue() {
	    return $this->value;
    }

	
	function generateExpression(&$code) {
        $code->writePHPLiteral($this->value);
    }
    
    function prepare() {
    }
}

?>