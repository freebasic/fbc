<?php


class CompilerComponent {

	var $attributeNodes = array();


	var $children = array();


	var $properties = array();


	var $parent = NULL;


	var $ServerId;


	var $tag = '';


	var $SourceFile;


	var $StartingLineNo;


	var $hasClosingTag = TRUE;


	var $emptyClosedTag = FALSE;


	var $plainTagCount = 0;


	var $TagInfo = NULL;


	var $WrappingComponents = array();


    function registerWrapper(&$wrapper) {
        $this->WrappingComponents[] =& $wrapper;
    }


	function addChildAttribute(&$child) {
	    $attrib = strtolower($child->name);
	    if (isset($this->attributeNodes[$attrib])) {
			RaiseError('compiler', 'DUPLICATEATTRIBUTE', array(
				'attribute' => $attrib,
				'tag' => $this->tag,
				'file' => $this->SourceFile,
				'line' => $this->StartingLineNo));
	    }
		$this->attributeNodes[$attrib] =& $child;
	}


	function setAttribute($attrib, $value) {
		$Component =& new AttributeNode($attrib, $value);
		$this->addChildAttribute($Component);
    }


	function getAttribute($attrib) {
		if ( isset($this->attributeNodes[strtolower($attrib)]) ) {
			return $this->attributeNodes[strtolower($attrib)]->getValue();
		}
	}

	function hasAttribute($attrib) {
		return isset($this->attributeNodes[strtolower($attrib)]);
	}


    function getBoolAttribute($attrib, $default = FALSE) {
		if ( isset($this->attributeNodes[strtolower($attrib)]) ) {
			switch (strtoupper($this->attributeNodes[strtolower($attrib)]->getValue())) {
			case 'FALSE':
			case 'N':
			case 'NO':
			case 'NONE':
			case 'NA':
			case '0':
				return false;
			default:
				return true;
			}
		} else {
		    return $default;
        }
	}


	function removeAttribute($attrib) {
        unset($this->attributeNodes[strtolower($attrib)]);
	}


	function getAttributesAsArray($suppress = array()) {
	    $suppress = array_map('strtolower', $suppress);
		$attributes = array();
		foreach( array_keys($this->attributeNodes) as $key) {
		    if (!in_array($key, $suppress) && $this->attributeNodes[$key]->isConstant()) {
    		    $attributes[$this->attributeNodes[$key]->name] =
        		    $this->attributeNodes[$key]->getValue();
    		    $this->getAttribute($key);
            }
        }
        return $attributes;
	}

    function generateAttributeList(&$code, $suppress = array()) {
	    $suppress = array_map('strtolower', $suppress);
		foreach( array_keys($this->attributeNodes) as $key) {
		    if (!in_array($key, $suppress)) {
		        $this->attributeNodes[$key]->generate($code);
            }
		}
    }

    function generateDynamicAttributeList(&$code, $suppress = array()) {
	    $suppress = array_map('strtolower', $suppress);
		foreach( array_keys($this->attributeNodes) as $key) {
		    if (!in_array($key, $suppress) && !$this->attributeNodes[$key]->isConstant()) {
		        $this->attributeNodes[$key]->generate($code);
            }
		}
    }


    function registerProperty($name, &$property) {
        $this->properties[$name] =& $property;
    }


    function &getProperty($name) {
        if (array_key_exists($name, $this->properties)) {
            return $this->properties[$name];
        } else {
            if ($this->isDataSource()) {
                return NULL;
            } else {
                return $this->parent->getProperty($name);
            }
        }
    }


	function getClientId() {
		if ( $this->hasAttribute('id') ) {
			return $this->getAttribute('id');
		}
	}


	function getServerId() {
		if ($this->hasAttribute('id')) {
			return $this->getAttribute('id');
		} else if (!empty($this->ServerId)) {
			return $this->ServerId;
		} else {
			$this->ServerId = getNewServerId();
			return $this->ServerId;
		}
	}


	function addChild(&$child) {
		$child->parent =& $this;
		$this->children[] =& $child;
	}


	function &removeChild($ServerId) {
		foreach( array_keys($this->children) as $key) {
			$child =& $this->children[$key];
			if ($child->getServerid() == $ServerId) {
				unset($this->children[$key]);
				return $child;
			}
		}
	}


	function &getLastChild() {
				$end = count($this->children)-1;
		if ( $end >= 0 ) {
			return $this->children[$end];
		}
		return FALSE;
	}


	function &findChild($ServerId) {
		foreach( array_keys($this->children) as $key) {
			if ($this->children[$key]->getServerid() == $ServerId) {
				return $this->children[$key];
			} else {
				$result =& $this->children[$key]->findChild($ServerId);
				if ($result) {
					return $result;
				}
			}
		}
		return FALSE;
	}


	function &findChildByClass($class) {
		foreach( array_keys($this->children) as $key) {
			if (is_a($this->children[$key], $class)) {
				return $this->children[$key];
			} else {
				$result =& $this->children[$key]->findChildByClass($class);
				if ($result) {
					return $result;
				}
			}
		}
		return FALSE;
	}


	function findChildrenByClass($class) {
		$ret = array();
		foreach( array_keys($this->children) as $key) {
			if (is_a($this->children[$key], $class)) {
				$ret[] =& $this->children[$key];
			} else {
				$more_children = $this->children[$key]->findChildrenByClass($class);
				if (count($more_children)) {
					$ret = array_merge($ret, $more_children);
				}
			}
		}
		return $ret;
	}


	function &findImmediateChildByClass($class) {
		foreach( array_keys($this->children) as $key) {
			if (is_a($this->children[$key], $class)) {
				return $this->children[$key];
			}
		}
		return FALSE;
	}


	function &findParentByClass($class) {
		$Parent =& $this->parent;
		while ($Parent && !is_a($Parent, $class)) {
			$Parent =& $Parent->parent;
		}
		return $Parent;
	}


	function & findSelfOrParentByClass($class) {
		if (is_a($this, $class)) {
			return $this;
		} else {
			return $this->findParentByClass($class);
		}
	}


	function prepare() {
		foreach( array_keys($this->attributeNodes) as $key) {
			$this->attributeNodes[$key]->prepare();
		}
		foreach( array_keys($this->children) as $key) {
			$this->children[$key]->prepare();
		}
	}


	function CheckNestingLevel() {
	}


	function preParse() {
		return PARSER_REQUIRE_PARSING;
	}


	function isDataSource() {
	    return FALSE;
	}


	function &getDataSource() {
	    if (!$this->isDataSource()) {
            if (isset($this->parent)) {
                return $this->parent->getDataSource();
            }
        }
	}


	function &getParentDataSource() {
		$DataSource =& $this->getDataSource();
		if (isset($DataSource->parent)) {
			return $DataSource->parent->getDataSource();
		}
	}


	function &getRootDataSource() {
		$root =& $this;
		while ($root->parent != NULL) {
			$root =& $root->parent;
		}
		return $root;
	}


	function getDataSourceRefCode() {
		return $this->parent->getDataSourceRefCode();
	}


	function getComponentRefCode() {
		return $this->parent->getComponentRefCode();
	}


	function generateConstructor(&$code) {
		foreach( array_keys($this->children) as $key) {
			$this->children[$key]->generateConstructor($code);
		}
	}


	function generateContents(&$code) {
		foreach( array_keys($this->children) as $key) {
			$this->children[$key]->generate($code);
		}
	}


	function preGenerate(&$code) {
		foreach( array_keys($this->WrappingComponents) as $key) {
			$this->WrappingComponents[$key]->generateWrapperPrefix($code);
		}
		foreach( array_keys($this->properties) as $key) {
		    if ($this->properties[$key]->isActive()) {
    			$this->properties[$key]->generateScopeEntry($code);
    		}
		}
	}


	function postGenerate(&$code) {
		foreach( array_keys($this->properties) as $key) {
		    if ($this->properties[$key]->isActive()) {
    			$this->properties[$key]->generateScopeExit($code);
    		}
		}
		foreach( array_reverse(array_keys($this->WrappingComponents)) as $key) {
			$this->WrappingComponents[$key]->generateWrapperPostfix($code);
		}
	}


	function generate(&$code) {
		$this->preGenerate($code);
		$this->generateContents($code);
		$this->postGenerate($code);
	}
}
?>