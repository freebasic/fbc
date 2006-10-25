<?php


require_once WACT_ROOT . 'template/compiler/templatecompiler.inc.php';
require_once WACT_ROOT . 'template/compiler/varfilecompiler.inc.php';
require_once TMPL_FILESCHEME_PATH . 'compilersupport.inc.php';

if ( !defined('WACT_ERROR_CONTINUE') ) {
	define ('WACT_ERROR_CONTINUE',1);
}

function CompileAll() {
	CompileEntireFileScheme();
}
?>