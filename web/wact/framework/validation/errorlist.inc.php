<?php



class ErrorMessageCode  {
    
    var $Parent;

    
    var $Group;
    
    
    var $Id;
    
    
    var $FieldList;
    
    
    var $Values;
    
    
    function getErrorMessage() {
        $this->Parent->ensureErrorMessageDictionary();
        $text = $this->Parent->ErrorMessageDictionary->getMessage($this->Group, $this->Id);

        if (count($this->FieldList) > 0) {
            $this->Parent->ensureFieldNameDictionary();
        }        
        foreach($this->FieldList as $key => $fieldName) {
            $replacement = $this->Parent->FieldNameDictionary->getFieldName($fieldName);
            $text = str_replace('{' . $key . '}', $replacement, $text);
        }
        
        foreach($this->Values as $key => $replacement) {
            $text = str_replace('{' . $key . '}', $replacement, $text);
        }

        return $text;
    }
}

class ErrorMessageText {
    
    var $Message;
    
    
    var $FieldList;

    
    function getErrorMessage() {
        return $this->Message;
    }    
}


class ErrorList {
    
    var $errors = array();
    
    var $first = TRUE;
    
    var $currentError;
    
    var $fieldRestriction;    

    
    function setErrorMessageDictionary(&$Dictionary) {
        $this->ErrorMessageDictionary =& $Dictionary;
    }

    
    function ensureErrorMessageDictionary() {
        if (!isset($this->ErrorMessageDictionary)) {
            require_once WACT_ROOT . 'validation/messagedictionary.inc.php';
            $this->setErrorMessageDictionary(new ErrorMessageDictionary());
        }
    }

    
    function setFieldNameDictionary(&$Dictionary) {
        $this->FieldNameDictionary =& $Dictionary;
    }

    
    function ensureFieldNameDictionary() {
        if (!isset($this->FieldNameDictionary)) {
            require_once WACT_ROOT . 'validation/fielddictionary.inc.php';
            $this->setFieldNameDictionary(new DefaultFieldNameDictionary());
        }
    }
    
    
    function addError($Group, $Id, $FieldList = NULL, $Values = NULL) {
        $Error =& new ErrorMessageCode();

        $Error->Parent =& $this;
        $Error->Group = $Group;
        $Error->Id = $Id;
        $Error->FieldList = empty($FieldList) ? array() : $FieldList;
        $Error->Values = empty($Values) ? array() : $Values;
        
        $this->errors[] =& $Error;
    }
    
    
    function addErrorMessage($Message, $FieldList = NULL) {
        $Error =& new ErrorMessageText();
        $Error->Message = $Message;
        $Error->FieldList = empty($FieldList) ? array() : $FieldList;
        $this->errors[] =& $Error;
    }

    
    function reset() {
        $this->first = TRUE;
    }

    
    function next() {
        if ($this->first) {
            $result = reset($this->errors);
            $this->first = FALSE;
        } else {
            $result = next($this->errors);
        }
        if ($result === FALSE) {
            return FALSE;
        } else {
            $this->currentError =& $this->errors[key($this->errors)];
            if (isset($this->fieldRestriction)) {
                if (count(array_intersect($this->fieldRestriction, $this->currentError->FieldList)) > 0) {
                    return TRUE;
                } else {
                    return $this->next();
                }
            }
            return TRUE;
        }
    }

    
    function &getError() {
        return $this->currentError;
    }

    
    function getMessage() {
        return $this->currentError->getErrorMessage();
    }

    
    function get($name) {
        return $this->currentError->getErrorMessage();
    }

    
    function restrictFields($fieldRestriction) {
        $this->fieldRestriction = $fieldRestriction;
    }
    
    function removeRestrictions() {
        unset($this->fieldRestriction);
    }

}
