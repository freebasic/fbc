<?php



define('WACT_EXPPARSER_BEFORE_CONTENT', 1);
define('WACT_EXPPARSER_EXPRESSION', 2);
define('WACT_EXPPARSER_AFTER_CONTENT',  5);



class TreeBuilder {
	
	var $ParentComponent;
	
	var $Component;

    var $variableReferencePattern;
    
	
	function TreeBuilder(&$ComponentRoot) {
		$this->Component =& $ComponentRoot;
		$this->ParentComponent = NULL;

        $this->variableReferencePattern =
                        '/^' . 
                        '((?s).*?)' .
                        preg_quote('{$', '/') .
                        '(' . 
                                '(' . 
                                                            '[^"\'}]+' .
                                        '|' .
                                        '(\'|").*?\4' .
                ')+' . 
            ')' .
                        preg_quote('}', '/') .
                                                '((?s).*)' .
                        '$/';
	}

	
	function openBranch(&$TagInfo, $tag, $attrs, $isEmpty, &$Locator) {
		$this->ParentComponent =& $this->Component;
		
		$this->Component =& $this->createComponent($TagInfo, $tag, $Locator);
   	    $this->Component->emptyClosedTag = $isEmpty;
		$this->buildAttributes($attrs);
		
		$this->checkServerId($this->Component);
		$this->ParentComponent->addChild($this->Component);
		$this->Component->CheckNestingLevel();
	}

	
	function &createComponent(&$TagInfo, $tag, &$Locator) {
	    $class = $TagInfo->TagClass;
		$component =& new $class();
        $component->SourceFile = $Locator->getPublicId();
        $component->StartingLineNo = $Locator->getLineNumber(); 
		$component->tag = $tag;
		$component->TagInfo =& $TagInfo;
		$properties = $GLOBALS['PropertyDictionary']->getPropertyList($tag);
		foreach ($properties as $property) {
		    $property->load();
		    $PropertyClass = $property->PropertyClass;
            $component->registerProperty(
                $property->Property, new $PropertyClass($component));

		}
		return $component;
	}

    function &createAttributeExpression($name, $expression) {
        if (strcasecmp($name, 'id') == 0 ) {
            RaiseError('compiler', 'ILLEGALVARREFINATTR', array(
                'tag' => $this->Component->tag,
                'attribute' => $name, 	
                'file' => $this->Component->SourceFile, 
                'line' => $this->Component->StartingLineNo));
        }

        return new AttributeExpression($name, $expression, $this->Component);
    }

    function &createCompoundAttribute($name, $value) {
        if (strcasecmp($name, 'id') == 0 ) {
            RaiseError('compiler', 'ILLEGALVARREFINATTR', array(
                'tag' => $this->Component->tag,
                'attribute' => $name, 	
                'file' => $this->Component->SourceFile, 
                'line' => $this->Component->StartingLineNo));
        }

        $attribute =& new CompoundAttribute($name);
        
        while (preg_match($this->variableReferencePattern, $value, $match)) {
            if (strlen($match[WACT_EXPPARSER_BEFORE_CONTENT]) > 0) {
                $attribute->addAttributeFragment(
                    new AttributeNode($name, $match[WACT_EXPPARSER_BEFORE_CONTENT]));
            }
            
            $attribute->addAttributeFragment(new AttributeExpression($name,
                $match[WACT_EXPPARSER_EXPRESSION], $this->Component));
            
            $value = $match[WACT_EXPPARSER_AFTER_CONTENT];
        }
        if (strlen($value) > 0) {
            $attribute->addAttributeFragment(new AttributeNode($name, $value));
        }
        
        return $attribute;
    }

	
	function buildAttributes($Attributes) {
		foreach ( $Attributes as $name => $value ) {
                        if (strpos($value, '{$') === FALSE) {
                $attribute =& new AttributeNode($name, $value);
            } else {
                if (preg_match($this->variableReferencePattern, $value, $match)) {
                    if (strlen($match[WACT_EXPPARSER_AFTER_CONTENT]) == 0 && 
                        strlen($match[WACT_EXPPARSER_BEFORE_CONTENT]) == 0) {
                        $attribute =& $this->createAttributeExpression($name, 
                            $match[WACT_EXPPARSER_EXPRESSION]);
                    } else {
                        $attribute =& $this->createCompoundAttribute($name, $value);
                    }
                } else {
                    $attribute =& new AttributeNode($name, $value);
                }
            }

            $this->Component->addChildAttribute($attribute);
		}
	}

	
	function checkServerId(&$Component) {
		$Tree = & GetComponentTree();
		$ServerId = $Component->getServerId();
		if (in_array($ServerId,$Tree->tagIds) ) {
			RaiseError('compiler', 'DUPLICATEID', array(
				'ServerId' => $ServerId,
				'tag' => $Component->tag,
				'file' => $Component->SourceFile, 
				'line' => $Component->StartingLineNo));
		} else {
			$Tree->tagIds[]=$ServerId;
		}
	}

	
	function addContent(&$Locator, $text) {
                if (strpos($text, '{$') === FALSE) {
            $this->addTextNode($text);
            return;
        }

        while (preg_match($this->variableReferencePattern, $text, $match)) {
            if (strlen($match[WACT_EXPPARSER_BEFORE_CONTENT]) > 0) {
                $this->addTextNode($match[WACT_EXPPARSER_BEFORE_CONTENT]);
            }

            $expression =& new OutputExpression($match[WACT_EXPPARSER_EXPRESSION]);
            $expression->SourceFile = $Locator->getPublicId();
            $expression->StartingLineNo = $Locator->getLineNumber(); 
            $this->Component->addChild($expression);
        
            $text = $match[WACT_EXPPARSER_AFTER_CONTENT];
        }
        if (strlen($text) > 0) {
            $this->addTextNode($text);
        }
	}

	
	function addTextNode($text) {
		$LastChild = & $this->Component->getLastChild();
		if ( is_a($LastChild, 'TextNode') ) {
			$LastChild->append($text);
		} else {
			$TextNode =& new TextNode($text);
			$this->Component->addChild($TextNode);
		}
	}

	
	function addProcessingInstructionNode($target, $instruction) {
	    	            require_once WACT_ROOT . 'template/compiler/phpnode.inc.php';
	
				$invalid_targets = array('php','PHP','=','');
		if ( !in_array($target, $invalid_targets) ) {
			$php = 'echo "<?'.$target.' '; 			$php.= str_replace('"','\"',$instruction);
			$php.= '?>\n";'; 			$this->Component->addChild(new PHPNode($php));
		}
	}

	
	function closeBranch($hasClosingTag) {
		$this->Component->hasClosingTag = $hasClosingTag;
		$this->Component = & $this->ParentComponent;
		$this->ParentComponent = & $this->Component->parent;	
	}
}
?>