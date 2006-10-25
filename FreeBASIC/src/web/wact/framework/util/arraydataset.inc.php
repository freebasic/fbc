<?php


class ArrayDataSet {

    var $dataset;
    var $row;
    var $row_copy;
    var $filter;
    var $filtered;
    var $first;


    function ArrayDataSet(&$array) {
        $this->importDataSetAsArray($array);
        $this->row = array();
        $this->filtered = FALSE;
        $this->first = TRUE;
    }


    function isEmpty() {
        return empty($this->row);
    }


    function importDataSetAsArray(&$dataset) {
        $this->dataset = $dataset;
        $this->reset();
    }


    function &exportDataSetAsArray() {
        return $this->dataset;
    }


    function &getDataSet() {
        return $this->exportDataSetAsArray();
    }



    function &get($name) {
        if (isset($this->row[$name])) {
            return $this->row[$name];
        }
    }


    function set($name, $value) {
        $this->row[$name] = $value;
    }

    function remove($name) {
        unset($this->row[$name]);
    }

    function removeAll() {
        $this->row = array();
    }


    function import(&$array) {
        if (is_array($array)) {
            $this->row = $array;
        }
    }


    function merge($array) {
        $this->row = array_merge($this->row, $array);
    }


    function &export() {
        return $this->row;
    }

    function isDataSource() {
        return TRUE;
    }

    function hasProperty($name) {
        return isset($this->row[$name]);
    }

    function getPropertyList() {
        return array_keys($this->row);
    }


    function registerFilter(&$filter) {
        $this->filter =& $filter;
    }


    function prepare() {
        if (isset($this->filter) &&
            method_exists($this->filter, 'doFilter')) {
            if ($this->filtered) {
                $this->row = $this->row_copy;
            } else {
                $this->row_copy = $this->row;
            }
            $this->filter->doFilter($this->row);
            $this->filtered = TRUE;
        }
    }



    function reset() {
        reset($this->dataset);
        $this->first = TRUE;
    }


    function next() {
        $this->filtered = FALSE;
        if ($this->first) {
            $dataspace = current($this->dataset);
            $this->first = FALSE;
        } else {
            $dataspace = next($this->dataset);
        }

        $this->row = (bool) $dataspace ? $dataspace : array();
        if ((bool) $dataspace) {
            $this->prepare();
        }
        return (bool) $dataspace;
    }

}
?>
