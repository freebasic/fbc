<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class SuffixRule extends SingleFieldRule {
	
	var $Suffix;

	
	function SuffixRule($fieldname, $Suffix) {
		parent :: SingleFieldRule($fieldname);
		$this->Suffix = $Suffix;
	}

	
    function Check($value) {
        if (substr($value, -strlen($this->Suffix)) != $this->Suffix) {
            $this->Error('SUFFIX_MISSING', array('suffix' => $this->Suffix));
        }
    }
}




class ExcludeSuffixRule extends SingleFieldRule {
	
	var $Suffix;

	
	function ExcludeSuffixRule($fieldname, $Suffix) {
		parent :: SingleFieldRule($fieldname);
		$this->Suffix = $Suffix;
	}

	
    function Check($value) {
        if (substr($value, -strlen($this->Suffix)) == $this->Suffix) {
            $this->Error('SUFFIX_NOT_ALLOWED', array('suffix' => $this->Suffix));
        }
    }
}

?>