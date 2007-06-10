<?php


define('PARSER_REQUIRE_PARSING', TRUE);
define('PARSER_FORBID_PARSING', FALSE);
define('PARSER_ALLOW_PARSING', NULL);


require_once WACT_ROOT . 'template/compiler/treebuilder.inc.php';
require_once WACT_ROOT . 'template/compiler/parserstate.inc.php';
require_once WACT_ROOT . 'template/compiler/htmlparser.inc.php';


class SourceFileParser {
	
	var $SourceFile;
	
	var $ComponentParsingState;
	
	var $LiteralParsingState;
	
	var $State;
	
		
	function SourceFileParser($sourcefile) {
		$this->SourceFile = $sourcefile;
	}

	
	function &buildFilterChain($saxfilters) {
		$Chain =& $this;

                if ( !empty($saxfilters) ) {
            foreach (explode(':', $saxfilters) as $saxfilter) {
                $saxfilterfile = strtolower($saxfilter).'saxfilter.inc.php';
                $saxfilterclass = $saxfilter . 'SaxFilter';
                if ( !include_once WACT_ROOT . 'template/compiler/saxfilters/'.$saxfilterfile ) {
                    RaiseError('compiler', 'SAXFILTER_NOTFOUND', array(
                        'path' => WACT_ROOT . 'template/compiler/saxfilters/'.$saxfilterfile,
                        'name' => ucfirst($saxfilter)));
                } else {
                    $NewFilter =& new $saxfilterclass();
                    $NewFilter->setChildSaxFilter($Chain);
                    $Chain =& $NewFilter;
                }
            }
        }

		return $Chain;
	}

	
	function parse(&$ComponentRoot) {
		global $TagDictionary;

		$TreeBuilder =& new TreeBuilder($ComponentRoot);

		$this->ComponentParsingState =& new ComponentParsingState($this, $TreeBuilder, $TagDictionary);
		$this->LiteralParsingState =& new LiteralParsingState($this, $TreeBuilder);
		$this->changeToComponentParsingState();
		
		$Chain =& $this->buildFilterChain(ConfigManager::getOption('compiler', 'parser', 'saxfilters'));
		$parser =& new HTMLParser($Chain);
		$parser->parse(readTemplateFile($this->SourceFile), $this->SourceFile);

		if ( $ComponentRoot->getServerId() != $TreeBuilder->Component->getServerId() ) {
			RaiseError('compiler', 'MISSINGCLOSE', array(
				'tag' => $TreeBuilder->Component->tag,
				'file' => $TreeBuilder->Component->SourceFile, 
				'line' => $TreeBuilder->Component->StartingLineNo));
		}
	}
	
	
	function changeToComponentParsingState() {
		$this->State =& $this->ComponentParsingState;
	}

	
	function changeToLiteralParsingState($tag) {
		$this->State = & $this->LiteralParsingState;
		$this->State->literalTag = $tag;
	}	

	
	function setDocumentLocator(&$locator) {
		$this->LiteralParsingState->setDocumentLocator($locator);
		$this->ComponentParsingState->setDocumentLocator($locator);
	}

	
	function startElement($tag, $attrs) {
		$this->State->startElement($tag, $attrs);
	}

	
	function endElement($tag) {
		$this->State->endElement($tag);
	}

	
	function emptyElement($tag, $attrs) {
		$this->State->emptyElement($tag, $attrs);
	}

	
	function characters($text) {
        $this->State->characters($text);
	}

	
	function cdata($text) {
        $this->State->cdata($text);
	}

	
	function processingInstruction($target, $instruction) {
		$this->State->processingInstruction($target, $instruction);
	}

	
	function escape($text) {
		$this->State->escape($text);
	}

	
	function comment($text) {
		$this->State->comment($text);
	}

	
	function doctype($text) {
		$this->State->doctype($text);
	}
	
	
	function jasp($text) {
		$this->State->jasp($text);
	}	

	
	function unexpectedEOF($text) {
        $this->State->unexpectedEOF($text);
	}

	
	function invalidEntitySyntax($text) {
        $this->State->invalidEntitySyntax($text);
	}

	
	function invalidAttributeSyntax() {
        $this->State->invalidAttributeSyntax();
	}

}

?>
