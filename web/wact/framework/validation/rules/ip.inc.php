<?php



require_once 'domain.inc.php';


class IPAddressRule extends SingleFieldRule {

	
	function IPAddressRule($fieldname) {
		parent :: SingleFieldRule($fieldname);
	}

	
    function Check($value) {
        if (is_integer(strpos($value, '.'))) {
            $quad = explode('.', $value);
            if (count($quad) != 4) {
                $this->Error('IP_INVALID');
            } else {
                foreach($quad as $element) {
                    if (!preg_match('/^\d+$/', $element)) {
                        $this->Error('IP_INVALID');
                        break;
                    }
                    if (intval($element) > 255) {
                        $this->Error('IP_INVALID');
                        break;
                    }
                }
            }
        } else {
            $this->Error('IP_INVALID');
        }
    }
}


class PartialIPAddressRule extends SingleFieldRule {

	
	function PartialIPAddressRule($fieldname) {
		parent :: SingleFieldRule($fieldname);
	}

	
    function Check($value) {
        if ($value{strlen($value)-1} != '.') {
            $this->Error('IP_INVALID');
        } else {
            $quad = explode('.', substr($value, 0, strlen($value)-1));
            if (count($quad) > 4) {
                $this->Error('IP_INVALID');
            } else {
                foreach($quad as $element) {
                    if (!preg_match('/^\d+$/', $element)) {
                        $this->Error('IP_INVALID');
                        break;
                    }
                    if (intval($element) > 255) {
                        $this->Error('IP_INVALID');
                        break;
                    }
                }
            }
        }
    }
}

?>