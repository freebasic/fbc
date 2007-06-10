<?php


require_once WACT_ROOT . 'validation/rule.inc.php';


class DomainRule extends SingleFieldRule {

	
	function DomainRule($fieldname) {
		parent :: SingleFieldRule($fieldname);
	}

	
    function Check($value) {
                                if (!preg_match("/^[a-z0-9.-]+$/i", $value)) {
            $this->Error('BAD_DOMAIN_CHARACTERS');
        }

        if (is_integer(strpos($value, '--', $value))) {
            $this->Error('BAD_DOMAIN_DOUBLE_HYPHENS');
        }

        if (0 === strpos($value, '.')) {
            $this->Error('BAD_DOMAIN_STARTING_PERIOD');
        }

        if (strlen($value) -1 === strrpos($value, '.')) {
            $this->Error('BAD_DOMAIN_ENDING_PERIOD');
        }

        if (is_integer(strpos($value, '..', $value))) {
            $this->Error('BAD_DOMAIN_DOUBLE_DOTS');
        }

        $segments = explode('.', $value);
        foreach($segments as $dseg) {
            $len = strlen($dseg);
            
            if (1 > $len) {
                continue;
            }
            if ($len > 63) {
                $this->Error('BAD_DOMAIN_SEGMENT_TOO_LARGE',
                             array('segment' => $dseg));
            }
            if ($dseg{$len-1} == '-' || $dseg{0} == '-') {
                $this->Error('BAD_DOMAIN_HYPHENS', array('segment' => $dseg));
            }

        }
	}
}


class DNSDomainRule extends DomainRule {

	
	function DNSDomainRule($fieldname) {
		parent :: SingleFieldRule($fieldname);
	}

	
    function Check($value) {

        parent::Check($value);
        if ($this->IsValid()) {
            if (!checkdnsrr($value, 'A')) {
                $this->Error('BAD_DOMAIN_DNS');
            }
        }
	}
}
?>