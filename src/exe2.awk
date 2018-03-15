BEGIN                                           {IGNORECASE=1; FS=":"}
/^%THE/                                         {
                                                 n=split($1,cAux,/</);
                                                 if(n==2){
                                                     sub(/^(\s*)/,"",cAux[2]);
                                                     sub(/(\s*)$/,"",cAux[2]);
                                                     aux[2]["THE"]=cAux[2];
                                                 }else
                                                    aux[2]["THE"]="";
                                                 
                                                 for(j=2;j<=NF;j++){
                                                    n=split($j,cAux,/</);
                                                    sub(/^(\s*)/,"",cAux[1]);
                                                    sub(/(\s*)$/,"",cAux[1]);
                                                    aux[1][j]=cAux[1];
                                                    if(n==2){
                                                        sub(/^(\s*)/,"",cAux[2]);
                                                        sub(/(\s*)$/,"",cAux[2]);
                                                        aux[2][cAux[1]]=cAux[2];
                                                    }else
                                                        aux[2][cAux[1]]="";
                                                }
                                                }
/^%inv/                                         {
                                                    sub(/^(\s*)/,"",$2);
                                                    sub(/(\s*)$/,"",$2);
                                                    sub(/^(\s*)/,"",$3);
                                                    sub(/(\s*)$/,"",$3);
                                                    inv[$2]=$3;
                                                }
$1 !~/%inv/ && $1 !~ /%THE/ && $1 !~ /%dom/ && $0 !~ /^#/ && $0 != "" {
                                                 if(aux[2]["THE"]!=""){
                                                     sub(/^(\s*)/,"",$1);
                                                     sub(/(\s*)$/,"",$1);
                                                     print "(" $1 ", iof," aux[2]["THE"] ")";
                                                     print "(" aux[2]["THE"] ", inst," $1 ")";
                                                 }   
                                                 for(i=2;i<=NF;i++){
                                                    split($i,array,/\|/);
                                                    sub(/^(\s*)/,"",$1);
                                                    sub(/(\s*)$/,"",$1);
                                                    for(el in array){
                                                            sub(/^(\s*)/,"",array[el]);
                                                            sub(/(\s*)$/,"",array[el]);
                                                            if(array[el]!=""){
                                                                print "(" $1 ", " aux[1][i] ", " array[el] ")";
                                                                if(aux[2][aux[1][i]]!=""){
                                                                    print "(" array[el] ", iof," aux[2][aux[1][i]] ")";
                                                                    print "(" aux[2][aux[1][i]] ", inst," array[el] ")";
                                                                }
                                                            }   
                                                        }
                                                    }
                                                }
