<?php



interface Record extends DataSpace {

	
	function insert($table, $fields, $extrafields = NULL);

	
	function insertId($table, $fields, $primary_key_field, $extrafields = NULL);
	
	
	function update($table, $fields, $where = NULL, $extrafields = NULL);

	
	function getAffectedRowCount();

}

?>