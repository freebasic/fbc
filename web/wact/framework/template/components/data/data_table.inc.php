<?php

require_once WACT_ROOT . 'template/components/list/list.inc.php';


class DataTableComponent extends ListComponent {

    
    function prepare() {
        parent::prepare();
        foreach ($this->columns as $col => $obj) {
            $this->columns[$col]->clearFooters();
        }   
    }
     
    
    function genSafeColId($column) {
        $this->id = 'dt'.md5($this->getServerId().$column).'_';
    }
    
    var $RowCount=0;
    
    var $columns = array();
    
    var $groups = array();
    
    var $rowCssClassFilter;
    
    var $rowAttribs = '';
    
    function setRowAttrib($attribs) { 
        if (trim($attribs)) {
            $this->rowAttribs = ' '.trim($attribs); 
        }
    }
    
    function registerRowCssClassFilter(&$filter) {
        if (is_object($filter)
            && method_exists($filter, 'doFilter')) {
            $this->rowCssClassFilter =& $filter;
        }
    }
    
    function renderRow(&$DataSource) {
        if ($this->colCount()) {
            $this->openTableRow($DataSource);
            foreach ($this->columns as $key => $val) {
                $this->columns[$key]->render($this->_datasource, $DataSource, $this->get($key));
            }
            echo "</tr>\n";
        }
    }
    
    function openTableRow(&$DataSource) {
        $this->RowCount++;
        $filter =& $this->rowCssClassFilter;
        if (is_object($filter)
            && $class = $filter->doFilter($DataSource, $this->_datasource, $this->RowCount)
            ) {
            echo '<tr class="'.$class.'"'.$this->rowAttribs.'>';
        } else {
            echo '<tr'.$this->rowAttribs.'>';
        }
    }
    
    function registerColumn($column, &$columnComponent) {
        $this->columns[$column] =& $columnComponent;
    }
    
    function registerGroup(&$groupComponent) {
        $this->groups[] =& $groupComponent;
    }
    
    function addColumn($column) {
        if (!array_key_exists($column, $this->columns)) {
            $this->columns[$column] =& new DataColumnComponent;
        }
    }
    
    function getColumnKeys() {
        return array_keys($this->columns);
    }
    
    function genHeaders(&$TabDataSource, &$TplDataSource) {
        if (count($this->groups)) {
            $grp_head = false;
            foreach($this->groups as $key => $obj) {
                $grp_head = ($grp_head || ($this->groups[$key]->hasHeader()));
            }
            if ($grp_head) {
                echo '<tr>';
                foreach ($this->columns as $key => $obj) {
                    $this->columns[$key]->header($TabDataSource, $TplDataSource, $key, true, true);
                }
                echo "</tr>\n<tr>";
                foreach ($this->columns as $key => $obj) {
                    $this->columns[$key]->header($TabDataSource, $TplDataSource, $key, true, false);
                }
                echo "</tr>\n";
                return;
            }
        } else {
            echo '<tr>';
        }
        foreach ($this->columns as $key => $obj) {
            $this->columns[$key]->header($TabDataSource, $TplDataSource, $key);
        }
        echo '</tr>';
    }
    
    function genColFooters(&$TabDataSource, &$TplDataSource) {
        if ($this->RowCount > 0) {
            $depth = 0;
            foreach ($this->columns as $key => $obj) {
                $depth = max($depth, $this->columns[$key]->getFooterCount());
            }
            if ($depth) {
                for ($i=0; $i<$depth; $i++) {
                    echo '<tr>';
                    foreach ($this->columns as $key => $obj) {
                        $this->columns[$key]->renderFooter($i, $TabDataSource, $TplDataSource, $key);
                    }
                    echo "</tr>\n";
                }
            }
        }
    }
    
    function colCount() {
        $ret = 0;
        foreach ($this->columns as $key => $obj) {
            if ($this->columns[$key]->isVisible()) $ret++;
        }
        return $ret;
    }
    
    function &getColumnByName($column) {
        if (array_key_exists($column, $this->columns)) {
            return $this->columns[$column];
        }
    }
     
}


class DataColumnComponent extends Component {
    
    var $visible = true;
    
    var $heading = false;
    
    var $label = false;
    
    var $renderFunct = false;
    
    var $headerFunct = false;
    
    var $footerFuncts = array();
    
    var $group = false;
    
    var $colCssClassFilter;
    
    var $attribs = '';
    
    var $headAttribs = '';
    
    function setHeaderAttrib($attribs) {
        if (trim($attribs)) {
            $this->headAttribs = ' '.trim($attribs); 
        }
    }
    
    function setAttrib($attribs) { 
        if (trim($attribs)) {
            $this->attribs = ' '.trim($attribs); 
        }
    }
    
    function registerCssClassFilter(&$filter) {
        if (is_object($filter)
            && method_exists($filter, 'doFilter')) {
            $this->colCssClassFilter =& $filter;
        }
    }
    
    function registerGroup(&$group) { 
        $this->group =& $group; 
        if ($this->visible) { $group->incColCount(); }
    }
    
    function show() { $this->visible = true; }
    
    function hide() { $this->visible = false; }
    
    function isVisible() { return $this->visible; }
    
    function outputTh() { $this->heading = true; }
    
    function outputTd() { $this->heading = false; }
    
    function setLabel($label) { $this->label = $label; }
    
    function setRenderFunct($funct) { $this->renderFunct = $funct; }
    
    function addFooterFunct($funct) { $this->footerFuncts[] = $funct; }
    
    function clearFooters() { $this->footerFuncts = array(); }
    
    function getFooterCount() { return count($this->footerFuncts); }
    
    function renderFooter($count, &$TabDataSource, &$TplDataSource) {
        if ($this->visible) {
            if (array_key_exists($count, $this->footerFuncts)) {
                $funct = $this->footerFuncts[$count];
                $funct($TabDataSource, $TplDataSource, $this->attribs);
            } else {
                echo '<td>&nbsp;</td>';
            }
        }
    }

    
    function openTableRow(&$DataSource) {
        $filter =& $this->rowCssClassFilter;
        if (is_object($filter)
            && $class = $filter->doFilter($DataSource, $this->_datasource, $this->RowCount)
            ) {
            echo '<tr class="'.$class.'">';
        } else {
            echo '<tr>';
        }
    }


    
    function render(&$TabDataSource, &$TplDataSource, $value) {
        if ($this->visible) {
            $cell_type = ($this->heading) ? 'th' : 'td';
            $filter =& $this->colCssClassFilter;
            $class_out = '';
            if (is_object($filter)
            	&& is_object($table =& $this->findParentByClass('DataTableComponent'))
                && $class = $filter->doFilter($TplDataSource, $TabDataSource, $table->RowCount)
                ) {
                $class_out = ' class="'.$class.'"';
            }
            echo "<$cell_type$class_out".$this->attribs.">";
            if ($funct = $this->renderFunct) {
                 $funct($TabDataSource, $TplDataSource);
            } else {
                echo $value;
            }
            echo "</$cell_type>";
        }
    }
    
    function setHeaderFunct($funct) { $this->headerFunct = $funct; }
    
    function header(&$TabDataSource, &$TplDataSource, $key, $grpHead=false, $firstPass=true) {
        if ($this->visible) {
            if ($grpHead) {
                if ($firstPass) {
                    if (is_object($this->group) 
                        && $this->group->hasHeader()) {
                            $this->group->renderHeader($TabDataSource, $TplDataSource);
                            return;
                    } elseif (is_object($this->group) 
                        && !$this->group->hasHeader()) {
                            echo '<th rowspan="2"'.$this->headAttribs.'>';
                    } else {
                        echo '<th rowspan="2"'.$this->headAttribs.'>';
                    }
                } else {                     if (is_object($this->group) 
                    && $this->group->hasHeader()) {
                        echo '<th>';
                    } else  {
                        return;
                    }
                }
            } else {
                echo '<th'.$this->headAttribs.'>';
            }
            if ($funct = $this->headerFunct) {
                 $funct($TabDataSource, $TplDataSource);
            } elseif ($this->label) {
                echo $this->label;
            } else {
                echo $key;
            }
            echo '</th>';
        }
    }

}


class DataGroupComponent extends Component {
    
    var $output = false;
    var $columnCount = 0;
    var $headerFunct = false;
        
    
    function incColCount() { $this->columnCount++; }
    function getColCount() { return $this->columnCount; }
    function setHeaderFunct($funct) { $this->headerFunct = $funct; }
    function hasHeader() { 
        return ($this->columnCount && $this->headerFunct) 
                ? true : false; 
    }
        
    
    function renderHeader(&$TabDataSource, &$TplDataSource) {
        if (!$this->output && $this->columnCount && $this->headerFunct) {
            $this->output = true;
            echo '<th colspan="'.$this->columnCount.'">';
            $funct = $this->headerFunct;
            $funct($TabDataSource, $TplDataSource);
            echo '</th>';
        }
    }
}

?>