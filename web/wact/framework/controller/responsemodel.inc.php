<?php


require_once WACT_ROOT . 'util/dataspace.inc.php';


class ResponseModel extends DataSpace {

    var $isValid = TRUE;
    var $errorList = NULL;
    
    function ensureErrorList() {
        if (!is_object($this->errorList)) {
            require_once WACT_ROOT . 'validation/errorlist.inc.php';
            $this->errorList =& new ErrorList();
        }
    }

    function addError($group, $id, $fieldList = NULL, $values = NULL) {
        $this->ensureErrorList();
        $this->errorList->addError($group, $id, $fieldList, $values);
        $this->isValid = FALSE;
    }

    function addErrorMessage($message, $fieldList = NULL) {
        $this->ensureErrorList();
        $this->errorList->addErrorMessage($message, $fieldList);
        $this->isValid = FALSE;
    }
    
    function isValid() {
        return $this->isValid;
    }
    
    function &getErrorList() {
        return $this->errorList;
    }
    
    function applyRule(&$rule) {
        $result = $rule->validate($this, $this);
        $this->isValid = $this->isValid && $result;
        return $result;
    }
        
}

?>