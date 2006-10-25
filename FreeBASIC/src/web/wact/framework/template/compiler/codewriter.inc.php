<?php


define('CODE_WRITER_MODE_PHP', 1);

define('CODE_WRITER_MODE_HTML', 2);

class CodeWriter {

	var $code = '';

	var $mode = CODE_WRITER_MODE_HTML;

	var $FunctionPrefix = '';

	var $FunctionSuffix = 1;

	var $includeList = array();

	var $tempVarName = 1;

	function CodeWriter() {
		$this->code = '';
	}


	function switchToPHP() {
		if ($this->mode == CODE_WRITER_MODE_HTML) {
			$this->mode = CODE_WRITER_MODE_PHP;
			$this->code .= '<?php ';
		}
	}


	function switchToHTML($Context = NULL) {
		if ($this->mode == CODE_WRITER_MODE_PHP) {
			$this->mode = CODE_WRITER_MODE_HTML;
			if ($Context === "\n") {
    			$this->code .= " ?>\n";
    	    } else {
    			$this->code .= ' ?>';
    	    }
		}
	}


	function writePHP($text) {
		$this->switchToPHP();
		$this->code .= $text;
	}


	function writePHPLiteral($text, $escape=true) {
		$this->switchToPHP();
		if ($escape) {
			$this->code .= "'" . $this->escapeLiteral($text) . "'";
		} else {
			$this->code .= "'" . $text . "'";
		}
	}


	function escapeLiteral($text) {
		$text = str_replace('\'', "\\'", $text);
		if ( substr($text, -1) == '\\') {
		    $text .= '\\';
		}
		return $text;
	}



	function writeHTML($text) {
		$this->switchToHTML(substr($text,0,1));
		$this->code .= $text;
	}


	function getCode() {
		$this->switchToHTML();
		$includecode = '';
		foreach($this->includeList as $includefile) {
			$includecode .= "require_once '$includefile';\n";
		}
	        if (!empty($includecode)) {
        	    $pattern = '/' . preg_quote('<?php ', '/') . '/';
	            if (preg_match($pattern, $this->code)) {
        	        return preg_replace($pattern, '<?php ' . $includecode, $this->code, 1);
	            } else {
        	        return '<?php ' . $includecode . '?>';
	            }
        	} else {
    			return $this->code;
	        }
	}


	function registerInclude($includefile) {
		$includefile = str_replace('//','/',$includefile);
		if (!in_array($includefile, $this->includeList)) {
			$this->includeList[] = $includefile;
		}
	}


	function beginFunction($ParamList) {
		$funcname = 'tpl' . $this->FunctionPrefix . $this->FunctionSuffix++;
		$this->writePHP('function ' . $funcname . $ParamList ." {\n");
		return $funcname;
	}


	function endFunction() {
		$this->writePHP(" }\n");
	}


	function setFunctionPrefix($prefix) {
		$this->FunctionPrefix = $prefix;
	}


	function getTempVariable() {
		$var = $this->tempVarName++;
		if ($var > 675) {
			return chr(65 + ($var/26)/26) . chr(65 + ($var/26)%26) . chr(65 + $var%26);
		} elseif ($var > 26) {
			return chr(65 + ($var/26)%26) . chr(65 + $var%26);
		} else {
			return chr(64 + $var);
		}
	}


	function getTempVarRef() {
		return '$'.$this->getTempVariable();
	}
}
?>
