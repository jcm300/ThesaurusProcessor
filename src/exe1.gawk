BEGIN   {IGNORECASE=1; FS=":"; print "Dominios:"}
$1 == "%dom"  {sub(/^ /,"",$2); print $2}
