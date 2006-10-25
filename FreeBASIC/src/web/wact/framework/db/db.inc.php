<?php


$GLOBALS['DatabaseConnectionObj'] = NULL;


class DBC_ConnectionConfiguration {

    var $driver_name;

    function DBC_ConnectionConfiguration($driver_name) {
        $this->driver_name = $driver_name;
    }

    function get($option) {
        return ConfigManager::getOption('config', 'database', $this->driver_name . '.' . $option);
    }
}


class DBC {


    function &getCurrentConnection() {
        if (!isset($GLOBALS['DatabaseConnectionObj'])) {
            $driver = ConfigManager::getOption('config', 'database', 'driver');
            require_once(WACT_ROOT . 'db/drivers/' . $driver . '.inc.php');
            $driverClass = $driver . 'Connection';
            $GLOBALS['DatabaseConnectionObj'] =&
                new $driverClass(new DBC_ConnectionConfiguration($driver));
        }
        return $GLOBALS['DatabaseConnectionObj'];
    }


    function &NewRecord($DataSpace = NULL) {
        $connection =& DBC::getCurrentConnection();
        return $connection->NewRecord($DataSpace);
    }


    function &NewRecordSet($query, $filter = NULL) {
        $connection =& DBC::getCurrentConnection();
        return $connection->NewRecordSet($query, $filter);
    }


    function &NewPagedRecordSet($query, &$pager, $filter = NULL) {
        $connection =& DBC::getCurrentConnection();
        return $connection->NewPagedRecordSet($query, $pager, $filter);
    }


    function &getOneColumnArray($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->getOneColumnArray($query);
    }


    function &getTwoColumnArray($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->getTwoColumnArray($query);
    }

    function &getRowArray($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->getRowArray($query);
    }

    function &FindRecord($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->FindRecord($query);
    }


    function getOneValue($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->getOneValue($query);
    }


    function execute($query) {
        $connection =& DBC::getCurrentConnection();
        return $connection->execute($query);
    }


    function makeLiteral($value, $type = NULL) {
        $connection =& DBC::getCurrentConnection();
        return $connection->makeLiteral($value, $type);
    }
}

?>