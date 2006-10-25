<?php


if (!class_exists('DataSpace')) {
	require WACT_ROOT . 'util/dataspace.inc.php';
}


if ( !defined('PEAR_LIBRARY_PATH') ) {
    define('PEAR_LIBRARY_PATH', ConfigManager::getOptionAsPath('config', 'pear', 'library_path'));
}
if (!@include_once PEAR_LIBRARY_PATH . 'DB.php') {
    RaiseError('runtime', 'LIBRARY_REQUIRED', array(
        'library' => 'PEAR::DB',
        'path' => PEAR_LIBRARY_PATH));
}


class PearConnection {
	
	var $ConnectionId;

	
	var $config;

	
	function PearConnection(&$config) {
	    $this->config =& $config;
	}

	
	function &getConnectionId() {
		if (!isset($this->ConnectionId)) {
			$this->connect();
		}
		return $this->ConnectionId;
	}

	
	function connect() {
	    $dsn = $this->config->get('dbtype') . "://";

	    $user = $this->config->get('user');
	    if ($user) {
	        $dsn .= $user;
    	    $password = $this->config->get('password');
    	    if ($password) {
    	        $dsn .= ":" . $password;
    	    }
	    }
	    $host = $this->config->get('host');
	    if ($host) {
  	        $dsn .= "@" . $host;
	    }
	    $database = $this->config->get('database');
	    if ($database) {
  	        $dsn .= "/" . $database;
	    }
		$this->ConnectionId = DB::connect($dsn);
		if (DB::isError($this->ConnectionId)) {
			$this->RaiseError();
		}
	}

	
	function RaiseError($sql = NULL) {
		$error = & $this->getConnectionId();
		$id = 'DB_ERROR';
		$info = array('driver' => 'Pear');
		if ( DB::isError($error) ) {
			$errno = $error->getCode();
			if ($errno != -1) {
				$info['errorno'] = $errno;
				$info['error'] = $error->getMessage();
				$id .= '_MESSAGE';
			}
		}
		if (!is_null($sql)) {
			$info['sql'] = $sql;
			$id .= '_SQL';
		}
		RaiseError('db', $id, $info);
	}

	
	function makeLiteral($value, $type = NULL) {
        if (is_null($value)) {
            return 'NULL';
        }
		if (is_null($type)) {
			$type = gettype($value);
		}
		switch (strtolower($type)) {
            case 'string':
                $conn = & $this->getConnectionId();
                return $conn->quoteSmart($value);
            case 'boolean':
                return ($value) ? 1 : 0;
            default:
                return strval($value);
		}
	}

    
    function &NewRecord($DataSpace = NULL) {
        $Record =& new PearRecord($this);
        if (!is_null($DataSpace)) {
            $Record->import($DataSpace->export());
        }
        return $Record;
    }

    
    function &NewRecordSet($query, $filter = NULL) {
        $RecordSet =& new PearRecordSet($this, $query);
        if (!is_null($filter)) {
            $RecordSet->registerFilter($filter);
        }
        return $RecordSet;
    }

    
    function &NewPagedRecordSet($query, &$pager, $filter = NULL) {
        $RecordSet =& $this->NewRecordSet($query, $filter);
        $RecordSet->paginate($pager);
        return $RecordSet;
    }

	
	function &FindRecord($query) {
		$Record =& new PearRecord($this);
		$QueryId = $this->_execute($query);
		$Record->properties =& $QueryId->fetchRow(DB_FETCHMODE_ASSOC);
		$QueryId->free();
		if (is_array($Record->properties)) {
			return $Record;
		}
	}

	
	function getOneValue($query) {
		$QueryId = $this->_execute($query);
		$row = $QueryId->fetchRow();
		$QueryId->free();
		if (is_array($row)) {
			return $row[0];
		}
	}

	
	function getOneColumnArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row = $QueryId->fetchRow())) {
			$Column[] = $row[0];
		}
		$QueryId->free();
		return $Column;
	}

	
	function getTwoColumnArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row = $QueryId->fetchRow())) {
			$Column[$row[0]] = $row[1];
		}
		$QueryId->free();
		return $Column;
	}

	
	function execute($sql) {
	    return (Boolean) $this->_execute($sql);
	}

	
	function _execute($sql) {
		$conn = & $this->getConnectionId();
		$result = & $conn->query($sql);
		if (DB::isError($result)) {
			$this->RaiseError($sql);
		}
		return $result;
	}

	
	function disconnect() {
	    if (is_object($this->ConnectionId)) {
    		$this->ConnectionId->disconnect();
    		$this->ConnectionId = NULL;
        }
	}

}


class PearRecord extends DataSpace {
	
	var $Connection;

	
	function PearRecord(& $Connection) {
		$this->Connection = & $Connection;
	}

	
	function buildAssignmentList($fields, $extrafields) {
		$queryParams = array();
		foreach ($fields as $fieldname => $type) {
			if (!is_string($fieldname)) {
				$fieldname = $type; 				$type = NULL;
			}
			$queryParams[$fieldname] = $this->Connection->makeLiteral(
			    $this->get($fieldname), $type
            );
		}
		if (!is_null($extrafields)) {
			foreach ($extrafields as $fieldname => $value) {
				$queryParams[$fieldname] = $value;
			}
		}
		return $queryParams;
	}

	
	function insertId($table, $fields, $primary_key_field, $extrafields = NULL) {
        $valueList = $this->buildAssignmentList($fields, $extrafields);
		$query = 'INSERT INTO ' . $table .
		    ' (' . implode(',', array_keys($valueList)) .') VALUES' .
		    ' (' . implode(',', $valueList) . ')';
		$result = $this->Connection->execute($query);
		if ($result) {
		    $valueList = $this->buildAssignmentList($fields, null);
		    $pairs = array();
		    foreach ($valueList as $key => $value) {
                $pairs[] = $key .'='. $value;
            }
		    $query = 'SELECT MAX('.$primary_key_field.') FROM ' . $table .
		            ' WHERE (' . implode(' AND ', $pairs) . ')';
		    $result = (int)$this->Connection->getOneValue($query);
		}
		return $result;
	}


	
	function insert($table, $fields, $extrafields = NULL) {
        $valueList = $this->buildAssignmentList($fields, $extrafields);
		$query = 'INSERT INTO ' . $table .
		    ' (' . implode(',', array_keys($valueList)) .') VALUES' .
		    ' (' . implode(',', $valueList) . ')';
		return (Boolean) $this->Connection->execute($query);
	}

	
	function update($table, $fields, $where = NULL, $extrafields = NULL) {
        $valueList = $this->buildAssignmentList($fields, $extrafields);
		$query = 'UPDATE ' . $table . ' SET ';
        $sep = '';
        foreach ($valueList as $key => $value) {
            $query .= $sep . $key .'='. $value;
            $sep = ', ';
        }
		if (!is_null($where)) {
			$query .= ' WHERE ' . $where;
		}
		return (Boolean) $this->Connection->execute($query);
	}

	
	function getAffectedRowCount() {
		$QueryId = & $this->Connection->getConnectionId();
		return $QueryId->affectedRows();
	}

}


class PearRecordSet extends PearRecord {
	
	var $QueryId;

	
	var $pager;

	
	var $Query;

	
	var $first = TRUE;

	
	var $reentry = FALSE;

	
	function PearRecordSet($Connection, $Query_String) {
		$this->Connection = $Connection;
		$this->Query = $Query_String;
	}

	
	function query($Query_String) {
		$this->freeQuery();
		$this->Query = $Query_String;
	}

	
	function paginate(&$pager) {
		$this->pager =& $pager;
		$pager->setPagedDataSet($this);
	}

	
	function freeQuery() {
		if (isset($this->QueryId) && is_object($this->QueryId)) {
			$this->QueryId->free();
			$this->QueryId = NULL;
		}
	}

	
	function reset() {
		$query = $this->Query;
		if (isset($this->pager)) {
			$conn = & $this->Connection->getConnectionId();
			$query = $conn->modifyLimitQuery($query,
				$this->pager->getStartingItem(),$this->pager->getItemsPerPage());
		}
		$this->QueryId = $this->Connection->_execute($query);
		return TRUE;
	}

	
	function next() {
		if (!isset($this->QueryId)) {
			return FALSE;
		}
		$this->properties = $this->QueryId->fetchRow(DB_FETCHMODE_ASSOC);
		if (is_array($this->properties)) {
			$this->prepare();
			return TRUE;
		} else {
			$this->freeQuery();
			return FALSE;
		}
	}

	
	function getRowCount() {
		return $this->QueryId->numRows();
	}

	
	function getTotalRowCount() {
		if (!(preg_match("/^\s*SELECT\s+DISTINCT/is", $this->Query) && preg_match('/\s+GROUP\s+BY\s+/is',$this->Query))) {
			$rewritesql = preg_replace(
						'/^\s*SELECT\s.*\s+FROM\s/Uis','SELECT COUNT(*) FROM ',$this->Query);
			$rewritesql = preg_replace('/(\sORDER\s+BY\s.*)/is','',$rewritesql);
			$QueryId = $this->Connection->_execute($rewritesql);
			$row = $QueryId->fetchRow();
			$QueryId->free();
			if (is_array($row)) {
				return $row[0];
			}
		}

				$QueryId = $this->Connection->_execute($this->Query);
		$count = $QueryId->numRows();
		$QueryId->free();
		return $count;
	}
}
?>