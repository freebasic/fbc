<?php


function math_filter($value, $exp, $file, $line) {
	$rpn =& new Math_Rpn();
	$rpn->Filter = 'math';
	$rpn->SourceFile = $file;
	$rpn->StartingLineNo = $line;
			if ('-' == substr($exp,0,1)) {
		$exp = '+-1*'.substr($exp,1);
	}
	$calc = '('.$value.')'.$exp;
	return $rpn->calculate($calc, 'deg', false);
}


class Math_Rpn
{
	
	var $Filter;
	var $SourceFile;
	var $StartingLineNo;
	
	
    var $_input = '';

    
    var $_input_array = array();

    
    var $_output = array();

    
    var $_stack = array();

    
    var $_value = 0.0;

    
    var $_angle = true;

    
    var $_error = null;

    
    var $_timer = 0.0;

    
    var $_operation = array (
        '('    => array ('left bracket', 0),
        ')'    => array ('right bracket', 1),
        '+'    => array ('sum', 1, 2, '_sum'),
        '-'    => array ('difference', 1, 2, '_difference'),
        '*'    => array ('multiplication', 2, 2, '_multiplication'),
        '/'    => array ('division', 2, 2, '_division'),
        'r'    => array ('root', 3, 2, '_root'),
        '^'    => array ('power', 3, 2, '_power'),
        'sin'  => array ('sine', 3, 1, '_sin'),
        'cos'  => array ('cosine', 3, 1, '_cos'),
        'tan'  => array ('tangent', 3, 1, '_tan'),
        'asin' => array ('asine', 3, 1, '_asin'),
        'acos' => array ('acosine', 3, 1, '_acos'),
        'atan' => array ('atangent', 3, 1, '_atan'),
        'sqrt' => array ('square root', 3, 1, '_sqrt'),
        'exp'    => array ('power of e', 3, 1, '_exp'),
        'log'  => array ('logarithm', 3, 1, '_log'),
        'ln'   => array ('natural logarithm', 3, 1, '_ln'),
        'E'  => array ('power of 10', 3, 1, '_E'),
        'abs'  => array ('absolute value', 3, 1, '_abs'),
        '!'    => array ('factorial', 3, 1, '_factorial'),
        'pi'   => array ('value of pi', 3, 0, '_const_pi'),
        'e'    => array ('value of e', 3, 0, '_const_e'),
        'mod'    => array ('modulo', 3, 2, '_mod'),
        'div'    => array ('integer division', 3, 2, '_div'),
    );

    
    function _raiseError ($error) {
		RaiseError('compiler', 'INTERNAL_FILTER_ERROR', array(
			'error' => $error,
			'filter' => $this->Filter,
			'file' => $this->SourceFile,
			'line' => $this->StartingLineNo));
    }

    
    function getOperators () {
        $return = array();
        while(list($key, $val) = each($this->_operation)) {

            if ($val[2] == 2) {
                $syntax = 'A ' . $key . ' B';
            } elseif ($val[2] == 1) {
                $syntax = $key . ' A';
            } else {
                $syntax = $key;
            }

            $return[] = array (
                'operator' => $key,
                'name' => $val[0],
                'priority' => $val[1],
                'arguments' => $val[2],
                'function' => $val[3],
                'syntax' => $syntax
            );
        }

        return $return;
    }

    
    function addOperator ($operator, $function_name, $priority = 3, $no_of_arg = 0, $text = '') {
        if(preg_match("/^([\W\w]+)\:\:([\W\w]+)$/",$function_name,$match)) {
            $class = $match[1];
            $method = $match[2];
            $function = array (
               'type' => 'userMethod',
               'class' => $class,
               'method' => $method
            );
        } else {
            $function = array (
               'type' => 'userFunction',
               'function' => $function_name
            );
        }

        $this->_operation[$operator] = array ($text, $priority, $no_of_arg, $function);
    }

    
    function calculate($input = '', $angle = 'rad', $is_rpn = false) {
        if($angle = 'deg') $this->_angle = false;
        else $this->_angle = true;

        if($input == '') {
            $this->_error = $this->_raiseError('Empty input expression');
            return $this->_error;
        }

        if(!$is_rpn) {
            $this->_input = $input;

            $this->_stringToArray ();
            if($this->_error <> null) return $this->_error;

            $this->_arrayToRpn();
            if($this->_error <> null) return $this->_error;
        } else {
            if(!is_array($input)) {
                $this->_error = $this->_raiseError('Wrong input expression');
                return $this->_error;
            }
            $this->_input = implode(' ',$input);
            $this->_input_array = $input;
            $this->_output = $input;
        }

        $this->_rpnToValue();
        if($this->_error <> null) return $this->_error;

        return $this->_value;
    }

    
    function getInputArray() {
        return $this->_input_array;
    }

    
    function getRpnArray() {
        return $this->_output;
    }

    
    function getTimer() {
        return $this->_timer;
    }

    

    function _keyExists($key,$array,$type) {
        $keys = array_keys($array);

        if($type == 1) {
            $count = 0;
            while (list($keys_key, $keys_val) = each($keys)) {
                if(is_integer(strpos($keys_val, $key)) && (strpos($keys_val, $key)==0)) $count++;
            }
            if(($count==1) && in_array($key,$keys)) return true;
            else return false;
        } else {
            if(in_array($key,$keys)) return true;
            else return false;
        }
    }

    
    function _isNan($value) {
        if(function_exists('is_nan')) {
            return is_nan($value);
        } else {
            if((substr($value,-3) == 'IND') || (substr($value,-3) == 'NAN')) return true;
            else return false;
        }
    }

    
    function _isInfinite($value) {
        if(function_exists('is_finite')) {
            return !is_finite($value);
        } else {
            if(substr($value,-3) == 'INF') return true;
            else return false;
        }
    }

    
    function _stringToArray () {
        $temp_operator = null;
        $temp_value = null;

        for($i = 0; $i < strlen($this->_input); $i++) {
            if ($this->_input[$i] == ' ') {
                if ($temp_operator != null) {
                    array_push($this->_input_array, $temp_operator);
                    $temp_operator = null;
                }
                if ($temp_value != null) {
                    array_push($this->_input_array, $temp_value);
                    $temp_value = null;
                }
            } elseif (
            	($temp_value == null) 
            	&& (@$this->_operation[$temp_operator][2]>0 
            		|| !@isset($this->_operation[$temp_operator][2])) 
            	&& ($this->_input[$i] == '-')
            ) {
                if ($temp_operator != null) {
                    array_push($this->_input_array, $temp_operator);
                    $temp_operator = null;
                }

                array_push($this->_input_array, '-1');
                array_push($this->_input_array, '*');
            } elseif ((is_numeric($this->_input[$i])) || ($this->_input[$i] == '.')) {
                if ($temp_operator != null) {
                    array_push($this->_input_array, $temp_operator);
                    $temp_operator = null;
                }

                $temp_value .= $this->_input[$i];
            } else {
                if ($this->_keyExists($temp_operator, $this->_operation, 1)) {
                    array_push($this->_input_array, $temp_operator);
                    $temp_operator = null;
                }

                if ($temp_value != null) {
                    array_push($this->_input_array, $temp_value);
                    $temp_value = null;
                }

                $temp_operator .= $this->_input[$i];
            }
        }

        if ($temp_operator != null) {
            array_push($this->_input_array, $temp_operator);
        } else {
            array_push($this->_input_array, $temp_value);
        }

        $this->_testInput();

        return $this->_input_array;
    }

    
    function _testInput() {
        if (!count($this->_input_array)) {
            $this->_input_array = null;
            $this->_error = $this->_raiseError('Undefined input array');
            return $this->_error;
        }

        $bracket = 0;
        for($i = 0; $i <= count($this->_input_array); $i++) if (@$this->_input_array[$i] == '(') $bracket++;
        for($i = 0; $i <= count($this->_input_array); $i++) if (@$this->_input_array[$i] == ')') $bracket--;

        if ($bracket <> 0) {
                $this->_input_array = null;
                $this->_error = $this->_raiseError('Syntax error');
                return $this->_error;
        }

        for($i = 0; $i < count($this->_input_array); $i++) {
            if ((!is_numeric($this->_input_array[$i])) && (!$this->_keyExists($this->_input_array[$i], $this->_operation, 0))) {
                $error_operator = $this->_input_array[$i];
                $this->_input_array = null;
                $this->_error = $this->_raiseError('Undefined operator \''. $error_operator.'\'');
                return $this->_error;
            }
        }

        $this->_error = null;
        return $this->_error;
    }

    
    function _stackAdd($value) {
        array_push($this->_stack, $value);
    }

    
    function _stackDelete() {
        return array_pop($this->_stack);
    }

    
    function _priority($value) {
        return $this->_operation[$value][1];
    }
    
    function _stackPriority() {
        $value = $this->_stackDelete();
        $this->_stackAdd($value);
        return $this->_priority($value);
    }

    
    function _stackEmpty() {
        if (count($this->_stack)) {
            return false;
        }
        else return true;
    }

    
    function _outputAdd($value) {
        if ($value<>'(') {
            array_push($this->_output, $value);
        }
    }

    
    function _arrayToRpn() {

        if ($this->_error <> null) {
            $this->_output = array();
            return $this->_output;
        }

        for($i = 0; $i < count($this->_input_array); $i++) {

            $temp = $this->_input_array[$i];

            if (is_numeric($temp)) {
                $this->_outputAdd($temp);
            } else {
                if ($temp == ')') {
                    while(!$this->_stackEmpty() && ($this->_stackPriority() >= 1)) {
                        $this->_outputAdd($this->_stackDelete());
                    }
                    if (!$this->_stackEmpty()) {
                        $this->_stackDelete();
                    }

                } elseif ($temp=='(') {
                    $this->_stackAdd($temp);
                } elseif (($this->_stackEmpty()) || (($this->_priority($temp) > $this->_stackPriority()))) {
                   $this-> _stackAdd($temp);
                } else {
                    while(!$this->_stackEmpty() && ($this->_priority($temp) <= $this->_stackPriority())) {
                        $this->_outputAdd($this->_stackDelete());
                    }
                    $this->_stackAdd($temp);
                }

            }

        }

        while(!$this->_stackEmpty()) {
            $this->_outputAdd($this->_stackDelete());
        }

        return $this->_output;
    }

    
    function _nextOperator($array) {
        $pos = 0;
        while(is_numeric($array[$pos])) {
            $pos++;
            if ($pos >= count($array)) {
                return -1;
            }
        }
        return $pos;

    }

    
    function _refresh($temp, $pos, $arg, $result) {
        $temp1 = array_slice($temp, 0, $pos-$arg);
        $temp1[] = $result;
        $temp2 = array_slice($temp, $pos+1);
        return array_merge($temp1, $temp2);
    }

    
    function _sum($temp, $pos) {
        return $temp[$pos-2]+$temp[$pos-1];
    }

    
    function _difference($temp, $pos) {
        return $temp[$pos-2]-$temp[$pos-1];
    }

    
    function _multiplication($temp, $pos) {
        return $temp[$pos-2]*$temp[$pos-1];
    }

    
    function _division($temp, $pos) {
        if ($temp[$pos-1]==0) {
            $this->_error = $this->_raiseError('Division by 0');
            $this->_value = null;
            return $this->value;
        }
        return $temp[$pos-2]/$temp[$pos-1];
    }

    
    function _root($temp, $pos) {
        return pow($temp[$pos-1], (1/$temp[$pos-2]));
    }

    
    function _power($temp, $pos) {
        return pow($temp[$pos-2], $temp[$pos-1]);
    }

    
    function _sin($temp, $pos) {
        if ($this->_angle) {
            $angle = $temp[$pos-1];
        } else {
            $angle = deg2rad($temp[$pos-1]);
        }
        return sin($angle);
    }

    
    function _cos($temp, $pos) {
        if ($this->_angle) {
            $angle = $temp[$pos-1];
        } else {
            $angle = deg2rad($temp[$pos-1]);
        }
        return cos($angle);
    }

    
    function _tan($temp, $pos) {
        if ($this->_angle) {
            $angle = $temp[$pos-1];
        } else {
            $angle = deg2rad($temp[$pos-1]);
        }
        return tan($angle);
    }

    
    function _asin($temp, $pos) {
        $angle = asin($temp[$pos-1]);
        if (!$this->_angle) {
            $angle = rad2deg($angle);
        }
        return $angle;
    }

    
    function _acos($temp, $pos) {
        $angle = acos($temp[$pos-1]);
        if (!$this->_angle) {
            $angle = rad2deg($angle);
        }
        return $angle;
    }

    
    function _atan($temp, $pos) {
        $angle = atan($temp[$pos-1]);
        if (!$this->_angle) {
            $angle = rad2deg($angle);
        }
        return $angle;
    }

    
    function _sqrt($temp, $pos) {
        return sqrt($temp[$pos-1]);
    }

    
    function _exp($temp, $pos) {
        return exp($temp[$pos-1]);
    }

    
    function _log($temp, $pos) {
        return log10($temp[$pos-1]);
    }

    
    function _ln($temp, $pos) {
        return log($temp[$pos-1]);
    }

    
    function _const_pi($temp, $pos) {
        return M_PI;
    }

    
    function _const_e($temp, $pos) {
        return M_E;
    }

    
    function _E($temp, $pos) {
        return pow(10, $temp[$pos-1]);
    }

    
    function _factorial($temp, $pos) {
        $factorial = 1;
        for($i=1;$i<=$temp[$pos-1];$i++) {
            $factorial *= $i;
        }
        return $factorial;
    }

    
    function _abs($temp, $pos) {
        return abs($temp[$pos-1]);
    }

    
    function _mod($temp, $pos) {
        return $temp[$pos-2]%$temp[$pos-1];
    }

    
    function _div($temp, $pos) {
        return floor($temp[$pos-2]/$temp[$pos-1]);
    }

    
    function _rpnToValue() {

        $time1 = $this->_getMicroTime();

        if ($this->_error <> null) {
            $this->_value = null;
            return $this->_value;
        }

        $this->_value = 0;
        $temp = $this->_output;

        do {
            $pos = $this->_nextOperator($temp);

            if ($pos == -1) {
                $this->_error = $this->_raiseError('Syntax error');
                $this->_value = null;
                return $this->_value;
            }

            $operator = $this->_operation[$temp[$pos]];
            $arg = $operator[2];
            $function = $operator[3];

            if (($arg==2) && ((!is_numeric($temp[$pos-1])) || (!is_numeric($temp[$pos-2])))) {
                $this->_error = $this->_raiseError('Syntax error');
                $this->_value = null;
                return $this->_value;
            } elseif (($arg==1) && (!is_numeric($temp[$pos-1]))) {
                $this->_error = $this->_raiseError('Syntax error');
                $this->_value = null;
                return $this->_value;
            }

            if(is_array($function)) {

                if($arg==2) $arg_array = array($temp[$pos-2],$temp[$pos-1]);
                elseif($arg==1) $arg_array = array($temp[$pos-1]);
                else $arg_array = array();

                if($function['type'] == 'userFunction') {
                    $this->_value = call_user_func_array($function['function'], $arg_array);
                } else {
                    $function_array = array(&$function['class'], $function['method']);
                    $this->_value = call_user_func_array($function_array, $arg_array);
                }
            } else {
            	if (method_exists($this, $function)) {
            	    $this->_value = $this->$function($temp, $pos);
            	} else {
            		$this->_raiseError("invalid function '$function' temp '$temp' pos '$pos'");
            	}
            }

            if ($this->_isNan($this->_value)) {
                $this->_error = $this->_raiseError('NAN value');
                $this->_value = null;
                return $this->_value;
            } elseif ($this->_isInfinite($this->_value)) {
                $this->_error = $this->_raiseError('Infinite value');
                $this->_value = null;
                return $this->_value;
            } elseif (is_null($this->_value)) {
                return $this->_value;
            }

            $temp = $this->_refresh($temp, $pos, $arg, $this->_value);
        } while(count($temp) > 1);

        $this->_value = $temp[0];

        $time2 = $this->_getMicroTime();

        $this->_timer = $time2 - $time1;

        return $this->_value;
    }

    
    function _getMicroTime() {
        list($usec, $sec) = explode(" ", microtime());
        return ((float)$usec + (float)$sec);
    }

}

?>