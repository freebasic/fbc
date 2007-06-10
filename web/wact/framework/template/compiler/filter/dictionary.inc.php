<?php


require_once WACT_ROOT . 'template/compiler/common/dictionary.inc.php';

class FilterInfo {
    var $Name = 'capitalize';
    var $FilterClass = 'CapitalizeFilter';
    var $MinParameterCount = 0;
    var $MaxParameterCount = 0;
    var $File;
    
    function FilterInfo($Name, $FilterClass, $MinParameterCount = 0, $MaxParameterCount = 0) {
        $this->Name = $Name;
        $this->FilterClass = $FilterClass;
        $this->MinParameterCount = $MinParameterCount;
        $this->MaxParameterCount = $MaxParameterCount;
    }

    function load() {
        if (!class_exists($this->FilterClass) && isset($this->File)) {
            require_once $this->File;
        }
    }
    
}


class FilterDictionary extends CompilerArtifactDictionary {

	
	var $FilterInformation = array();

    function FilterDictionary() {
        parent::CompilerArtifactDictionary();
    }    

	
	function _registerFilter(&$FilterInfo) {
		$name = strtolower($FilterInfo->Name);
		$this->FilterInformation[$name] =& $FilterInfo;
	}

    
    function registerFilter(&$FilterInfo, $file) {
        $FilterInfo->File = $file;
        $GLOBALS['FilterDictionary']->_registerFilter($FilterInfo);
    }

	
	function &getFilterInfo($name) {
		return $this->FilterInformation[strtolower($name)];
	}

	
	function &getInstance() {
	    return parent::_getInstance('FilterDictionary', 'FilterDictionary', 'filter');
	}
}
?>