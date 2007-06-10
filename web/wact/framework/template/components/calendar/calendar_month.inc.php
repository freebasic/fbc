<?php




if ( !defined('CALENDAR_ROOT') ) {
    define('CALENDAR_ROOT', ConfigManager::getOptionAsPath('config', 'pear', 'library_path') . 'Calendar/');
}
if (!@include_once CALENDAR_ROOT . 'Month/Weekdays.php') {
    RaiseError('runtime', 'LIBRARY_REQUIRED', array(
        'library' => 'PEAR::Calendar v0.4+',
        'path' => CALENDAR_ROOT));
}
require_once CALENDAR_ROOT . 'Day.php';
require_once CALENDAR_ROOT . 'Decorator/Textual.php';
require_once CALENDAR_ROOT . 'Decorator/Uri.php';
require_once CALENDAR_ROOT . 'Decorator/Wrapper.php';

require_once WACT_ROOT . 'template/components/html/html_base.inc.php';

class CalendarMonthComponent extends HtmlBaseComponent {
	
	var $Calendar;
	
	var $Textual;
	
	var $Uri;
	
	var $Wrapper;
	
	var $baseUrl;
	
	var $yearUri = 'y';
	
	var $monthUri = 'm';
	
	var $dayUri = 'd';
	
	var $selection = array();
	
	function CalendarMonthComponent() {
        $this->baseUrl = $_SERVER['REQUEST_URI'];
        $pos = strpos($this->baseUrl, '?');
        if (is_integer($pos)) {
            $this->baseUrl = substr($this->baseUrl, 0, $pos);
        }
	}
	
	
	function prevLink() {
		return $this->getBaseUri().$this->Uri->prev('month');
	}
	
	function nextLink() {
		return $this->getBaseUri().$this->Uri->next('month');
	}
	
	function dayLink($day) {
		return $this->getBaseUri().$this->Uri->this('day');
	}
	
	function yearFormatted($format) {
		$formats = array('full','two','hide');
		if ( !in_array($format,$formats) ) {
			$format = 'full';
		}
		switch ( $format ) {
			case 'hide':
				return '';
			break;
			case 'two':
				return substr($this->Calendar->thisYear(),2);
			break;
			case 'full':
			case 'default':
				return $this->Calendar->thisYear();
			break;
		}
	}
	
	function monthName($format) {
		return $this->Textual->thisMonthName($format);
	}
	
	function dayHeaders($format) {
		return $this->Textual->orderedWeekdays($format);
	}
	
	function setSelection(& $selection) {
		$this->selection = & $selection;
	}
	
	function prepare() {
		if ( !isset($_GET[$this->yearUri]) ) $_GET[$this->yearUri] = date('Y');
		if ( !isset($_GET[$this->monthUri]) ) $_GET[$this->monthUri] = date('n');

		$this->Calendar = & new Calendar_Month_Weekdays($_GET[$this->yearUri],$_GET[$this->monthUri]);
		$this->Textual = & new Calendar_Decorator_Textual($this->Calendar);
		$this->Uri = & new Calendar_Decorator_Uri($this->Calendar);
		$this->Uri->setFragments($this->yearUri,$this->monthUri);
		$this->Wrapper = & new Calendar_Decorator_Wrapper($this->Calendar);
		$selection = array();
		$selection[] = new Calendar_Day(date('Y'),date('n'),date('d'));
		if ( isset($_GET[$this->dayUri]) ) {
			$selection[] = new Calendar_Day($_GET[$this->yearUri],$_GET[$this->monthUri],$_GET[$this->dayUri]);
		}
		if ( count ($this->selection) > 0 ) {
			foreach ( array_keys($this->selection) as $key ) {
				$selection[] = & $this->selection[$key];
			}
		}
		$this->Wrapper->build($selection);
	}
	
	function & getCalendar() {
		return $this->Wrapper;
	}
	
	
    function getBaseUri() {

        $params = $_GET;
		if ( isset($params[$this->yearUri]) ) {
			unset($params[$this->yearUri]);
		}
		if ( isset($params[$this->monthUri]) ) {
			unset($params[$this->monthUri]);
		}
		if ( isset($params[$this->dayUri]) ) {
			unset($params[$this->dayUri]);
		}		

        $sep = '';
        $query = '';
        foreach ($params as $key => $value) {
            $query .= $sep . $key . '=' . urlencode($value);
            $sep = '&';
        }
        if (empty($query)) {
            return $this->baseUrl.'?';
        } else {
            return $this->baseUrl . '?' . $query . '&';
        }
        
    }	
}
?>