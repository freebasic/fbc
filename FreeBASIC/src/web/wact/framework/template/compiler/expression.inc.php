<?php


require_once WACT_ROOT . 'template/compiler/expressionlexer.inc.php';


class Expression {
	
	
	var $filterChain;

	
	var $expression;

	
	function Expression($expression, &$ComponentContext, $DefaultFilter = 'raw') {
		$this->expression = $expression;
		$ApplyDefaultFilter = TRUE;
		if (preg_match('/^(.*)\s*\|\s*raw$/is', $expression, $match)) {
			$ApplyDefaultFilter = FALSE;
			$expression = $match[1];
		}
		if ($DefaultFilter == 'raw') {
			$ApplyDefaultFilter = FALSE;
		}
		
		$pos = strpos($expression, "|");
		if ($pos === FALSE) {
			$base =& $this->createValue($expression, $ComponentContext);
		} else {
			$dbe = trim(substr($expression, 0, $pos));
			$filters = trim(substr($expression, $pos + 1));
			$base =& $this->createFilterChain(
				$filters,
				$this->createValue($dbe, $ComponentContext),
				$ComponentContext);
		}
		
		if ($ApplyDefaultFilter) {
			$fd =& FilterDictionary::getInstance();
			$filterInfo =& $fd->getFilterInfo($DefaultFilter);
			if (is_object($filterInfo)) {
			    $filterInfo->load();
				$filter_class = $filterInfo->FilterClass;

                                				if (strcasecmp(get_class($base), $filter_class) == 0) {
        			$this->filterChain =& $base;
				} else {
                    $filter =& new $filter_class();
                    $filter->registerBase($base);
                    $this->filterChain =& $filter;
				}
			} else {
				RaiseError('compiler', 'MISSING_FILTER', array(
					'filter' => $DefaultFilter,
					'file' => $ComponentContext->SourceFile,
					'line' => $ComponentContext->StartingLineNo));
			}
		} else {
			$this->filterChain =& $base;
		}
	}

	
	function &createValue($expression, &$ComponentContext) {
		$Parser = & new ExpressionValueParser($expression);

		switch ( $Parser->ValueType ) {
						case EXPRESSION_VALUE_INT:
			case EXPRESSION_VALUE_FLOAT:
			case EXPRESSION_VALUE_STRING:
				return new ConstantProperty($Parser->Value);
			break;

			case EXPRESSION_VALUE_DATABINDING:
			default:
				return new DataBindingExpression($expression, $ComponentContext);
			break;

		}

	}

	
	function &createFilterChain($expr, $Value, &$ComponentContext) {

		$Fd =& FilterDictionary::getInstance();

		$FFp = & new ExpressionFilterFindingParser($expr);

		$Base = & $Value;

		if ( count($FFp->Filters) == 0 ) {
			return $Value;
		}

		foreach ( $FFp->Filters as $filter_expr ) {

			$Fp = & new ExpressionFilterParser($filter_expr);

			if ( is_null($Fp->Name) ) {
				RaiseError('compiler', 'INVALID_FILTER_SPEC', array(
					'file' => $ComponentContext->SourceFile,
					'line' => $ComponentContext->StartingLineNo));
				return $Value;
			}

			$FilterInfo =& $Fd->getFilterInfo($Fp->Name);

			if (!is_object($FilterInfo)) {
				RaiseError('compiler', 'MISSING_FILTER', array(
					'filter' => $Fp->Name,
					'file' => $ComponentContext->SourceFile,
					'line' => $ComponentContext->StartingLineNo));
				return $Value;
			}
			
            $FilterInfo->load();
			$filter_class = $FilterInfo->FilterClass;
			$Filter =& new $filter_class();

			if ( !is_null($Fp->Args) ) {

				$numArgs = count($Fp->Args);

				if ( $numArgs < $FilterInfo->MinParameterCount ) {
					RaiseError('compiler', 'MISSING_FILTER_PARAMETER', array(
						'filter' => $Fp->Name,
						'file' => $ComponentContext->SourceFile,
						'line' => $ComponentContext->StartingLineNo));
					return $Value;
				}

				if ($numArgs > $FilterInfo->MaxParameterCount) {
					RaiseError('compiler', 'TOO_MANY_PARAMETERS', array(
						'filter' => $Fp->Name,
						'file' => $ComponentContext->SourceFile,
						'line' => $ComponentContext->StartingLineNo));
					return $Value;
				}

				foreach ( $Fp->Args as $value_expr ) {

					$Filter->registerParameter($this->createValue($value_expr, $ComponentContext));

				}
			}

			$Filter->registerBase($Base);

			$Base = & $Filter;

		}

		return $Base;

	}

	
	function isConstant() {
  		return $this->filterChain->isConstant();
	}

	
	function getValue() {
		return $this->filterChain->getValue();
	}

	
	function generatePreStatement(&$code) {
		$this->filterChain->generatePreStatement($code);
	}

	
	function generateExpression(&$code) {
		$this->filterChain->generateExpression($code);
	}

	
	function generatePostStatement(&$code) {
		$this->filterChain->generatePostStatement($code);
	}

	
	function prepare() {
		return $this->filterChain->prepare();
	}

}


define ('EXPRESSION_VALUE_DATABINDING',0);
define ('EXPRESSION_VALUE_INT',1);
define ('EXPRESSION_VALUE_FLOAT',2);
define ('EXPRESSION_VALUE_STRING',3);

class ExpressionValueParser {
	
	var $ValueType = EXPRESSION_VALUE_DATABINDING;

	
	var $Value;

	
	function ExpressionValueParser($expression) {
		$Lexer = & ExpressionValueParser::getLexer();
		$Lexer->parse($expression);
	}

	
	function acceptDatabinding($expression,$state) {
		switch ( $state ) {
			case EXPRESSION_LEXER_UNMATCHED:
								$this->Value = $expression;
			break;
		}
		return TRUE;
	}

	
	function acceptInteger($int,$state) {
		switch ( $state ) {
			case EXPRESSION_LEXER_SPECIAL:
				$this->ValueType = EXPRESSION_VALUE_INT;
				$this->Value = intval($int);
			break;
		}

		return TRUE;
	}

	
	function acceptFloat($float,$state) {
		switch ( $state ) {
			case EXPRESSION_LEXER_SPECIAL:
				$this->ValueType = EXPRESSION_VALUE_FLOAT;
				if (!function_exists('floatval')) {
					require_once WACT_ROOT . 'util/phpcompat/floatval.php';
				}
				$this->Value = floatval($float);
			break;
		}
		return TRUE;
	}

	
	function acceptString($string,$state) {
		switch ( $state ) {
			case EXPRESSION_LEXER_SPECIAL:
				$this->ValueType = EXPRESSION_VALUE_STRING;

												$string = substr($string,1,strlen($string)-2);

				$this->Value = $string;
			break;
		}
		return TRUE;
	}

	
	function & getLexer() {
		$Lexer = new ExpressionLexer($this,'databinding');

		$Lexer->addSpecialPattern('^-?\d+$','databinding','integer');
		$Lexer->addSpecialPattern('^-?\d+\.\d+$','databinding','float');
		$Lexer->addSpecialPattern('^".*"$','databinding','doublequote');
		$Lexer->addSpecialPattern('^\'.*\'$','databinding','singlequote');

		$Lexer->mapHandler('databinding','acceptDatabinding');
		$Lexer->mapHandler('integer','acceptInteger');
		$Lexer->mapHandler('float','acceptFloat');
		$Lexer->mapHandler('doublequote','acceptString');
		$Lexer->mapHandler('singlequote','acceptString');

		return $Lexer;
	}
}


class ExpressionFilterFindingParser {

	
	var $Filters = array();

	
	var $filter = NULL;

	
	function ExpressionFilterFindingParser($expression) {
		$Lexer = & ExpressionFilterFindingParser::getLexer();
		$Lexer->parse($expression);

				if ( !is_null($this->filter) ) {
			$this->Filters[] = $this->filter;
		}
	}

	
	function acceptFilter($filter,$state) {
		switch ( $state ) {
			case EXPRESSION_LEXER_UNMATCHED:
				if ( is_null($this->filter) ) {
					$this->filter = $filter;
				} else {
					$this->filter .= $filter;
				}
			break;
			case EXPRESSION_LEXER_SPECIAL:
				if ( is_null($this->filter) ) {
					$this->filter = $filter;
				} else {
					$this->filter .= $filter;
				}
			break;
		}
		return TRUE;
	}

	
	function addFilter() {
		if ( !is_null ($this->filter) ) {
			$this->Filters[] = $this->filter;
			$this->filter = NULL;
		}
		return TRUE;
	}
	
	
	function & getLexer() {
		$Lexer = new ExpressionLexer($this,'filter');

		$Lexer->addSpecialPattern('\|','filter','add');
		$Lexer->addSpecialPattern('"[^"]*"','filter','doublequote');
		$Lexer->addSpecialPattern("'[^']*'",'filter','singlequote');

		$Lexer->mapHandler('filter','acceptFilter');
		$Lexer->mapHandler('doublequote','acceptFilter');
		$Lexer->mapHandler('singlequote','acceptFilter');
		$Lexer->mapHandler('add','addFilter');

		return $Lexer;
	}
}


class ExpressionFilterParser {

	
	var $Name = NULL;

	
	var $Args = NULL;

	
	var $arg = NULL;

	
	function ExpressionFilterParser($expression) {
		$Lexer = & ExpressionFilterParser::getLexer();
		$Lexer->parse($expression);

				if ( !is_null ($this->Args) && !is_null($this->arg) ) {
			$this->Args[] = $this->arg;
		}
	}

	
	function initArgs() {
		$this->Args = array();
		return TRUE;
	}

	
	function addArg() {
		if ( !is_null($this->Args) && !is_null($this->arg) ) {
			$this->Args[] = $this->arg;
			$this->arg = NULL;
		}
		return TRUE;
	}

	
	function accept($expression,$state) {

		switch ( $state ) {

			case EXPRESSION_LEXER_UNMATCHED:
				if ( !is_null($this->Args) ) {
					if ( is_null($this->arg) ) {
						$this->arg = $expression;
					} else {
						$this->arg .= $expression;
					}
				} else {
					if ( is_null($this->Name) ) {
						$this->Name = $expression;
					}
				}
			break;

			case EXPRESSION_LEXER_SPECIAL:
				if ( !is_null($this->Args) ) {
					if ( is_null($this->arg) ) {
						$this->arg = $expression;
					} else {
						$this->arg .= $expression;
					}
				}
			break;
		}

		return TRUE;
	}

	
	function & getLexer() {
		$Lexer = new ExpressionLexer($this,'value');

		$Lexer->addSpecialPattern(':','value','args');
		$Lexer->addSpecialPattern(',','value','arg');

		$Lexer->addSpecialPattern('"[^"]*"','value','doublequote');
		$Lexer->addSpecialPattern("'[^']*'",'value','singlequote');

		$Lexer->addPattern('\s','value');

		$Lexer->mapHandler('value','accept');
		$Lexer->mapHandler('args','initArgs');
		$Lexer->mapHandler('arg','addArg');
		$Lexer->mapHandler('doublequote','accept');
		$Lexer->mapHandler('singlequote','accept');


		return $Lexer;
	}

}
?>