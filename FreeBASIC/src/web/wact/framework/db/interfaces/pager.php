<?php



interface Pager {

	
    function setPagedDataSet(PagedDataSet $DataSet);

	
    function getStartingItem();

	
    function getItemsPerPage();

}
?>