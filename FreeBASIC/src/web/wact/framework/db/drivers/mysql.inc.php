<?php



if (!class_exists('DataSpace')) {
	require WACT_ROOT . 'util/dataspace.inc.php';
}


class MySQLConnection
{
	var $ConnectionId;
	var $config;

	function MySQLConnection(&$config) {
	    $this->config =& $config;
	}


	function getConnectionId() {
		if (!isset($this->ConnectionId)) {
			$this->connect();
		}
		return $this->ConnectionId;
	}


	function connect() {
		$this->ConnectionId = mysql_connect(
		    $this->config->get('host'),
		    $this->config->get('user'),
		    $this->config->get('password'));
		if ($this->ConnectionId === FALSE) {
			$this->RaiseError();
		}

		if (mysql_select_db($this->config->get('database'), $this->ConnectionId) === FALSE) {
			$this->RaiseError();
		}
	}


	function RaiseError($sql = NULL) {
		$errno = mysql_errno($this->getConnectionId());
		$id = 'DB_ERROR';
		$info = array('driver' => 'MySQL');
		if ($errno != 0) {
			$info['errorno'] = $errno;
			$info['error'] = mysql_error($this->getConnectionId());
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
                return "'" . mysql_escape_string($value) . "'";
            case 'boolean':
                return ($value) ? 1 : 0;
            default:
                return strval($value);
		}
	}


    function &NewRecord($DataSpace = NULL) {
        $Record =& new MySqlRecord($this);
        if (!is_null($DataSpace)) {
            $Record->import($DataSpace->export());
        }
        return $Record;
    }


    function &NewRecordSet($query, $filter = NULL) {
        $RecordSet =& new MySqlRecordSet($this, $query);
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
		$Record =& new MySqlRecord($this);
		$QueryId = $this->_execute($query);
		$Record->properties =& mysql_fetch_assoc($QueryId);
		mysql_free_result($QueryId);
		if (is_array($Record->properties)) {
			return $Record;
		}
	}


	function getOneValue($query) {
		$QueryId = $this->_execute($query);
		$row = mysql_fetch_row($QueryId);
		mysql_free_result($QueryId);
		if (is_array($row)) {
			return $row[0];
		}
	}


	function &getOneColumnArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row =& mysql_fetch_row($QueryId))) {
			$Column[] = $row[0];
		}
		mysql_free_result($QueryId);
		return $Column;
	}


	function &getTwoColumnArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row =& mysql_fetch_row($QueryId))) {
			$Column[$row[0]] = $row[1];
		}
		mysql_free_result($QueryId);
		return $Column;
	}

	function &getRowArray($query) {
		$Column = array();
		$QueryId = $this->_execute($query);
		while (is_array($row =& mysql_fetch_assoc($QueryId))) {
			$Column[] = $row;
		}
		mysql_free_result($QueryId);
		return $Column;
	}

	function execute($sql) {
	    return (Boolean) $this->_execute($sql);
	}


	function _execute($sql) {
		$result = mysql_query($sql, $this->getConnectionId());

		if ($result === FALSE) {
			$this->RaiseError($sql);
		}
		return $result;
	}


	function disconnect() {
		mysql_close($this->ConnectionId);
		$this->ConnectionId = NULL;
	}

}


class MySqlRecord extends DataSpace
{
	var $Connection;

	function MySqlRecord(&$Connection) {
		$this->Connection =& $Connection;
	}


	function buildAssignmentSQL(&$fields, $extrafields) {
		$query = ' SET ';
		$sep = '';

		foreach($fields as $fieldname => $type) {
			if (!is_string($fieldname)) {
				$fieldname = $type;
				$type = NULL;
			}
			$query .= $sep . $fieldname . '=' .
			$this->Connection->makeLiteral($this->get($fieldname), $type);
			$sep = ', ';
		}

		if (!is_null($extrafields)) {
			foreach($extrafields as $fieldname => $value) {
				$query .= $sep . $fieldname . '=' . $value;
				$sep = ', ';
			}
		}

		return $query;
	}


	function insertId($table, &$fields, $primary_key_field, $extrafields = NULL) {
		$query = 'INSERT INTO ' . $table . $this->buildAssignmentSQL($fields, $extrafields);
		$result = $this->Connection->execute($query);
		if ($result) {
			return mysql_insert_id($this->Connection->getConnectionId());
		} else {
		    return FALSE;
		}
	}


	function insert($table, &$fields, $extrafields = NULL) {
		$query = 'INSERT INTO ' . $table . $this->buildAssignmentSQL($fields, $extrafields);
		return (Boolean) $this->Connection->execute($query);
	}


	function update($table, &$fields, $where = NULL, $extrafields = NULL) {

		$query = 'UPDATE ' . $table . $this->buildAssignmentSQL($fields, $extrafields, 'update');

		if (!is_null($where)) {
			$query .= ' WHERE ' . $where;
		}

		return (Boolean) $this->Connection->execute($query);
	}


	function getAffectedRowCount() {
		return mysql_affected_rows($this->Connection->getConnectionId());
	}
}


class MySqlRecordSet  extends MySqlRecord
{
	var $QueryId;
	var $pager;
	var $Query;


	function MySqlRecordSet(&$Connection, $Query_String) {
		$this->Connection =& $Connection;
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
		if (isset($this->QueryId) && is_resource($this->QueryId)) {
			mysql_free_result($this->QueryId);
			$this->QueryId = NULL;
		}
	}


	function reset() {
		if (isset($this->QueryId) && is_resource($this->QueryId)) {
			if (mysql_data_seek($this->QueryId, 0) === FALSE) {
				$this->Connection->RaiseError();
			}
		} else {
			$query = $this->Query;
			if (isset($this->pager)) {
				$query .= ' LIMIT ' .
					$this->pager->getStartingItem() . ',' .
					$this->pager->getItemsPerPage();
			}

			$this->QueryId = $this->Connection->_execute($query);
		}
    	return TRUE;
	}


	function next() {
		if (!isset($this->QueryId)) {
			return FALSE;
		}

		$this->properties =& mysql_fetch_assoc($this->QueryId);

		if (is_array($this->properties)) {
			$this->prepare();
			return TRUE;
		} else {
			$this->freeQuery();
			return FALSE;
		}
	}


	function getRowCount() {
		return mysql_num_rows($this->QueryId);
	}


	function getTotalRowCount() {
		if (!(preg_match("/^\s*SELECT\s+DISTINCT/is", $this->Query) && preg_match('/\s+GROUP\s+BY\s+/is',$this->Query))) {
			$rewritesql = preg_replace(
						'/^\s*SELECT\s.*\s+FROM\s/Uis','SELECT COUNT(*) FROM ',$this->Query);
			$rewritesql = preg_replace('/(\sORDER\s+BY\s.*)/is','',$rewritesql);

			$QueryId = $this->Connection->_execute($rewritesql);
			$row = mysql_fetch_row($QueryId);
			mysql_free_result($QueryId);
			if (is_array($row)) {
				return $row[0];
			}
		}


		$QueryId = $this->Connection->_execute($this->Query);
		$count = mysql_num_rows($QueryId);
		mysql_free_result($QueryId);
		return $count;
	}
}
?>
