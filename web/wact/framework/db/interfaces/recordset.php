<?php



interface RecordSet extends iterator, record {

	
	function query($Query_String);

	
	function paginate(Pager $pager);

	
	function reset();

	
	function next();

	
	function getRowCount();

	
	function getTotalRowCount();
}
?>