BEGIN       {IGNORECASE=1; FS=":"}
/^%dom/     {sub(/^ /,"",$2); ind[0][$2]++}
/^%(THE|inv)/   {for(j=2;j<=NF;j++){
                    if($j != " " && $j!=""){
                        sub(/^(\s)*/,"",$j);                #remove spaces
                        sub(/(\s)|(<(.*)?)/,"",$j);     #remove after a less than is found
                        !ind[1][$j]++;
                    }
                }
                }
END {printDominios(); printRelations()}

function printDominios(){
    print "======Dominios======"
    for(x in ind[0])
        print x
}

function printRelations(){
    print "======Relações====="
    for(x in ind[1])
        print x
}
