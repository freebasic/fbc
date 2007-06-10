<?php



function ResolveTemplateCompiledFileName($file, $operation = TMPL_INCLUDE) {

	if (gettype(strpos($file, "..")) == "integer" || gettype(strpos($file, "//")) == "integer") {
        RaiseError('compiler', 'INVALIDFILENAME', array(
            'file' => $file));
	}

	if (substr($file, 0, 1) == '/') {
	    $root = (ConfigManager::getOptionAsPath('config', 'filescheme', 'templateroot'));
		if (isset($root)) {
			$FileRoot = $root . '/compiled';
		} else {
			$FileRoot = WACT_MAIN_DIR . '/templates/compiled';
		}
		return $FileRoot . '/' . $GLOBALS['CurrentLanguage'] . $file;
	} else {
        RaiseError('compiler', 'RELATIVEPATH', array(
            'file' => $file));
	}
}


function readTemplateFile($file) {
	if (!function_exists('file_get_contents')) {
        require_once WACT_ROOT . 'util/phpcompat/file_get_contents.php';
    }
	return file_get_contents($file);
}
?>