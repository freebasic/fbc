<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class MemberRule extends SingleFieldRule {
	
	var $memberList;

	
	function MemberRule($fieldname, $list) {
		parent :: SingleFieldRule($fieldname);
		
		$this->memberList = $list;
	}

	
    function Check($value) {
        if (!array_key_exists($value, $this->memberList)) {
            $this->Error('NON_MEMBER', array('Value' => $value));
        }
	}
}
?>