<?php


require_once WACT_ROOT . 'util/filewrite.inc.php';

//:::::
function GetTemplatesRootPath( $isrel )
{
	$root = (ConfigManager::getOptionAsPath( 'config', 'filescheme', 'templateroot' ));

    if(isset($root))
    	return $root . '/source';
    else
    	$root = WACT_MAIN_DIR;

	if( $isrel )
	{
		$p = strrpos( $root, '/' );
		if( $p === false )
			$p = strrpos( $root, '\\' );

		$root = '/' . substr( $root, $p +1 );
	}

    return $root . '/templates/source';
}

//:::::
function GetLanguagePath( )
{
	return GetTemplatesRootPath( FALSE ) . '/lang/' . $GLOBALS['CurrentLanguage'];
}

//:::::
function GetTemplatesPath( )
{
	return GetTemplatesRootPath( TRUE ) . '/templates';
}

//:::::
function ResolveTemplateSourceFileName($file, $operation = TMPL_INCLUDE, $context = NULL) {

    if (gettype(strpos($file, "..")) == "integer" || gettype(strpos($file, "//")) == "integer") {
        return NULL;     }

    if (substr($file, 0, 1) == '/') {
        $root = (ConfigManager::getOptionAsPath('config', 'filescheme', 'templateroot'));
        if (isset($root)) {
            $fileroot = $root . '/source';
        } else {
            $fileroot = WACT_MAIN_DIR . '/templates/source';
        }

        switch ($operation) {
            case TMPL_INCLUDE:
                $filename = $fileroot . '/templates' . $file;
                break;
            case TMPL_IMPORT:
                $filename = $fileroot . '/lang/' . $GLOBALS['CurrentLanguage'] . $file;
                break;
            default:
                return NULL;         }

        if (!file_exists($filename)) {
           	$filename = WACT_ROOT . 'default' . $file;
        }

    } else {
        if (!is_null($context)) {
            $filename = dirname($context) . '/' . $file;
        } else {
            return NULL;         }
    }

   	if (!file_exists($filename)) {
       	return NULL;     }

    return $filename;
}

function _RecursiveCompileAll($Root, $Path) {
    if ($dh = opendir($Root . $Path)) {
        while (($file = readdir($dh)) !== FALSE) {
            if (substr($file, 0, 1) == '.') {
                continue;
            }
            if (is_dir($Root . $Path . $file)) {
                _RecursiveCompileAll($Root, $Path . $file . '/');
                continue;
            }
            if (substr($file, -5, 5) == '.html') {
                CompileTemplateFile($Path . $file);
            } else if (substr($file, -5, 5) == '.vars') {
                CompileVarFile($Path . $file);
            }
        }
        closedir($dh);
    }
}


function writeTemplateFile($file, $data) {
    WriteFile($file, $data);
}


function CompileEntireFileScheme() {

    $root = (ConfigManager::getOptionAsPath('config', 'filescheme', 'templateroot'));
    if (isset($root)) {
        $SourceRoot = $root . '/source';
    } else {
        $SourceRoot = WACT_MAIN_DIR . '/templates/source';
    }

    if ($dh = opendir($SourceRoot . '/lang')) {
        while (($file = readdir($dh)) !== FALSE) {
            if (substr($file, 0, 1) == '.') {
                continue;
            }
            if (is_dir($SourceRoot . '/lang/' . $file) && $file != 'CVS') {
                $GLOBALS['CurrentLanguage'] = $file;

                _RecursiveCompileAll($SourceRoot . '/templates', '/');
                _RecursiveCompileAll($SourceRoot . '/lang/' . $file, '/');
                _RecursiveCompileAll(WACT_ROOT . 'default', '/');

            }
        }
        closedir($dh);
    }

}
?>