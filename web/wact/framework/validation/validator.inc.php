<?php



class Validator {
    
    var $rules = array();
    
    var $ErrorList;
    
    var $IsValid = TRUE;

    
    function &createErrorList() {
        require_once WACT_ROOT . 'validation/errorlist.inc.php';
        return new ErrorList();
    }

    
    function addRule(&$Rule) {
        $this->rules[] = $Rule;
    }

    
    function &getErrorList() {
        return $this->ErrorList;
    }

    
    function IsValid($FieldName = NULL) {
        return $this->IsValid;
    }

    
    function validate(&$DataSource) {
        $ErrorList =& $this->createErrorList();
        foreach( array_keys($this->rules) as $key) {
            if (! $this->rules[$key]->validate($DataSource, $ErrorList)) {
                $this->IsValid = FALSE;
            }
        }

        $this->ErrorList =& $ErrorList;
    }
}

?>