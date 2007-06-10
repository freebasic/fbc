<?php



class Rule {
    
    var $Group = 'validation';
    
    
    function setGroup($Group) {
        $this->Group = $Group;
    }

    
    function validate(&$DataSource, &$ErrorList) {
        RaiseError('compiler', 'ABSTRACTMETHOD',
                   array('method' => __FUNCTION__ .'()', 'class' => __CLASS__));
    }
}


class SingleFieldRule extends Rule {
    
    var $fieldname;
    
    var $IsValid = TRUE;
    
    var $ErrorList;

    
    function SingleFieldRule($fieldname) {
        $this->fieldname = $fieldname;
    }

    
    function getField() {
        return $this->fieldname;
    }

    
    function Error($id, $values = NULL) {
        $this->IsValid = FALSE;
        $this->ErrorList->addError($this->Group, $id, 
            array('Field' => $this->fieldname), $values);
    }

    
    function IsValid() {
        return $this->IsValid;
    }
    
    
    function validate(&$DataSource, &$ErrorList) {
        $this->IsValid = TRUE;
        $this->ErrorList =& $ErrorList;
        $value = $DataSource->get($this->fieldname);
        if (isset($value) && $value !== '') {
            $this->Check($value);
        }
        return $this->IsValid;
    }

    
    function Check($value) {
        RaiseError('compiler', 'ABSTRACTMETHOD',
                   array('method' => __FUNCTION__ .'()', 'class' => __CLASS__));
    }
}


class RequiredRule extends SingleFieldRule {
    
    function RequiredRule($fieldname) {
        parent :: SingleFieldRule($fieldname);
    }

	
    function validate(&$DataSource, &$ErrorList) {
        $value = $DataSource->get($this->fieldname);
        if (!isset($value) || $value === '') {
            $ErrorList->addError($this->Group, 'MISSING', 
                array('Field' => $this->fieldname));
            return FALSE;
        }
        return TRUE;
    }
}


class SizeRangeRule extends SingleFieldRule {
    
    var $minLength;
    
    var $maxLength;

    
    function SizeRangeRule($fieldname, $minLength, $maxLength = NULL) {
        parent :: SingleFieldRule($fieldname);
        if (is_null($maxLength)) {
            $this->minLength = NULL;
            $this->maxLength = $minLength;
        } else {
            $this->minLength = $minLength;
            $this->maxLength = $maxLength;
        }
    }

	
    function Check($value) {
        if (!is_null($this->minLength) && (strlen($value) < $this->minLength)) {
            $this->Error('SIZE_TOO_SMALL', array('min' => $this->minLength));
        } else if (strlen($value) > $this->maxLength) {
            $this->Error('SIZE_TOO_BIG', array('max' => $this->maxLength));
        }
    }
}

?>