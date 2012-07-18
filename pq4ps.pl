#!/usr/bin/perl


opendir(DIR, "/usr/share/ponysay/ponies/");
@files = readdir(DIR); 

opendir(DIR, "./ponyquotes/");
@quotes = readdir(DIR); 


foreach $file (@files)
{
    $_ = $file;
    $_ =~ s/\.pony$//g;
    $f = $_;
    if (! /^\./)
    {   foreach $quote (@quotes)
	{
	    $_ = $quote;
	    $_ =~ s/\.\d+//g;
	    $_ = '\+'.$_.'\+';
	    if (! /^\./)
	    {   if (/\+$f\+/)
		{   print $f."@".$quote."\n";
	    }   }
    }   }
}
