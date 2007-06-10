<?php



require_once 'domain.inc.php';


class UrlRule extends DomainRule {
    
    var $AllowableSchemes;
    
	
	function UrlRule($fieldname, $AllowableSchemes = NULL) {
		parent :: SingleFieldRule($fieldname);
		$this->AllowableSchemes = $AllowableSchemes;
	}

	
    function Check($value) {
        $url = parse_url($value);
        if (isset($url['scheme']) && isset($url['host']) &&
            ($url['scheme'] == 'http' || $url['scheme'] == 'ftp')) {
            parent::check($url['host']);
        }
        if (!is_null($this->AllowableSchemes)) {
            if (isset($url['scheme'])) {
                if (!in_array($url['scheme'], $this->AllowableSchemes)) {
                    $this->Error('URL_BAD_SCHEME', array('scheme' => $url['scheme']));
                }
            } else {
                                                $this->Error('URL_MISSING_SCHEME');
            }
        }
            }
}


?>