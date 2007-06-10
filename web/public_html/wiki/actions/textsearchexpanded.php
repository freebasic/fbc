<?php echo $this->FormOpen("", "", "get") ?>
<table border="0" cellspacing="0" cellpadding="0">
        <tr>
                <td>Search for:&nbsp;</td>
                <td><input name="phrase" size="40" value="<?php if (isset($_REQUEST["phrase"])) echo $this->htmlspecialchars_ent(stripslashes($_REQUEST["phrase"])); ?>" /> <input type="submit" value="Search"/></td>
        </tr>
</table>
<?php echo $this->FormClose(); ?>

<?php
if (isset($_REQUEST["phrase"]) && $phrase = $_REQUEST["phrase"])
{
	$phrase = stripslashes($phrase); 
	print("<br />");
	$results = $this->FullTextSearch($phrase);
	$match_str = count($results) <> 1 ? " matches" : " match";
	print("Search results: <strong>".count($results).$match_str."</strong> for <strong>$phrase</strong><br /><br />\n");
	$phrase = str_replace("\"", "", $phrase);
      if ($results)
      {
                print "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
                $STORE_FORMATING_AS_TEXT = 1;
                foreach ($results as $i => $page)
                {
                        //print(($i+1).". ".$this->Link($page["tag"])."<br />\n");
                        //print implode($this->LoadPage($page["tag"]));
                        //$matchString = preg_match("/(.{0,40}$phrase.{0,40})/",implode($this->LoadPage($page['tag'])));
                        /* display portion of the matching body and highlight
                           the search term */
                        preg_match("/(.{0,120}$phrase.{0,120})/is",$page['body'],$matchString);
                        $text = $this->htmlspecialchars_ent($matchString[0]);
                     //   include("formatters/wakka.php");
                        $highlightMatch = preg_replace("/($phrase)/i","<font color=\"green\"><b>$1</b></font>",$text,-1);
                        $matchText = "<font color=\"gray\" size=\"-1\">...</font>$highlightMatch<font color=\"gray\" size=\"-1\">...</font>";
                        print "

                                          <tr>
                                                <td valign=\"top\" align=\"right\">
                                                  <!-- result number -->
                                                  <table>
                                                        <tr>
                                                          <td valign=\"top\" align=\"left\" bgcolor=\"#DDDDDD\">
                                                                <font color=\"white\" size=\"-3\">
                                                                  ".($i+1)."
                                                                </font>
                                                          </td>
                                                        </tr>
                                                  </table>
                                                </td>
                                                <!-- link -->
                                                <td valign=\"top\">
                                                  ".$this->Link($page["tag"])."
                                                </td>
                                                <!-- date of last update -->
                                                <td valign=\"top\" align=\"right\">
                                                  <font color=\"gray\" size=\"-3\">
                                                        $page[time]
                                                  </font>
                                                </td>
                                          </tr>
                                          <tr>
                                                <td>
                                                  &nbsp;
                                                </td>
                                                <td colspan=\"2\">
                                                  $matchText
                                                </td>
                                          </tr>
                                          <tr>
                                                <td>
                                                  &nbsp;
                                                </td>
                                          </tr>

                                ";
                }
                print "</table>";
        }
}

?>