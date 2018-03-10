BEGIN   {IGNORECASE=1; FS=":"}
$1 == "%dom"  {sub(/^ /,"",$2); ind[0][i]=$2; i++}
END {printDominios()}

function printDominios(){
    print "Dominios:"
    for(x in ind[0])
        print ind[0][x]
 }
