<?php



interface Connection {

	
	function makeLiteral($value, $type = NULL);
	
    
    function &NewRecord($DataSpace = NULL);

    
    function &NewRecordSet($query, $filter = NULL);

    
    function &NewPagedRecordSet($query, &$pager, $filter = NULL);

	
	function &FindRecord($query);

	
	function getOneValue($query);

	
	function getOneColumnArray($query);

	
	function getTwoColumnArray($query);
	
	
	function execute($sql);

	
	function disconnect();

}

?>