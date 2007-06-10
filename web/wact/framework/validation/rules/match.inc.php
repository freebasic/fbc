<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class MatchRule extends Rule {
	
	var $refField;
	
    var $fieldname;

	
	function MatchRule($fieldname, $referenceField) {
        $this->fieldname = $fieldname;
		$this->refField = $referenceField;
	}

	
	function validate(&$DataSource, &$ErrorList) {
		$value1 = $DataSource->get($this->fieldname);
		$value2 = $DataSource->get($this->refField);
		if (isset($value1) && isset($value2)) {
			if (strcmp($value1, $value2)) {
                $ErrorList->addError($this->Group, 'NO_MATCH', 
                    array('Field' => $this->fieldname, 'MatchField' => $this->refField));
				return FALSE;
			}
		}
		return TRUE;
	}
}
?>