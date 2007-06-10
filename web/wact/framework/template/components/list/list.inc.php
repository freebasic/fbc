<?php


class ListComponent extends DataSourceComponent {

    function ensureDataSourceAvailable() {
		if (!isset($this->_datasource)) {
			require_once WACT_ROOT . 'util/emptydataset.inc.php';
			$this->registerDataSource(new EmptyDataSet());
		}
    }

	
	function registerDataSet(&$DataSet) {
		$this->registerDataSource($DataSet);
	}

	
	function prepare() {
        $this->ensureDataSourceAvailable();
        $this->_datasource->reset();
	}
}
?>