BEGIN                                           {IGNORECASE=1; FS=":"}
/^%THE/                                         {
                                                    for(j=2;j<=NF;j++){
                                                        sub(/^ /,"",$j);                #remove spaces
                                                        sub(/(\s)/,"",$j);              #remove after a less than is found
                                                        n=split($j,cAux,/</);
                                                        aux[1][j]=cAux[1];
                                                        if(n==2)
                                                            aux[2][cAux[1]]=cAux[2];
                                                        else
                                                            aux[2][cAux[1]]="";
                                                    }
                                                }
/^%inv/                                         {
                                                    sub(/^(\s)*/,"",$2);
                                                    sub(/^(\s)*/,"",$3);
                                                    inv[$2]=$3;
                                                }
$1 !~/%inv/ && $1 !~ /%THE/ && $1 !~ /%dom/     { 
                                                    for(i=2;i<=NF;i++){
                                                        split($i,array,/\|/);
                                                        for(el in array){
                                                            print $1 " " aux[1][i] " " array[el];
                                                            if(aux[2][aux[1][i]]!="")
                                                                print array[el] " instance_of " aux[2][aux[1][i]];
                                                        }
                                                    }
                                                }
