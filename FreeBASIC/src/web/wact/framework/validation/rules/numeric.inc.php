<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class NumericPrecisionRule extends SingleFieldRule {
	
	var $DecimalDigits;
	
	var $WholeDigits;

	
	function NumericPrecisionRule($fieldname, $WholeDigits, $DecimalDigits = NULL) {
		parent :: SingleFieldRule($fieldname);

		if (is_null($DecimalDigits)) {
		    $this->DecimalDigits = 0;
		} else {
		    $this->DecimalDigits = $DecimalDigits;
		}
		$this->WholeDigits = $WholeDigits;
	}

	
    function Check($value) {
        if (preg_match('/^[+-]?(\d*)\.?(\d*)$/', $value, $match)) {
            if (strlen($match[1]) > $this->WholeDigits) {
                $this->Error('TOO_MANY_WHOLE_DIGITS',
                    array('maxdigits' => $this->WholeDigits,
                        'digits' => strlen($match[1])));
            }
            if (strlen($match[2]) > $this->DecimalDigits) {
                $this->Error('TOO_MANY_DECIMAL_DIGITS',
                    array('maxdigits' => $this->DecimalDigits,
                        'digits' => strlen($match[2])));
            }
        } else {
            $this->Error('NOT_NUMERIC');
        }
	}
}


class NumericRangeRule extends SingleFieldRule {
    
    var $min;
    
    var $max;

    
    function NumericRangeRule($fieldname, $min, $max = NULL) {
        parent :: SingleFieldRule($fieldname);
        if (is_null($max)) {
            $this->minLength = NULL;
            $this->max = $min;
        } else {
            $this->min = $min;
            $this->max = $max;
        }
    }

	
    function Check($value) {
        if (!function_exists('floatval')) {
            require_once WACT_ROOT . 'util/phpcompat/floatval.php';
        }
        if (!is_null($this->min) && (floatval($value) < $this->min)) {
            $this->Error('RANGE_TOO_SMALL', array('min' => $this->min));
        } else if (floatval($value) > $this->max) {
            $this->Error('RANGE_TOO_BIG', array('max' => $this->max));
        }
    }
}

?>