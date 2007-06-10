<?php


require_once TMPL_FILESCHEME_PATH . 'compilersupport.inc.php';


function parseVarFile($filename) {

	$Result = array();

	$RawLines = preg_split("/\r?\n|\r/", readTemplateFile($filename));

	while (list(,$Line) = each($RawLines)) {
	    if (empty($Line)) {
	        continue;
	    }
		$EqualPos = strpos($Line, '=');
		if ($EqualPos === FALSE) {
			$Result[trim($Line)] = NULL;
		} else {
			$Key = trim(substr($Line, 0, $EqualPos));
			if (strlen($Key) > 0) {
				$Result[$Key] = trim(substr($Line, $EqualPos+1));
			}
		}
	}
	return $Result;
}


function CompileVarFile($filename) {

	$destfile = ResolveTemplateCompiledFileName($filename, TMPL_IMPORT);
	$sourcefile = ResolveTemplateSourceFileName($filename, TMPL_IMPORT);
	if (empty($sourcefile)) {
        RaiseError('compiler', 'MISSINGFILE2', array(
            'srcfile' => $filename));
	}

	$text = serialize(parseVarFile($sourcefile));

	writeTemplateFile($destfile, $text);
}
?>