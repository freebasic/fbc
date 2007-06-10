<?php



require_once WACT_ROOT . 'template/compiler/tagdictionary.inc.php';

require_once WACT_ROOT . 'template/compiler/property/dictionary.inc.php';
require_once WACT_ROOT . 'template/compiler/property/property.inc.php';
require_once WACT_ROOT . 'template/compiler/property/constant.inc.php';

require_once WACT_ROOT . 'template/compiler/filter/dictionary.inc.php';
require_once WACT_ROOT . 'template/compiler/filter/filter.inc.php';

require_once WACT_ROOT . 'template/compiler/compilercomponent.inc.php';
require_once WACT_ROOT . 'template/compiler/compilerdirective.inc.php';
require_once WACT_ROOT . 'template/compiler/silentcompilerdirective.inc.php';
require_once WACT_ROOT . 'template/compiler/servercomponent.inc.php';
require_once WACT_ROOT . 'template/compiler/servertagcomponent.inc.php';
require_once WACT_ROOT . 'template/compiler/serverdatacomponent.inc.php';
require_once WACT_ROOT . 'template/compiler/textnode.inc.php';
require_once WACT_ROOT . 'template/compiler/attributenode.inc.php';
require_once WACT_ROOT . 'template/compiler/componenttree.inc.php';

require_once WACT_ROOT . 'template/compiler/outputexpression.inc.php';

require_once WACT_ROOT . 'template/compiler/sourcefileparser.inc.php';
require_once WACT_ROOT . 'template/compiler/codewriter.inc.php';

require_once WACT_ROOT . 'template/compiler/databinding.inc.php';
require_once WACT_ROOT . 'template/compiler/expression.inc.php';

require_once TMPL_FILESCHEME_PATH . '/compilersupport.inc.php';

define('WACT_TAG_ROOT', WACT_ROOT . 'template/tags/');


TagDictionary::getInstance();
PropertyDictionary::getInstance();
FilterDictionary::getInstance();


function getNewServerId() {
	static $ServerIdCounter = 1;
	return 'id00' . $ServerIdCounter++;
}


function CompileTemplateFile($filename) {
	$destfile = ResolveTemplateCompiledFileName($filename, TMPL_INCLUDE);
	$sourcefile = ResolveTemplateSourceFileName($filename, TMPL_INCLUDE);
	if (empty($sourcefile)) {
        RaiseError('compiler', 'MISSINGFILE2', array(
            'srcfile' => $filename));
	}

	$code =& new CodeWriter();
	$code->setFunctionPrefix(md5($destfile));

	$Tree =& GetComponentTree(TRUE);
	$Tree->SourceFile = $sourcefile;

	$sfp =& new SourceFileParser($sourcefile);
	$sfp->parse($Tree);

	$Tree->prepare();

	$renderfunc = $code->beginFunction('(&$root)');
	$Tree->generate($code);
	$code->endFunction();

	$constructfunc = $code->beginFunction('(&$root)');
	$Tree->generateConstructor($code);
	$code->endFunction();

	$code->writePHP('$GLOBALS[\'TemplateRender\'][$this->codefile] = \'' . $renderfunc . '\';');
	$code->writePHP('$GLOBALS[\'TemplateConstruct\'][$this->codefile] = \'' . $constructfunc . '\';');

	writeTemplateFile($destfile, $code->getCode());

}


function & GetComponentTree($newInstance = FALSE) {
	static $Tree = NULL;
	if ( $newInstance || is_null($Tree) ) {
		$Tree = new ComponentTree();
	}
	return $Tree;
}

?>