<?php


require_once 'domain.inc.php';


class EmailRule extends DomainRule {

	
	function EmailRule($fieldname) {
		parent :: DomainRule($fieldname);
	}

	
    function CheckUser($value) {
        if (!preg_match('/^[a-z0-9]+([_.-][a-z0-9]+)*$/i', $value)) {
            $this->Error('EMAIL_INVALID_USER');
        }
    }

	
    function CheckDomain($value) {
        parent::Check($value);
    }

	
    function Check($value) {
        if (is_integer(strpos($value, '@'))) {
            list($user, $domain) = split('@', $value, 2);
            $this->CheckUser($user);
            $this->CheckDomain($domain);
        } else {
            $this->Error('EMAIL_INVALID');
        }
    }
}


class DNSEmailRule extends EmailRule {

	
	function DNSEmailRule($fieldname) {
		parent :: EmailRule($fieldname);
	}

	
    function CheckDomain($value) {
        parent::CheckDomain($value);
        if ($this->IsValid()) {
            if (!checkdnsrr($value, "MX")) {
                $this->Error('EMAIL_DNS');
            }
        }
    }
}

?>