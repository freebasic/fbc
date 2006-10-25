<?php
require '../../wact/framework/common.inc.php';
define('TMPL_FILESCHEME_PATH', WACT_ROOT . 'template/fileschemes/multilang/');
setlocale(LC_ALL, 'en_US');
$GLOBALS['CurrentLanguage'] = 'EN';

require WACT_ROOT . 'template/template.inc.php';
require WACT_ROOT . 'template/compiler/compileall.inc.php';

echo 'Compiling all templates...';
CompileAll();
echo 'Done.';
?>
