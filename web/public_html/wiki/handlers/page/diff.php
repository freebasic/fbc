<div class="page">
<?php

if ($this->HasAccess("read")) 
{

/* A php wdiff  (word diff) for wakka, adapted by David Delon
   based on wdiff and phpwiki diff (copyright below).
   TODO : Since wdiff use only directive lines, all stuff in diff class 
   related to line and context display should be removed.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version. */

  
/* A PHP diff engine for phpwiki.
  
   Copyright (C) 2000, 2001 Geoffrey T. Dairiki <dairiki@dairiki.org>
   You may copy this code freely under the conditions of the GPL.
*/
 
/* wdiff -- front end to diff for comparing on a word per word basis.
   Copyright (C) 1992 Free Software Foundation, Inc.
   Francois Pinard <pinard@iro.umontreal.ca>.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

 */

// If asked, call original diff 

	if ($_REQUEST["fastdiff"]) {
	   
		/* NOTE: This is a really cheap way to do it. I think it may be more intelligent to write the two pages to temporary files and run /usr/bin/diff over them. Then again, maybe not.        */ 
		// load pages
		  $pageA = $this->LoadPageById($_REQUEST["a"]);
		  $pageB = $this->LoadPageById($_REQUEST["b"]);
	
		// prepare bodies
		  $bodyA = explode("\n", $pageA["body"]);
		  $bodyB = explode("\n", $pageB["body"]);
	
		  $added = array_diff($bodyA, $bodyB);
		  $deleted = array_diff($bodyB, $bodyA);
	
		  $output .= "<b>Comparison of  <a href=\"".$this->Href("", "", "time=".urlencode($pageA["time"]))."\">".$pageA["time"]."</a> &amp; <a href=\"".$this->Href("", "", "time=".urlencode($pageB["time"]))."\">".$pageB["time"]."</a></b><br />\n";
	
		  if ($added)
		  {
			// remove blank lines
			$output .= "<br />\n<b>Additions:</b><br />\n";
			$output .= "<span class=\"additions\">".$this->Format(implode("\n", $added))."</span>";
		  }
	
		  if ($deleted)
		  {
			$output .= "<br />\n<b>Deletions:</b><br />\n";
			$output .= "<span class=\"deletions\">".$this->Format(implode("\n", $deleted))."</span>";
		  }
	
		  if (!$added && !$deleted)
		  {
			$output .= "<br />\nNo Differences.";
		  }
		  echo $output;
	
	}
	
	else {
	
	// load pages
	
		$pageA = $this->LoadPageById($_REQUEST["b"]);
		$pageB = $this->LoadPageById($_REQUEST["a"]);
	
		// extract text from bodies
		$textA = $pageA["body"];
		$textB = $pageB["body"];
	
		$sideA = new Side($textA);
		$sideB = new Side($textB);
	
		$bodyA='';
		$sideA->split_file_into_words($bodyA);
	
		$bodyB='';
		$sideB->split_file_into_words($bodyB);
	
		// diff on these two file
		$diff = new Diff(split("\n",$bodyA),split("\n",$bodyB));
	
		// format output
		$fmt = new DiffFormatter();
	
		$sideO = new Side($fmt->format($diff));
	
		$resync_left=0;
		$resync_right=0;
	
		$count_total_right=$sideB->getposition() ;
	
		$sideA->init();
		$sideB->init();
	
		echo "<b>Comparing <a href=\"".$this->Href("", "", "time=".urlencode($pageA["time"]))."\">".$pageA["time"]."</a> to <a href=\"".$this->Href("", "", "time=".urlencode($pageB["time"]))."\">".$pageB["time"]."</a></b> ";
		echo "-- Highlighting Guide: <span class=\"additions\">addition</span> <span class=\"deletions\">deletion</span><p>";
		$output='';

		  while (1) {
		       
		      $sideO->skip_line();
		      if ($sideO->isend()) {
			  break;
		      }
	
		      if ($sideO->decode_directive_line()) {
			$argument=$sideO->getargument();
			$letter=$sideO->getdirective();
		      switch ($letter) {
			    case 'a':
			      $resync_left = $argument[0];
			      $resync_right = $argument[2] - 1;
			      break;
	
			    case 'd':
			      $resync_left = $argument[0] - 1;
			      $resync_right = $argument[2];
			      break;
	
			    case 'c':
			      $resync_left = $argument[0] - 1;
			      $resync_right = $argument[2] - 1;
			      break;
	
			    }
	
			    $sideA->skip_until_ordinal($resync_left);
			    $sideB->copy_until_ordinal($resync_right,$output);
	  
	// deleted word
	
			if (($letter=='d') || ($letter=='c')) {
				$sideA->copy_whitespace($output);
				$output .="&yen;&yen;";
				$sideA->copy_word($output);
				$sideA->copy_until_ordinal($argument[1],$output);
				$output .=" &yen;&yen;";
			}
	
	// inserted word
			    if ($letter == 'a' || $letter == 'c') {
				$sideB->copy_whitespace($output);
				$output .="&pound;&pound;";
				$sideB->copy_word($output);
				$sideB->copy_until_ordinal($argument[3],$output);
				$output .=" &pound;&pound;";
			    }
	
		  }
	
		}
	
		  $sideB->copy_until_ordinal($count_total_right,$output);
		  $sideB->copy_whitespace($output);
		  $out=$this->Format($output);
		  echo $out;
	
	}

}
else{
	echo "<em>You are not authorized to view this page.</em>" ;
}
	
	// Side : a string for wdiff
	
	class Side {
	    var $position;
	    var $cursor;
	    var $content;
	    var $character;
	    var $directive;
	    var $argument;
	    var $length;

	    function Side($content) {
	       $this->content=$content;
	       $this->position=0;
	       $this->cursor=0;
	       $this->directive='';
	       $this->argument=array();
	       $this->length=strlen($this->content);
	       $this->character=substr($this->content,0,1);
	       
	    }

	    function getposition() {
	       return $this->position;
	    }

	    function getcharacter() {
	       return $this->character;
	    }

	    function getdirective() {
	       return $this->directive;
	    }

	    function getargument() {
	       return $this->argument;
	    }

	    function nextchar() {
	       $this->cursor++; 
	       $this->character=substr($this->content,$this->cursor,1);
	    }

	    function copy_until_ordinal($ordinal,&$out)  {
	       while ($this->position < $ordinal) {
		  $this->copy_whitespace($out);
		  $this->copy_word($out);
	       }
	    }

	    function skip_until_ordinal($ordinal) {
	       while ($this->position < $ordinal) {
		  $this->skip_whitespace();
		  $this->skip_word();
	       }
	    }

	    function split_file_into_words (&$out) {
	       while (!$this->isend()) {
		 $this->skip_whitespace();
		 if ($this->isend()) {
		   break;
		 }
		 $this->copy_word($out);
		 $out .="\n";
	       }
	    }
	    
	    function init() {
	       $this->position=0;
	       $this->cursor=0;
	       $this->directive='';
	       $this->argument=array();
	       $this->character=substr($this->content,0,1);
	    }     

	    function isspace($char) {
	       if (ereg('[[:space:]]',$char)) {
		  return true;
	       }
	       else {
		  return false;
	       }
	    }

	    function isdigit($char) {
	       if (ereg('[[:digit:]]',$char)) {
		  return true;
	       }
	       else {
		  return false;
	       }
	    }

	    function isend() {
	       if (($this->cursor)>=($this->length)) {
		  return true;
	       }
	       else {
		  return false;
	       }
	    }



	    function copy_whitespace(&$out)  {
		 while (!$this->isend() && $this->isspace($this->character)) {
		    $out .=$this->character;
		    $this->nextchar();
		 }
	    }

	    function skip_whitespace()  {
		 while (!$this->isend() && $this->isspace($this->character)) {
		    $this->nextchar();
		 }
	    }

	    function skip_line()  {
	      while (!$this->isend() && !$this->isdigit($this->character)) {
		  while (!$this->isend() && $this->character!="\n")
		  $this->nextchar();
		  if($this->character=="\n")
		      $this->nextchar();
	       }
	     }



	     function copy_word(&$out) {
		 while (!$this->isend() && !($this->isspace($this->character))) {
		    $out.=$this->character;
		    $this->nextchar();
		 }
		 $this->position++;
	     }

	     function skip_word() {

		 while (!$this->isend() && !($this->isspace($this->character))) {
		    $this->nextchar();
		 }
		 $this->position++;
	     }


	 function decode_directive_line() {

	  $value=0;                    
	  $state=0;                   
	  $error=0;                  

	  while (!$error && $state < 4) {
	      if ($this->isdigit($this->character)) {
		  $value = 0;
		  while($this->isdigit($this->character)) {
		      $value = 10 * $value + $this->character - '0';
		      $this->nextchar(); 
		  }
	      }
	      else if ($state != 1 && $state != 3)
	      $error = 1;

	      /* Assign the proper value.  */

	      $this->argument[$state] = $value;

	      /* Skip the following character.  */

	      switch ($state) {
		case 0:
		case 2:
		  if ($this->character == ',')
		     $this->nextchar();
		  break;

		case 1:
		  if ($this->character == 'a' || $this->character == 'd' || $this->character == 'c') {
		      $this->directive = $this->character;
		      $this->nextchar();
		    }
		  else
		    $error = 1;
		  break;

		  case 3:
		  if ($this->character != "\n")
		    $error = 1;
		    break;
		  }
		 $state++;
	      }

	  /* Complete reading of the line and return success value.  */

	  while ((!$this->isend()) && ($this->character != "\n")) {
	      $this->nextchar();
	  }
	  if ($this->character == "\n")
	      $this->nextchar();

	  return !$error;
	}



	}

	// difflib
	//
	// A PHP diff engine for phpwiki.
	//
	// Copyright (C) 2000, 2001 Geoffrey T. Dairiki <dairiki@dairiki.org>
	// You may copy this code freely under the conditions of the GPL.
	//


	// PHP3 does not have assert()
	define('USE_ASSERTS', function_exists('assert'));

	class _DiffOp {
	    var $type;
	    var $orig;
	    var $final;
	    

	    function norig() {
		return $this->orig ? sizeof($this->orig) : 0;
	    }

	    function nfinal() {
		return $this->final ? sizeof($this->final) : 0;
	    }
	}

	class _DiffOp_Copy extends _DiffOp {
	    var $type = 'copy';
	    
	    function _DiffOp_Copy ($orig, $final = false) {
		if (!is_array($final))
		    $final = $orig;
		$this->orig = $orig;
		$this->final = $final;
	    }

	}

	class _DiffOp_Delete extends _DiffOp {
	    var $type = 'delete';
	    
	    function _DiffOp_Delete ($lines) {
		$this->orig = $lines;
		$this->final = false;
	    }

	}

	class _DiffOp_Add extends _DiffOp {
	    var $type = 'add';
	    
	    function _DiffOp_Add ($lines) {
		$this->final = $lines;
		$this->orig = false;
	    }

	}

	class _DiffOp_Change extends _DiffOp {
	    var $type = 'change';
	    
	    function _DiffOp_Change ($orig, $final) {
		$this->orig = $orig;
		$this->final = $final;
	    }

	}
		
	      
	/**
	 * Class used internally by Diff to actually compute the diffs.
	 *
	 * The algorithm used here is mostly lifted from the perl module
	 * Algorithm::Diff (version 1.06) by Ned Konz, which is available at:
	 *   http://www.perl.com/CPAN/authors/id/N/NE/NEDKONZ/Algorithm-Diff-1.06.zip
	 *
	 * More ideas are taken from:
	 *   http://www.ics.uci.edu/~eppstein/161/960229.html
	 *
	 * Some ideas are (and a bit of code) are from from analyze.c, from GNU
	 * diffutils-2.7, which can be found at:
	 *   ftp://gnudist.gnu.org/pub/gnu/diffutils/diffutils-2.7.tar.gz
	 *
	 * Finally, some ideas (subdivision by NCHUNKS > 2, and some optimizations)
	 * are my own.
	 *
	 * @author Geoffrey T. Dairiki
	 * @access private
	 */
	class _DiffEngine
	{
	    function diff ($from_lines, $to_lines) {
		$n_from = sizeof($from_lines);
		$n_to = sizeof($to_lines);

		$this->xchanged = $this->ychanged = array();
		$this->xv = $this->yv = array();
		$this->xind = $this->yind = array();
		unset($this->seq);
		unset($this->in_seq);
		unset($this->lcs);
		 
		// Skip leading common lines.
		for ($skip = 0; $skip < $n_from && $skip < $n_to; $skip++) {
		    if ($from_lines[$skip] != $to_lines[$skip])
			break;
		    $this->xchanged[$skip] = $this->ychanged[$skip] = false;
		}
		// Skip trailing common lines.
		$xi = $n_from; $yi = $n_to;
		for ($endskip = 0; --$xi > $skip && --$yi > $skip; $endskip++) {
		    if ($from_lines[$xi] != $to_lines[$yi])
			break;
		    $this->xchanged[$xi] = $this->ychanged[$yi] = false;
		}
		
		// Ignore lines which do not exist in both files.
		for ($xi = $skip; $xi < $n_from - $endskip; $xi++)
		    $xhash[$from_lines[$xi]] = 1;
		for ($yi = $skip; $yi < $n_to - $endskip; $yi++) {
		    $line = $to_lines[$yi];
		    if ( ($this->ychanged[$yi] = empty($xhash[$line])) )
			continue;
		    $yhash[$line] = 1;
		    $this->yv[] = $line;
		    $this->yind[] = $yi;
		}
		for ($xi = $skip; $xi < $n_from - $endskip; $xi++) {
		    $line = $from_lines[$xi];
		    if ( ($this->xchanged[$xi] = empty($yhash[$line])) )
			continue;
		    $this->xv[] = $line;
		    $this->xind[] = $xi;
		}

		// Find the LCS.
		$this->_compareseq(0, sizeof($this->xv), 0, sizeof($this->yv));

		// Merge edits when possible
		$this->_shift_boundaries($from_lines, $this->xchanged, $this->ychanged);
		$this->_shift_boundaries($to_lines, $this->ychanged, $this->xchanged);

		// Compute the edit operations.
		$edits = array();
		$xi = $yi = 0;
		while ($xi < $n_from || $yi < $n_to) {
		    USE_ASSERTS && assert($yi < $n_to || $this->xchanged[$xi]);
		    USE_ASSERTS && assert($xi < $n_from || $this->ychanged[$yi]);

		    // Skip matching "snake".
		    $copy = array();
		    while ( $xi < $n_from && $yi < $n_to
			    && !$this->xchanged[$xi] && !$this->ychanged[$yi]) {
			$copy[] = $from_lines[$xi++];
			++$yi;
		    }
		    if ($copy)
			$edits[] = new _DiffOp_Copy($copy);

		    // Find deletes & adds.
		    $delete = array();
		    while ($xi < $n_from && $this->xchanged[$xi])
			$delete[] = $from_lines[$xi++];

		    $add = array();
		    while ($yi < $n_to && $this->ychanged[$yi])
			$add[] = $to_lines[$yi++];
		    
		    if ($delete && $add)
			$edits[] = new _DiffOp_Change($delete, $add);
		    elseif ($delete)
			$edits[] = new _DiffOp_Delete($delete);
		    elseif ($add)
			$edits[] = new _DiffOp_Add($add);
		}
		return $edits;
	    }
	    

	    /* Divide the Largest Common Subsequence (LCS) of the sequences
	     * [XOFF, XLIM) and [YOFF, YLIM) into NCHUNKS approximately equally
	     * sized segments.
	     *
	     * Returns (LCS, PTS).  LCS is the length of the LCS. PTS is an
	     * array of NCHUNKS+1 (X, Y) indexes giving the diving points between
	     * sub sequences.  The first sub-sequence is contained in [X0, X1),
	     * [Y0, Y1), the second in [X1, X2), [Y1, Y2) and so on.  Note
	     * that (X0, Y0) == (XOFF, YOFF) and
	     * (X[NCHUNKS], Y[NCHUNKS]) == (XLIM, YLIM).
	     *
	     * This function assumes that the first lines of the specified portions
	     * of the two files do not match, and likewise that the last lines do not
	     * match.  The caller must trim matching lines from the beginning and end
	     * of the portions it is going to specify.
	     */
	    function _diag ($xoff, $xlim, $yoff, $ylim, $nchunks) {
		$flip = false;
		
		if ($xlim - $xoff > $ylim - $yoff) {
		    // Things seems faster (I'm not sure I understand why)
		    // when the shortest sequence in X.
		    $flip = true;
		    list ($xoff, $xlim, $yoff, $ylim)
			= array( $yoff, $ylim, $xoff, $xlim);
		}

		if ($flip)
		    for ($i = $ylim - 1; $i >= $yoff; $i--)
			$ymatches[$this->xv[$i]][] = $i;
		else
		    for ($i = $ylim - 1; $i >= $yoff; $i--)
			$ymatches[$this->yv[$i]][] = $i;

		$this->lcs = 0;
		$this->seq[0]= $yoff - 1;
		$this->in_seq = array();
		$ymids[0] = array();
	    
		$numer = $xlim - $xoff + $nchunks - 1;
		$x = $xoff;
		for ($chunk = 0; $chunk < $nchunks; $chunk++) {
		    if ($chunk > 0)
			for ($i = 0; $i <= $this->lcs; $i++)
			    $ymids[$i][$chunk-1] = $this->seq[$i];

		    $x1 = $xoff + (int)(($numer + ($xlim-$xoff)*$chunk) / $nchunks);
		    for ( ; $x < $x1; $x++) {
			$line = $flip ? $this->yv[$x] : $this->xv[$x];
			if (empty($ymatches[$line]))
			    continue;
			$matches = $ymatches[$line];
			reset($matches);
			while (list ($junk, $y) = each($matches))
			    if (empty($this->in_seq[$y])) {
				$k = $this->_lcs_pos($y);
				USE_ASSERTS && assert($k > 0);
				$ymids[$k] = $ymids[$k-1];
				break;
			    }
			while (list ($junk, $y) = each($matches)) {
			    if ($y > $this->seq[$k-1]) {
				USE_ASSERTS && assert($y < $this->seq[$k]);
				// Optimization: this is a common case:
				//  next match is just replacing previous match.
				$this->in_seq[$this->seq[$k]] = false;
				$this->seq[$k] = $y;
				$this->in_seq[$y] = 1;
			    }
			    else if (empty($this->in_seq[$y])) {
				$k = $this->_lcs_pos($y);
				USE_ASSERTS && assert($k > 0);
				$ymids[$k] = $ymids[$k-1];
			    }
			}
		    }
		}

		$seps[] = $flip ? array($yoff, $xoff) : array($xoff, $yoff);
		$ymid = $ymids[$this->lcs];
		for ($n = 0; $n < $nchunks - 1; $n++) {
		    $x1 = $xoff + (int)(($numer + ($xlim - $xoff) * $n) / $nchunks);
		    $y1 = $ymid[$n] + 1;
		    $seps[] = $flip ? array($y1, $x1) : array($x1, $y1);
		}
		$seps[] = $flip ? array($ylim, $xlim) : array($xlim, $ylim);

		return array($this->lcs, $seps);
	    }

	    function _lcs_pos ($ypos) {
		$end = $this->lcs;
		if ($end == 0 || $ypos > $this->seq[$end]) {
		    $this->seq[++$this->lcs] = $ypos;
		    $this->in_seq[$ypos] = 1;
		    return $this->lcs;
		}

		$beg = 1;
		while ($beg < $end) {
		    $mid = (int)(($beg + $end) / 2);
		    if ( $ypos > $this->seq[$mid] )
			$beg = $mid + 1;
		    else
			$end = $mid;
		}

		USE_ASSERTS && assert($ypos != $this->seq[$end]);

		$this->in_seq[$this->seq[$end]] = false;
		$this->seq[$end] = $ypos;
		$this->in_seq[$ypos] = 1;
		return $end;
	    }

	    /* Find LCS of two sequences.
	     *
	     * The results are recorded in the vectors $this->{x,y}changed[], by
	     * storing a 1 in the element for each line that is an insertion
	     * or deletion (ie. is not in the LCS).
	     *
	     * The subsequence of file 0 is [XOFF, XLIM) and likewise for file 1.
	     *
	     * Note that XLIM, YLIM are exclusive bounds.
	     * All line numbers are origin-0 and discarded lines are not counted.
	     */
	    function _compareseq ($xoff, $xlim, $yoff, $ylim) {
		// Slide down the bottom initial diagonal.
		while ($xoff < $xlim && $yoff < $ylim
		       && $this->xv[$xoff] == $this->yv[$yoff]) {
		    ++$xoff;
		    ++$yoff;
		}

		// Slide up the top initial diagonal.
		while ($xlim > $xoff && $ylim > $yoff
		       && $this->xv[$xlim - 1] == $this->yv[$ylim - 1]) {
		    --$xlim;
		    --$ylim;
		}

		if ($xoff == $xlim || $yoff == $ylim)
		    $lcs = 0;
		else {
		    // This is ad hoc but seems to work well.
		    //$nchunks = sqrt(min($xlim - $xoff, $ylim - $yoff) / 2.5);
		    //$nchunks = max(2,min(8,(int)$nchunks));
		    $nchunks = min(7, $xlim - $xoff, $ylim - $yoff) + 1;
		    list ($lcs, $seps)
			= $this->_diag($xoff,$xlim,$yoff, $ylim,$nchunks);
		}

		if ($lcs == 0) {
		    // X and Y sequences have no common subsequence:
		    // mark all changed.
		    while ($yoff < $ylim)
			$this->ychanged[$this->yind[$yoff++]] = 1;
		    while ($xoff < $xlim)
			$this->xchanged[$this->xind[$xoff++]] = 1;
		}
		else {
		    // Use the partitions to split this problem into subproblems.
		    reset($seps);
		    $pt1 = $seps[0];
		    while ($pt2 = next($seps)) {
			$this->_compareseq ($pt1[0], $pt2[0], $pt1[1], $pt2[1]);
			$pt1 = $pt2;
		    }
		}
	    }

	    /* Adjust inserts/deletes of identical lines to join changes
	     * as much as possible.
	     *
	     * We do something when a run of changed lines include a
	     * line at one end and has an excluded, identical line at the other.
	     * We are free to choose which identical line is included.
	     * `compareseq' usually chooses the one at the beginning,
	     * but usually it is cleaner to consider the following identical line
	     * to be the "change".
	     *
	     * This is extracted verbatim from analyze.c (GNU diffutils-2.7).
	     */
	    function _shift_boundaries ($lines, &$changed, $other_changed) {
		$i = 0;
		$j = 0;

		USE_ASSERTS && assert('sizeof($lines) == sizeof($changed)');
		$len = sizeof($lines);
		$other_len = sizeof($other_changed);

		while (1) {
		    /*
		     * Scan forwards to find beginning of another run of changes.
		     * Also keep track of the corresponding point in the other file.
		     *
		     * Throughout this code, $i and $j are adjusted together so that
		     * the first $i elements of $changed and the first $j elements
		     * of $other_changed both contain the same number of zeros
		     * (unchanged lines).
		     * Furthermore, $j is always kept so that $j == $other_len or
		     * $other_changed[$j] == false.
		     */
		    while ($j < $other_len && $other_changed[$j])
			$j++;
		    
		    while ($i < $len && ! $changed[$i]) {
			USE_ASSERTS && assert('$j < $other_len && ! $other_changed[$j]');
			$i++; $j++;
			while ($j < $other_len && $other_changed[$j])
			    $j++;
		    }
		    
		    if ($i == $len)
			break;

		    $start = $i;

		    // Find the end of this run of changes.
		    while (++$i < $len && $changed[$i])
			continue;

		    do {
			/*
			 * Record the length of this run of changes, so that
			 * we can later determine whether the run has grown.
			 */
			$runlength = $i - $start;

			/*
			 * Move the changed region back, so long as the
			 * previous unchanged line matches the last changed one.
			 * This merges with previous changed regions.
			 */
			while ($start > 0 && $lines[$start - 1] == $lines[$i - 1]) {
			    $changed[--$start] = 1;
			    $changed[--$i] = false;
			    while ($start > 0 && $changed[$start - 1])
				$start--;
			    USE_ASSERTS && assert('$j > 0');
			    while ($other_changed[--$j])
				continue;
			    USE_ASSERTS && assert('$j >= 0 && !$other_changed[$j]');
			}

			/*
			 * Set CORRESPONDING to the end of the changed run, at the last
			 * point where it corresponds to a changed run in the other file.
			 * CORRESPONDING == LEN means no such point has been found.
			 */
			$corresponding = $j < $other_len ? $i : $len;

			/*
			 * Move the changed region forward, so long as the
			 * first changed line matches the following unchanged one.
			 * This merges with following changed regions.
			 * Do this second, so that if there are no merges,
			 * the changed region is moved forward as far as possible.
			 */
			while ($i < $len && $lines[$start] == $lines[$i]) {
			    $changed[$start++] = false;
			    $changed[$i++] = 1;
			    while ($i < $len && $changed[$i])
				$i++;

			    USE_ASSERTS && assert('$j < $other_len && ! $other_changed[$j]');
			    $j++;
			    if ($j < $other_len && $other_changed[$j]) {
				$corresponding = $i;
				while ($j < $other_len && $other_changed[$j])
				    $j++;
			    }
			}
		    } while ($runlength != $i - $start);

		    /*
		     * If possible, move the fully-merged run of changes
		     * back to a corresponding run in the other file.
		     */
		    while ($corresponding < $i) {
			$changed[--$start] = 1;
			$changed[--$i] = 0;
			USE_ASSERTS && assert('$j > 0');
			while ($other_changed[--$j])
			    continue;
			USE_ASSERTS && assert('$j >= 0 && !$other_changed[$j]');
		    }
		}
	    }
	}

	/**
	 * Class representing a 'diff' between two sequences of strings.
	 */
	class Diff 
	{
	    var $edits;

	    /**
	     * Constructor.
	     * Computes diff between sequences of strings.
	     *
	     * @param $from_lines array An array of strings.
	     *        (Typically these are lines from a file.)
	     * @param $to_lines array An array of strings.
	     */
	    function Diff($from_lines, $to_lines) {
		$eng = new _DiffEngine;
		$this->edits = $eng->diff($from_lines, $to_lines);
	    }

	}

		    

	/**
	 * A class to format Diffs
	 *
	 * This class formats the diff in classic diff format.
	 * It is intended that this class be customized via inheritance,
	 * to obtain fancier outputs.
	 */
	class DiffFormatter
	{

	    /**
	     * Format a diff.
	     *
	     * @param $diff object A Diff object.
	     * @return string The formatted output.
	     */
	    function format($diff) {

		$xi = $yi = 1;
		$block = false;
		$context = array();

		$this->_start_diff();

		foreach ($diff->edits as $edit) {
		    if ($edit->type == 'copy') {
			if (is_array($block)) {
			    if (sizeof($edit->orig) <= 0) {
				$block[] = $edit;
			    }
			    else{
				$this->_block($x0, + $xi - $x0,
					      $y0, + $yi - $y0,
					      $block);
				$block = false;
			    }
			}
		    }
		    else {
			if (! is_array($block)) {
			    $x0 = $xi;
			    $y0 = $yi;
			    $block = array();
			}
			$block[] = $edit;
		    }

		    if ($edit->orig)
			$xi += sizeof($edit->orig);
		    if ($edit->final)
			$yi += sizeof($edit->final);
		}

		if (is_array($block))
		    $this->_block($x0, $xi - $x0,
				  $y0, $yi - $y0,
				  $block);

		return $this->_end_diff();
	    }

	    function _block($xbeg, $xlen, $ybeg, $ylen, &$edits) {
		$this->_start_block($this->_block_header($xbeg, $xlen, $ybeg, $ylen));
	    }

	    function _start_diff() {
		ob_start();
	    }

	    function _end_diff() {
		$val = ob_get_contents();
		ob_end_clean();
		return $val;
	    }

	    function _block_header($xbeg, $xlen, $ybeg, $ylen) {
		if ($xlen > 1)
		    $xbeg .= "," . ($xbeg + $xlen - 1);
		if ($ylen > 1)
		    $ybeg .= "," . ($ybeg + $ylen - 1);

		return $xbeg . ($xlen ? ($ylen ? 'c' : 'd') : 'a') . $ybeg;
	    }
	    
	    function _start_block($header) {
		echo $header."\n";
	    }

	}
	

?>
</div>
