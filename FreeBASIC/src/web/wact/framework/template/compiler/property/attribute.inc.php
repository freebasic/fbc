<?php



class AttributeProperty extends CompilerProperty {

    var $attribute;

    function AttributeProperty(&$attribute) {
        $this->attribute =& $attribute;
    }

	
	function isConstant() {
	    return $this->attribute->isConstant();
    }

	
	function getValue() {
        return $this->attribute->getValue();
    }

	
	function generatePreStatement(&$code) {
        $this->attribute->generatePreStatement($code);
    }

	
	function generateExpression(&$code) {
        $this->attribute->generateExpression($code);
    }

	
	function generatePostStatement(&$code) {
        $this->attribute->generatePostStatement($code);
    }

}

?>