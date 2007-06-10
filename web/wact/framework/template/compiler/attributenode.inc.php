<?php



class AttributeNode {
    var $name;
    var $value;

    function AttributeNode($name, $value) {
        $this->name = $name;
        $this->value = $value;
    }


    function isConstant() {
        return TRUE;
    }


    function getValue() {
        static $table;
        if (!isset($table)) {
            $table = array_flip(get_html_translation_table( HTML_SPECIALCHARS, ENT_QUOTES ));
        }

        if ( !is_null($this->value) ) {

            return strtr($this->value, $table);
        }
    }


    function generateFragment(&$code) {
        $code->writeHTML(htmlspecialchars($this->getValue(), ENT_QUOTES));
    }


    function generate(&$code) {
        $code->writeHTML(' ' . $this->name);
        if (!is_null($this->value)) {
            $code->writeHTML('="');
            $this->generateFragment($code);
            $code->writeHTML('"');
        }
    }


	function generatePreStatement(&$code) {
    }


    function generateExpression(&$code) {
        $code->writePHPLiteral($this->getValue());
    }


	function generatePostStatement(&$code) {
    }


    function prepare() {
    }

}


class AttributeExpression {

    var $name;
    var $expression;

    function AttributeExpression($name, $expression, &$context) {
        $this->name = $name;
        $this->expression =& $this->createExpression($expression, $context);
    }

    function &createExpression($expression, &$context) {
        return new Expression($expression, $context, 'raw');
    }


    function isConstant() {
        return $this->expression->isConstant();
    }


    function getValue() {
        return $this->expression->getValue();
    }


    function generateFragment(&$code) {
        if ($this->isConstant()) {
            $value = $this->getValue();
            if (!is_null($value)) {
                $code->writeHTML(htmlspecialchars($value, ENT_QUOTES));
            }
        } else {
            $this->expression->generatePreStatement($code);
            $code->writePHP('echo htmlspecialchars(');
            $this->expression->generateExpression($code);
            $code->writePHP(', ENT_QUOTES);');
            $this->expression->generatePostStatement($code);
        }
    }


    function generate(&$code) {
        $code->writeHTML(' ' . $this->name);
        $code->writeHTML('="');
        $this->generateFragment($code);
        $code->writeHTML('"');
    }


	function generatePreStatement(&$code) {
        $this->expression->generatePreStatement($code);
    }


    function generateExpression(&$code) {
        $this->expression->generateExpression($code);
    }


	function generatePostStatement(&$code) {
        $this->expression->generatePostStatement($code);
    }


    function prepare() {
        return $this->expression->prepare();
    }

}

class CompoundAttribute {
    var $name;
    var $fragments = array();


    function CompoundAttribute($name) {
        $this->name = $name;
    }


    function addAttributeFragment(&$fragment) {
        $this->fragments[] =& $fragment;
    }


    function isConstant() {
        $isConstant = TRUE;
		foreach( array_keys($this->fragments) as $key) {
			$isConstant = $isConstant && $this->fragments[$key]->isConstant();
		}
		return $isConstant;
    }


    function getValue() {
        $value = "";
		foreach( array_keys($this->fragments) as $key) {
			$value .= $this->fragments[$key]->getValue();
		}
		return $value;
    }


    function generate(&$code) {
        $code->writeHTML(' ' . $this->name);
        $code->writeHTML('="');
 		foreach( array_keys($this->fragments) as $key) {
			$this->fragments[$key]->generateFragment($code);
		}
        $code->writeHTML('"');
    }


	function generatePreStatement(&$code) {
		foreach( array_keys($this->fragments) as $key) {
			$this->fragments[$key]->generatePreStatement($code);
		}
    }


    function generateExpression(&$code) {
        $code->writePHP('(');
        $separator = '';
		foreach( array_keys($this->fragments) as $key) {
			$code->writePHP($separator);
			$this->fragments[$key]->generateExpression($code);
			$separator = ".";
		}
        $code->writePHP(')');
    }


	function generatePostStatement(&$code) {
		foreach( array_keys($this->fragments) as $key) {
			$this->fragments[$key]->generatePostStatement($code);
		}
    }


    function prepare() {
		foreach( array_keys($this->fragments) as $key) {
			$this->fragments[$key]->prepare();
		}
    }

}

?>