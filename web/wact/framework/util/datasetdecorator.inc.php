<?php



class DataSpaceDecorator  {

	var $dataset;


	function DataSpaceDecorator(&$dataset) {
		$this->dataset =& $dataset;
	}

	function &get($name) {
		return $this->dataset->get($name);
	}

	function set($name, $value) {
		$this->dataset->set($name, $value);
	}

    function remove($name) {
        $this->dataset->remove($name);
    }

    function removeAll() {
        $this->dataset->removeAll();
    }

    function import($property_list) {
        $this->dataset->import($property_list);
    }

	function merge($property_list) {
		$this->dataset->merge($property_list);
	}

	function &export() {
		return $this->dataset->export();
	}

	function isDataSource() {
	    return TRUE;
	}

    function hasProperty($name) {
		return $this->dataset->hasProperty($name);
    }


	function registerFilter(&$filter) {
		$this->dataset->registerFilter($filter);
	}


	function prepare() {
		$this->dataset->prepare();
	}
}



class DataSetDecorator extends DataSpaceDecorator  {


	function DataSetDecorator(&$dataset) {
	    parent::DataSpaceDecorator($dataset);
	}

	function reset() {
		$this->dataset->reset();
	}

	function next() {
		return $this->dataset->next();
	}

}
?>