<?php


class CompilerProperty {

	
    var $isActive = FALSE;

	
	function isConstant() {
	    return FALSE;
    }
    
    
    function isActive() {
        return $this->isActive;
    }

        
    function activate() {
        $this->isActive = TRUE;
    }

	
	function getValue() {
    }

	
	function generateScopeEntry(&$code) {
    }
    
	
	function generatePreStatement(&$code) {
    }

	
	function generateExpression(&$code) {
    }
    
	
	function generatePostStatement(&$code) {
    }

	
	function generateScopeExit(&$code) {
    }

}

?>