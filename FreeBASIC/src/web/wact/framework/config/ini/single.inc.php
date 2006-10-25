<?php



$GLOBALS['ConfigurationSettings'] = array();

class ConfigManager {

    function loadConfigFile($file) {
        $configvalues = NULL;
        if (defined('WACT_CONFIG_DIRECTORY')) {
            $inifile = WACT_CONFIG_DIRECTORY . '/' . $file . '.ini';
            if ( file_exists($inifile) ) {
                $configvalues = parse_ini_file($inifile, TRUE);
            }
        }
        if (!is_array($configvalues)) {
            $inifile = WACT_MAIN_DIR . '/' . $file . '.ini';
            if ( file_exists($inifile) ) {
                $configvalues = parse_ini_file($inifile, TRUE);
            }
        }
        if (!is_array($configvalues)) {
            $inifile = WACT_ROOT . $file . '.ini';
            if ( file_exists($inifile) ) {
                $configvalues = parse_ini_file($inifile, TRUE);
            }
        }
        if (!is_array($configvalues)) {
            RaiseError('compiler', 'CONFIGFILENOTFOUND', array(
                'file' => $file));
        }
        $GLOBALS['ConfigurationSettings'][$file] = $configvalues;
    }
    
    
    function getOption($module, $section, $key) {
        if (!isset($GLOBALS['ConfigurationSettings'][$module])) {
            ConfigManager::loadConfigFile($module);
        }
        if (isset($GLOBALS['ConfigurationSettings'][$module][$section][$key])) {
            return $GLOBALS['ConfigurationSettings'][$module][$section][$key];
        } else {
            return NULL;
        }
    }

    function getOptionAsPath($module, $section, $key) {
    
		$path = ConfigManager::getOption($module, $section, $key);
		if (!is_null($path)) {
			$constPos = strpos($path, '%');
			while (is_integer($constPos)) {
				$constant = substr($path, $constPos+1, strpos($path, '%', $constPos+1)-$constPos-1);
				if (defined($constant)) {
					$path = str_replace("%$constant%", constant($constant), $path);
				} else {
					RaiseError('compiler', 'CONFIGFILECONSTANTNOTFOUND', array('constant' => $constant, 'module' => $module, 'section' => $section, 'key' => $key));
				}
				$constPos = strpos($path, '%');
			}
		}
		return $path;
    }
    
    function getSection($module, $section) {
        if (!isset($GLOBALS['ConfigurationSettings'][$module])) {
            ConfigManager::loadConfigFile($module);
        }
        if (isset($GLOBALS['ConfigurationSettings'][$module][$section])) {
            return $GLOBALS['ConfigurationSettings'][$module][$section];
        } else {
            return NULL;
        }
    }
    
}


?>