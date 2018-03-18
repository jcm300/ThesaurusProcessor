BEGIN                                           {IGNORECASE=1; FS=":"}
/^%THE/                                         {
                                                    for(j=1;j<=NF;j++){
                                                        n=split($j,cAux,/</);
                                                        sub(/^(\s*)/,"",cAux[1]);
                                                        sub(/(\s*)$/,"",cAux[1]);
                                                        if(cAux[1] !~ /%THE/)relation[j]=cAux[1];
                                                        if(n==2){
                                                            sub(/^(\s*)/,"",cAux[2]);
                                                            sub(/(\s*)$/,"",cAux[2]);
                                                            class[j]=cAux[2];
                                                        }else
                                                            class[j]="";
                                                    }
                                                }
/^%inv/                                         {
                                                    sub(/^(\s*)/,"",$2);
                                                    sub(/(\s*)$/,"",$2);
                                                    sub(/^(\s*)/,"",$3);
                                                    sub(/(\s*)$/,"",$3);
                                                    inv[$2]=$3;
                                                }
/^%dom/                                         {
                                                    sub(/^(\s*)/,"",$2);
                                                    sub(/(\s*)$/,"",$2);
                                                    curDomain=$2;
                                                }
$1 !~/%inv/ && $1 !~ /%THE/ && $1 !~ /%dom/ && $0 !~ /^#/ && $0 != "" {
                                                sub(/^(\s*)/,"",$1);
                                                sub(/(\s*)$/,"",$1);
                                                if(class[1]!=""){
                                                    !triples["(" curDomain ", dom, " array[el] ")"]++;
                                                    !triples["(" array[el] ", voc, " curDomain ")"]++;
                                                    !triples["(" $1 ", iof, " class[1] ")"]++;
                                                    !triples["(" class[1] ", inst, " $1 ")"]++;
                                                }   
                                                for(i=2;i<=NF;i++){
                                                    split($i,array,/\|/);
                                                    for(el in array){
                                                        sub(/^(\s*)/,"",array[el]);
                                                        sub(/(\s*)$/,"",array[el]);
                                                        if(array[el]!=""){
                                                            !triples["(" curDomain ", dom, " array[el] ")"]++;
                                                            !triples["(" array[el] ", voc, " curDomain ")"]++;
                                                            !triples["(" $1 ", " relation[i] ", " array[el] ")"]++;
                                                            if(inv[relation[i]]!=""){
                                                                !triples["(" array[el] ", " inv[relation[i]] ", " $1 ")"]++;
                                                            }
                                                            if(class[i]!=""){
                                                                   !triples["(" array[el] ", iof, " class[i] ")"]++;
                                                                   !triples["(" class[i] ", inst, " array[el] ")"]++;
                                                            }
                                                        }   
                                                    }
                                                }
                                                }
END                                             {
                                                    for(triple in triples)
                                                        print triple
                                                }
