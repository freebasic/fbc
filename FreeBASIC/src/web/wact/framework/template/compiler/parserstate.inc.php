<?php


if (!function_exists('array_change_key_case')) {
	require_once WACT_ROOT . 'util/phpcompat/array_change_key_case.php';
}


class BaseParsingState {
	
	var $Parser;

	
	var $Locator;

	
	var $TreeBuilder;

	
	function BaseParsingState(&$Parser, &$TreeBuilder) {
		$this->Parser = & $Parser;
		$this->TreeBuilder = & $TreeBuilder;
		$this->Locator = NULL; 	}

	
	function setDocumentLocator(&$locator) {
	    $this->Locator =& $locator;
	}

	
	function invalidAttributeSyntax() {
        RaiseError('compiler', 'INVALID_ATTRIBUTE_SYNTAX', array(
            'file' => $this->Locator->getPublicId(), 
            'line' => $this->Locator->getLineNumber()));
	}

}


class ComponentParsingState extends BaseParsingState {
	
	var $TagDictionary;
	
	
	function ComponentParsingState(&$Parser, &$TreeBuilder, &$TagDictionary) {
		parent::BaseParsingState($Parser, $TreeBuilder);
		$this->TagDictionary =& $TagDictionary;
	}

    function getAttributeString($attrs) {
        $attrib_str = '';
		foreach ( $attrs as $key => $value ) {
			if (strcasecmp($key, PARSER_TRIGGER_ATTR_NAME) == 0 ) {
				continue;
			}

			$attrib_str .= ' ' . $key;
			if (!is_null($value)) {
			    if (strpos($value, '"') === FALSE) {
    				$attrib_str .= '="' . $value . '"';
    			} else {
    				$attrib_str .= '=\'' . $value . '\'';
    			}
			}
		}
		return $attrib_str;
    }

	
	function startElement($tag, $attrs) {

        $lower_attributes = array_change_key_case($attrs, CASE_LOWER);
        if ( isset($lower_attributes[PARSER_TRIGGER_ATTR_NAME]) && 
                strpos($lower_attributes[PARSER_TRIGGER_ATTR_NAME], '{$') !== FALSE) {
            RaiseError('compiler', 'ILLEGALVARREFINATTR', array(
                'tag' => $tag,
                'attribute' => $name, 	
                'file' => $this->Locator->getPublicId(), 
                'line' => $this->Locator->getLineNumber()));
        }

        $TagInfo =& $this->TagDictionary->findComponent($tag, $lower_attributes, FALSE, $this->TreeBuilder->Component);
		if (is_object($TagInfo)) {
		    $TagInfo->load();

						$this->TreeBuilder->openBranch($TagInfo, $tag, $attrs, FALSE, $this->Locator);
			
						if ( $this->TreeBuilder->Component->preParse() == PARSER_FORBID_PARSING) {
				$this->Parser->changeToLiteralParsingState($tag);
			}

						if ( $TagInfo->EndTag == ENDTAG_FORBIDDEN ) {
				$this->TreeBuilder->closeBranch(FALSE);
				$this->Parser->changeToComponentParsingState();
			}
		} else {
		    if (strcasecmp($this->TreeBuilder->Component->tag, $tag) == 0 ) {
				$this->TreeBuilder->Component->plainTagCount++;
			}
            $this->TreeBuilder->addContent($this->Locator, 
                '<' . $tag . $this->getAttributeString($attrs) . '>');
		}
    }

	
	function endElement($tag) {
        $TagInfo =& $this->TagDictionary->getTagInfo($tag);
        if (is_object($TagInfo) && $TagInfo->EndTag == ENDTAG_FORBIDDEN) {
            RaiseError('compiler', 'UNEXPECTEDCLOSE2', array(
                'tag' => $TagInfo->Tag,
                'file' => $this->Locator->getPublicId(), 
                'line' => $this->Locator->getLineNumber()));
        }
        if ( strcasecmp($this->TreeBuilder->Component->tag, $tag) == 0 ) {
                        if ($this->TreeBuilder->Component->plainTagCount != 0 ) {
                $this->TreeBuilder->Component->plainTagCount--;
           		$this->TreeBuilder->addTextNode('</' . $tag . '>');
            } else {
                $this->TreeBuilder->closeBranch(TRUE);
            }
        } else {
       		$this->TreeBuilder->addTextNode('</' . $tag . '>');
        }
    }

	
	function emptyElement($tag, $attrs) {
        $lower_attributes = array_change_key_case($attrs, CASE_LOWER);
        if ( isset($lower_attributes[PARSER_TRIGGER_ATTR_NAME]) && 
                strpos($lower_attributes[PARSER_TRIGGER_ATTR_NAME], '{$') !== FALSE) {
            RaiseError('compiler', 'ILLEGALVARREFINATTR', array(
                'tag' => $this->Component->tag,
                'attribute' => $name, 	
                'file' => $this->Locator->getPublicId(), 
                'line' => $this->Locator->getLineNumber()));
        }

        $TagInfo =& $this->TagDictionary->findComponent($tag, $lower_attributes, TRUE, $this->TreeBuilder->Component);
		if (is_object($TagInfo)) {
		    $TagInfo->load();

						$this->TreeBuilder->openBranch($TagInfo, $tag, $attrs, TRUE, $this->Locator);
			
						if ( $this->TreeBuilder->Component->preParse() == PARSER_FORBID_PARSING) {
				$this->Parser->changeToLiteralParsingState($tag);
			}

						if ( $TagInfo->EndTag == ENDTAG_FORBIDDEN ) {
				$this->Parser->changeToComponentParsingState();
				$this->TreeBuilder->closeBranch(FALSE);
			} else {
                $this->TreeBuilder->closeBranch(TRUE);
			}
		} else {
            $this->TreeBuilder->addContent($this->Locator, 
                '<' . $tag . $this->getAttributeString($attrs) . ' />');
		}
    }

	
	function characters($text) {
		$this->TreeBuilder->addContent($this->Locator, $text);
	}

	
	function cdata($text) {
		$this->TreeBuilder->addContent($this->Locator, '<![CDATA[' . $text . ']]>');
	}

	
	function processingInstruction($target, $instruction) {
	    $this->TreeBuilder->addProcessingInstructionNode($target, $instruction);
	}

	
	function jasp($text) {
                $this->TreeBuilder->addContent($this->Locator, '<%' . $text . '%>');
	}
	
	
	function escape($text) {
    	$this->TreeBuilder->addContent($this->Locator, '<!' . $text . '>');
	}

	
	function doctype($text) {
    	$this->TreeBuilder->addContent($this->Locator, '<!' . $text . '>');
	}

	
	function comment($text) {
            	$this->TreeBuilder->addContent($this->Locator, '<!--' . $text . '-->');
	}

	
	function unexpectedEOF($text) {
	    		$this->TreeBuilder->addContent($this->Locator, $text);
	}

	
	function invalidEntitySyntax($text) {
	    		$this->TreeBuilder->addContent($this->Locator, $text);
	}

}


class LiteralParsingState extends BaseParsingState {
	
	var $literalTag;
	
	
	function LiteralParsingState(&$Parser, &$TreeBuilder) {
		parent::BaseParsingState($Parser, $TreeBuilder);
	}

    function getAttributeString($attrs) {
        $attrib_str = '';
		foreach ( $attrs as $key => $value ) {
			$attrib_str .= ' ' . $key;
			if (!is_null($value)) {
			    if (strpos($value, '"') === FALSE) {
    				$attrib_str .= '="' . $value . '"';
    			} else {
    				$attrib_str .= '=\'' . $value . '\'';
    			}
			}
		}
		return $attrib_str;
    }

	
	function startElement($tag, $attrs) {
        $this->TreeBuilder->addTextNode('<' . $tag . $this->getAttributeString($attrs) . '>');
	}

	
	function endElement($tag) {
		if ( $this->literalTag == $tag ) {
			$this->TreeBuilder->closeBranch(TRUE);
			$this->Parser->changeToComponentParsingState();
		} else {
    		$this->TreeBuilder->addTextNode('</' . $tag . '>');
		}
	}

	
    function emptyElement($tag, $attrs) { 
        $this->TreeBuilder->addTextNode('<' . $tag . $this->getAttributeString($attrs) . ' />');
    }

	
	function characters($text) {
		$this->TreeBuilder->addTextNode($text);
	}

	
	function cdata($text) {
		$this->TreeBuilder->addTextNode('<![CDATA[' . $text . ']]>');
	}

	
	function processingInstruction($target, $instruction) {
		$this->TreeBuilder->addTextNode('<?' . $target . ' ' . $instruction . '?>');
	}

	
	function jasp($text) {
		$this->TreeBuilder->addTextNode('<%' .  $text . '%>');
	}	
	
	
	function escape($text) {
		$this->TreeBuilder->addTextNode('<!' . $text . '>');
	}

	
	function comment($text) {
		$this->TreeBuilder->addTextNode('<!--' . $text . '-->');
	}

	
	function doctype($text) {
		$this->TreeBuilder->addTextNode('<!' . $text . '>');
	}
	
	
	function unexpectedEOF($text) {
	    		$this->TreeBuilder->addTextNode($text);
	}

	
	function invalidEntitySyntax($text) {
	    		$this->TreeBuilder->addTextNode($text);
	}

}
?>