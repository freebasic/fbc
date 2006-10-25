<?php



class PageNavigatorComponent extends Component {
	
	var $ShowSeparator;

	
    var $page;
    
	
    var $ElipsesCount;

	
    var $LastPage;

	
    var $CurrentPage;

	
    var $AnchorSize = 3;
    
	
    var $WindowSize = 3;

	
    var $Items = 20;

	
    var $TotalItems;

	
    var $pageVariable = 'page';

	
    var $baseUrl;

	
    var $PagedDataSet;
    
	
    function PageNavigatorComponent() {
        $this->baseUrl = $_SERVER['REQUEST_URI'];
        $pos = strpos($this->baseUrl, '?');
        if (is_integer($pos)) {
            $this->baseUrl = substr($this->baseUrl, 0, $pos);
        }
        
        $this->CurrentPage = @$_GET[$this->pageVariable];
        if (empty($this->CurrentPage)) {
            $this->CurrentPage = 1;
        }
    }
    
	
    function setTotalItems($items) {
        $this->TotalItems = $items;
    }
    
	
    function setPagedDataSet(&$dataset) {
        $this->PagedDataSet =& $dataset;
    }

	
    function getStartingItem() {
        return $this->Items * ($this->CurrentPage - 1);
    }
    
	
    function getItemsPerPage() {
        return $this->Items;
    }

	
    function IsFirst() {
        return ($this->CurrentPage == 1);
    }
    
	
    function hasPrev() {
        return ($this->CurrentPage > 1);
    }
    
	
    function hasNext() {
        return ($this->CurrentPage < $this->LastPage);
    }

	
    function IsLast() {
        return ($this->CurrentPage == $this->LastPage);
    }

	
    function prepare() {
        if (isset($this->PagedDataSet)) {
            $this->setTotalItems($this->PagedDataSet->getTotalRowCount());
        }

        $this->LastPage = ceil($this->TotalItems / $this->Items);
        if ($this->LastPage < 1) {
            $this->LastPage = 1;
        }
        
        $this->ShowSeparator = FALSE;
        $this->page = 0;
        $this->ElipsesCount = 0;
    }

	
    function next() {
        $this->page++;
        return ($this->page <= $this->LastPage);  
    }

	
    function getPageNumber() {
        return $this->page;
    }

    function getCurrentPageNumber() {
        return $this->CurrentPage;
    }
    
    function getLastPageNumber() {
        return $this->LastPage;
    }
  

	
    function isCurrentPage() {
        return $this->page == $this->CurrentPage;
    }
    
	
    function isDisplayPage() {
        $HalfWindowSize = ($this->WindowSize-1) / 2;
        return (
            $this->page <= $this->AnchorSize || 
            $this->page > $this->LastPage - $this->AnchorSize ||
            ($this->page >= $this->CurrentPage - $HalfWindowSize &&
            $this->page <= $this->CurrentPage + $HalfWindowSize) ||
            ($this->page == $this->AnchorSize + 1 && 
            $this->page == $this->CurrentPage - $HalfWindowSize - 1) ||
            ($this->page == $this->LastPage - $this->AnchorSize && 
            $this->page == $this->CurrentPage + $HalfWindowSize + 1)
            );
    }

	
    function getCurrentPageUri() {
        return $this->getPageUri($this->page);
    }

	
    function getPageUri($page) {

        $params = $_GET;
        if ($page <= 1) {
            unset($params[$this->pageVariable]);
        } else {
            $params[$this->pageVariable] = $page;
        }

        $sep = '';
        $query = '';
        foreach ($params as $key => $value) {
            $query .= $sep . $key . '=' . urlencode($value);
            $sep = '&';
        }
        if (empty($query)) {
            return $this->baseUrl;
        } else {
            return $this->baseUrl . '?' . $query;
        }
        
    }

	
    function getFirstPageUri() {
        return $this->getPageUri(1);
    }

	
    function getPrevPageUri() {
        return $this->getPageUri($this->CurrentPage - 1);
    }
    
	
    function getLastPageUri() {
        return $this->getPageUri($this->LastPage);
    }
    
	
    function getNextPageUri() {
        return $this->getPageUri($this->CurrentPage + 1);
    }
    
    
}
?>