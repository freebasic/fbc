<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class PrefixRule extends SingleFieldRule {
	
	var $Prefix;

	
	function PrefixRule($fieldname, $Prefix) {
		parent :: SingleFieldRule($fieldname);
		$this->Prefix = $Prefix;
	}

	
    function Check($value) {
        if (substr($value, 0, strlen($this->Prefix)) != $this->Prefix) {
            $this->Error('PREFIX_MISSING', array('prefix' => $this->Prefix));
        }
    }
}




class ExcludePrefixRule extends SingleFieldRule {
	
	var $Prefix;

	
	function ExcludePrefixRule($fieldname, $Prefix) {
		parent :: SingleFieldRule($fieldname);
		$this->Prefix = $Prefix;
	}

	
    function Check($value) {
        if (substr($value, 0, strlen($this->Prefix)) == $this->Prefix) {
            $this->Error('PREFIX_NOT_ALLOWED', array('prefix' => $this->Prefix));
        }
    }
}

?>