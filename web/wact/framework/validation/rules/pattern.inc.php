<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class PatternRule extends SingleFieldRule {
	
	var $Pattern;
	
	var $Id;

	
	function PatternRule($fieldname, $Pattern, $Group = 'validation', $Id = 'INVALID') {
		parent :: SingleFieldRule($fieldname);
		$this->Pattern = $Pattern;
		$this->Id = $Id;
		$this->Group = $Group;
	}

	
    function Check($value) {
        if (!preg_match($this->Pattern, $value)) {
            $this->Error($this->Id);
        }
    }
}




class ExcludePatternRule extends SingleFieldRule {
	
	var $Pattern;
	
	var $Id;

	
	function ExcludePatternRule($fieldname, $Pattern, $Group = 'validation', $Id = 'INVALID') {
		parent :: SingleFieldRule($fieldname);
		$this->Pattern = $Pattern;
		$this->Id = $Id;
		$this->Group = $Group;
	}

	
    function Check($value) {
        if (preg_match($this->Pattern, $value)) {
            $this->Error($this->Id);
        }
    }
}

?>