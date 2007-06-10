<?php


$GLOBALS['DatabaseConnectionObjList'] = array();

class MDBC_ConnectionConfiguration {

    var $config_name;
    
    function MDBC_ConnectionConfiguration($config_name) {
        $this->config_name = $config_name;
    }

    function get($option) {
        return ConfigManager::getOption('db', $this->config_name, $option);
    }
}


class MDBC { 

    
    function &newConnection($name) {
        $ConnectionConfiguration =& new MDBC_ConnectionConfiguration($name);
        $driver = $ConnectionConfiguration->get("driver");
        $ConnectionClass = $driver . 'Connection'; 

        require_once(WACT_ROOT . 'db/drivers/' . $driver . '.inc.php'); 
        return new $ConnectionClass($ConnectionConfiguration);
    } 

    
    function &getConnection($name) {
        if (!isset($GLOBALS['DatabaseConnectionObjList'][$name])) {
            $GLOBALS['DatabaseConnectionObjList'][$name] =& MDBC::newConnection($name);
        }
        return $GLOBALS['DatabaseConnectionObjList'][$name];
    }
}

?>