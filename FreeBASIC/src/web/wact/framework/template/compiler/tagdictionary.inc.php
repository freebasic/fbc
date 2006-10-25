<?php


require_once WACT_ROOT . 'template/compiler/common/dictionary.inc.php';


define('ENDTAG_REQUIRED', 1);

define('ENDTAG_OPTIONAL', 2);

define('ENDTAG_FORBIDDEN', 3);


define('LOCATION_SERVER', 'server');
define('LOCATION_CLIENT', 'client');


define('PARSER_TRIGGER_ATTR_NAME','runat'); define('PARSER_TRIGGER_ATTR_VALUE','server');


define('PARSER_USEKNOWN_ATTR','useknown');


class TagInfo {
	var $Tag = '';
	var $EndTag = ENDTAG_REQUIRED;
	var $TagClass = '';
	var $CompilerAttributes = array();
	var $KnownParent;
	var $DefaultLocation = LOCATION_SERVER;
	var $File;

    function TagInfo($tag, $class) {
        $this->Tag = $tag;
        $this->TagClass = $class;
    }

    function setEndTag($end) {
        $this->EndTag = $end;
    }

    function setCompilerAttributes($attributes) {
        $this->CompilerAttributes = $attributes;
    }

    function setKnownParent($parent) {
        $this->KnownParent = $parent;
    }

    function setDefaultLocation($location) {
        $this->DefaultLocation = $location;
    }

    function load() {
        if (!class_exists($this->TagClass) && isset($this->File)) {
            require_once $this->File;
        }
    }
}


class TagDictionary extends CompilerArtifactDictionary {

	var $TagInformation = array();

    function TagDictionary() {
        parent::CompilerArtifactDictionary();
    }


	function _registerTag($taginfo) {
		$tag = strtolower($taginfo->Tag);
		$this->TagInformation[$tag] =& $taginfo;
	}


    function registerTag(&$taginfo, $file) {
        $taginfo->File = $file;
        $GLOBALS['TagDictionary']->_registerTag($taginfo);
    }


	function &getTagInfo($tag) {
	    if (isset($this->TagInformation[strtolower($tag)])) {
    		return $this->TagInformation[strtolower($tag)];
	    }
	}


	function &getInstance() {
	    return parent::_getInstance('TagDictionary', 'TagDictionary', 'tag');
	}


	function &findComponent($tag, $attrs, $isEmpty, &$Component) {

				if ( isset ( $attrs[PARSER_TRIGGER_ATTR_NAME] ) ) {

			            if ( strtolower($attrs[PARSER_TRIGGER_ATTR_NAME]) == PARSER_TRIGGER_ATTR_VALUE ) {
                if (isset($this->TagInformation[strtolower($tag)])) {
                    return $this->TagInformation[strtolower($tag)];
                } else {
                                                            if ( !$isEmpty ) {
                        $generic =& new TagInfo($tag, 'GenericContainerTag');
                        $generic->File = WACT_ROOT . 'template/compiler/generictag.inc.php';

                        $generic->setEndTag(ENDTAG_REQUIRED);
                    } else {
                        $generic =& new TagInfo($tag, 'GenericTag');
                        $generic->File = WACT_ROOT . 'template/compiler/generictag.inc.php';
                        $generic->setEndTag(ENDTAG_FORBIDDEN);
                    }
                    $generic->setDefaultLocation(LOCATION_CLIENT);

                    return $generic;
                }
            }
		} else if ( isset($this->TagInformation[strtolower($tag)]) ) {

			$TagInfo =& $this->TagInformation[strtolower($tag)];

									if ($TagInfo->DefaultLocation == LOCATION_SERVER) {
				return $TagInfo;
			}

																					if ( isset($TagInfo->KnownParent) ) {
				if ( $KnownParent = & $Component->findSelfOrParentByClass($TagInfo->KnownParent) ) {
					if ( $KnownParent->getBoolAttribute('useknown',TRUE) ) {
						return $TagInfo;
					}
				}
			}
		}
    	return NULL;
	}

}
?>