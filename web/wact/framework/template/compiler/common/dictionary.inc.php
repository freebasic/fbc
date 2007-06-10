<?php


require_once WACT_ROOT . 'template/template.inc.php';


class CompilerArtifactDictionary {
	
    var $SearchPath;
    
    function CompilerArtifactDictionary() {
        $this->SearchPath = ConfigManager::getOptionAsPath('compiler', 'tags', 'path');
    }    

    function scanDirectory($scandir, $extension) {
        $size = strlen($extension);
        if (is_dir($scandir)) {
            if ($dir = opendir($scandir)) {
                while (($file = readdir($dir)) !== FALSE) {
                    if (substr($file, -$size, $size) == $extension) {
                        require_once $scandir . '/' . $file;
                    }
                }
                closedir($dir);
            }
        }
    
    }

	function buildDictionary($extension) {
        foreach (explode(';', $this->SearchPath) as $tagpath) {
            $this->scanDirectory($tagpath, $extension);
        }
	}

	function &_getInstance($instance, $dictionaryClass, $type) {
	    if (!isset($GLOBALS[$instance])) {
    		$cachefile = ResolveTemplateCompiledFileName('/' . $type . '.cache', TMPL_INCLUDE);
    		
			if (!ConfigManager::getOption('compiler', 'dictionary', 'forcescan')) {
                if (file_exists($cachefile)) {
                    $GLOBALS[$instance] =& unserialize(readTemplateFile($cachefile));
                }
    		}
    		
    		if (!isset($GLOBALS[$instance]) || !is_object($GLOBALS[$instance])) {
                $GLOBALS[$instance] =& new $dictionaryClass();
                $GLOBALS[$instance]->buildDictionary('.' . $type . '.php');

                $destfile = ResolveTemplateCompiledFileName('/' . $type . '.cache', TMPL_INCLUDE);
                writeTemplateFile($destfile, serialize($GLOBALS[$instance]));
            }
        }
  		return $GLOBALS[$instance];
	}

}
?>