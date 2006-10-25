<?php


if (!class_exists('DataSpace')) {
	require WACT_ROOT . 'util/dataspace.inc.php';
}


if ( !defined('ADODB_LIBRARY_PATH') ) {
    define('ADODB_LIBRARY_PATH', ConfigManager::getOptionAsPath('config', 'adodb', 'library_path'));
}
if (!@include_once ADODB_LIBRARY_PATH . 'adodb.inc.php') {
    RaiseError('runtime', 'LIBRARY_REQUIRED', array(
        'library' => 'ADOdb',
        'path' => ADODB_LIBRARY_PATH));
}


class AdodbConnection {
	
	var $ConnectionId;

	
	var $config;

	
	function AdodbConnection(&$config) {
	    $this->config =& $config;
	}

	
	function & getConnectionId() {
		if (!isset($this->ConnectionId)) {
			$this->connect();
		}
		return $this->ConnectionId;
	}

	
	function connect() {
		$this->ConnectionId = & ADONewConnection($this->config->get('dbtype'));
		$this->ConnectionId->SetFetchMode(ADODB_FETCH_NUM);
		$this->ConnectionId->Connect(
            $this->config->get('host'),
            $this->config->get('user'),
            $this->config->get('password'),
            $this->config->get('database'));
		if (!$this->ConnectionId) {
			$this->RaiseError();
		}
	}

	
	function RaiseError($sql = NULL) {
		$error = & $this->getConnectionId();
		$id = 'DB_ERROR';
		$info = array('driver' => 'ADOdb');
		$errno = $error->ErrorNo();
		if ($errno != -1) {
			$info['errorno'] = $errno;
			$info['error'] = $error->ErrorMsg();;
			$id .= '_MESSAGE';
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
                return $conn->qstr($value);
            case 'boolean':
                return ($value) ? 1 : 0;
            default:
                return strval($value);
		}
	}

    
    function &NewRecord($DataSpace = NULL) {
        $Record =& new AdodbRecord($this);
        if (!is_null($DataSpace)) {
            $Record->import($DataSpace->export());
        }
        return $Record;
    }

    
    function &NewRecordSet($query, $filter = NULL) {
        $RecordSet =& new AdodbRecordSet($this, $query);
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
		$Record =& new AdodbRecord($this);
		$QueryId = $this->_execute($query);
		$Record->properties =& $QueryId->fetchRow();
		$QueryId->Close();
		if (is_array($Record->properties)) {
			return $Record;
		}
	}

	
	function getOneValue($query) {
		$QueryId = $this->_execute($query);
		$row = $QueryId->fetchRow();
		$QueryId->Close();
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
		$QueryId->Close();
		return $Column;
	}

	
	function getTwoColumnArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row = $QueryId->fetchRow())) {
			$Column[$row[0]] = $row[1];
		}
		$QueryId->Close();
		return $Column;
	}

	
	function execute($sql) {
	    return (Boolean) $this->_execute($sql);
	}

	
	function _execute($sql) {
		$conn = & $this->getConnectionId();
		$result = & $conn->query($sql);
		if (!$result) {
			$this->RaiseError($sql);
		}
		return $result;
	}

	
	function disconnect() {
	    if (is_object($this->ConnectionId)) {
    		$this->ConnectionId->Close();
    		$this->ConnectionId = NULL;
        }
	}

}


class AdodbRecord extends DataSpace {
	
	var $Connection;

	
	function AdodbRecord(& $Connection) {
		$this->Connection = & $Connection;
		$conn = & $this->Connection->getConnectionId();
		$conn->SetFetchMode(ADODB_FETCH_ASSOC);
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
            $conn = & $this->Connection->getConnectionId();
            $insertId = $conn->Insert_ID();
            if ( $insertId ) {
                return $insertId;
            }
		} else {
		    return FALSE;
		}
	}

	
	function insert($table, $fields, $extrafields = NULL)  {
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
		return $QueryId->Affected_Rows();
	}

}


class AdodbRecordSet extends AdodbRecord {
	
	var $QueryId;

	
	var $pager;

	
	var $Query;

	
	var $first = TRUE;

	
	var $reentry = FALSE;

	
	function AdodbRecordSet($Connection, $Query_String) {
		$this->Connection = $Connection;
		$conn = & $this->Connection->getConnectionId();
		$conn->SetFetchMode(ADODB_FETCH_ASSOC);
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
			$this->QueryId->Close();
			$this->QueryId = NULL;
		}
	}

	
	function reset() {
		if (isset($this->QueryId) && is_resource($this->QueryId)) {
			if ($this->QueryId->move(0) === FALSE) {
				$this->Connection->RaiseError();
			}
		} else {
			$query = $this->Query;
			if (isset($this->pager)) {
				$conn = & $this->Connection->getConnectionId();
				$this->QueryId = $conn->SelectLimit($query,
					$this->pager->getItemsPerPage(),$this->pager->getStartingItem());
				if ( !$this->QueryId ) {
					$this->Connection->RaiseError($query);
				}
			} else {
				$this->QueryId = $this->Connection->_execute($query);
			}
			return TRUE;
		}
	}

	
	function next() {
		if (!isset($this->QueryId)) {
			return FALSE;
		}
		$this->properties = $this->QueryId->fetchRow();
		if (is_array($this->properties)) {
			$this->prepare();
			return TRUE;
		} else {
			$this->freeQuery();
			return FALSE;
		}
	}

	
	function getRowCount() {
		return $this->QueryId->RecordCount();
	}

	
	function getTotalRowCount() {
		if (!(preg_match("/^\s*SELECT\s+DISTINCT/is", $this->Query) && preg_match('/\s+GROUP\s+BY\s+/is',$this->Query))) {
			$rewritesql = preg_replace(
						'/^\s*SELECT\s.*\s+FROM\s/Uis','SELECT COUNT(*) FROM ',$this->Query);
			$rewritesql = preg_replace('/(\sORDER\s+BY\s.*)/is','',$rewritesql);
			$conn = & $this->Connection->getConnectionId();
			$conn->SetFetchMode(ADODB_FETCH_NUM);
			$QueryId = $this->Connection->_execute($rewritesql);
			$row = $QueryId->fetchRow();
			$QueryId->Close();
			if (is_array($row)) {
				return $row[0];
			}
		}

				$QueryId = $this->Connection->_execute($this->Query);
		$count = $QueryId->RecordCount();
		$QueryId->free();
		return $count;
	}
}
?>