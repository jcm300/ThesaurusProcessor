BEGIN       {IGNORECASE=1; FS=":"}
/^%dom/     {sub(/^ /,"",$2); ind[0][i]=$2; i++}
/^%THE/     {for(j=2;j<=NF;j++){
                if($j != ""){
                    sub(/^ /,"",$j);                #remove spaces
                    sub(/<(.*)?/,"",$j);            #remove after a less than is found
                    ind[1][r][j]=$j
                }
             }
             r ++
            }
END {printDominios(); printRelations()}

function printDominios(){
    print "======Dominios======"
    for(x in ind[0])
        print ind[0][x]
}

function printRelations(){
    print "======Relations====="
    for(x in ind[1])
        for(t in ind[1][x])
            print ind[1][x][t]
}
