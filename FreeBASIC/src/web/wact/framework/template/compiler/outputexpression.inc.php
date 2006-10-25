<?php


class OutputExpression extends CompilerComponent {
	
	var $expression;

	
	function OutputExpression($expression) {
		$this->expression =& new Expression($expression, $this, 'html');
	}

	function prepare() {
	    $this->expression->prepare();
		parent::prepare();
	}
	
	
	function generate(&$code) {
	    if ($this->expression->isConstant()) {
	        $code->writeHTML($this->expression->getValue());
	    } else {
            $this->expression->generatePreStatement($code);
            $code->writePHP('echo ');
            $this->expression->generateExpression($code);
            $code->writePHP(';');		
            $this->expression->generatePostStatement($code);
        }
	}

}
?>