<?php


require_once WACT_ROOT . 'template/compiler/common/dictionary.inc.php';

class PropertyInfo {
    var $Property;
	var $Tag;
	var $PropertyClass;
	var $File;
	
	function PropertyInfo($property, $tag, $class) {
	    $this->Property = $property;
	    $this->Tag = $tag;
	    $this->PropertyClass = $class;
	}

    function load() {
        if (!class_exists($this->PropertyClass) && isset($this->File)) {
            require_once $this->File;
        }
    }
}


class PropertyDictionary extends CompilerArtifactDictionary {

	
	var $PropertyInformation = array();

    function PropertyDictionary() {
        parent::CompilerArtifactDictionary();
    }    
    
	
	function _registerProperty(&$PropertyInfo) {
		$tag = strtolower($PropertyInfo->Tag);
		$this->PropertyInformation[$tag][] =& $PropertyInfo;
	}

    
    function registerProperty(&$PropertyInfo, $file) {
        $PropertyInfo->File = $file;
        $GLOBALS['PropertyDictionary']->_registerProperty($PropertyInfo);
    }

	
	function getPropertyList($tag) {
	    $tag = strtolower($tag);
	    if (isset($this->PropertyInformation[$tag])) {
    		return $this->PropertyInformation[$tag];
        } else {
            return array();
        }
	}

	
	function &getInstance() {
	    return parent::_getInstance('PropertyDictionary', 'PropertyDictionary', 'prop');
	}
}
?>