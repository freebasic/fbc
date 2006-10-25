<?php



interface PagedDataSet extends iterator {

	
	function getRowCount();

	
	function getTotalRowCount();
}
?>