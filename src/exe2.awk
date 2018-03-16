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
$1 !~/%inv/ && $1 !~ /%THE/ && $1 !~ /%dom/ && $0 !~ /^#/ && $0 != "" {
                                                sub(/^(\s*)/,"",$1);
                                                sub(/(\s*)$/,"",$1);
                                                if(class[1]!=""){
                                                    print "(" $1 ", iof," class[1] ")";
                                                    print "(" class[1] ", inst," $1 ")";
                                                }   
                                                for(i=2;i<=NF;i++){
                                                    split($i,array,/\|/);
                                                    for(el in array){
                                                        sub(/^(\s*)/,"",array[el]);
                                                        sub(/(\s*)$/,"",array[el]);
                                                        if(array[el]!=""){
                                                            print "(" $1 ", " relation[i] ", " array[el] ")";
                                                            if(inv[relation[i]]!=""){
                                                                print "(" array[el] ", " inv[relation[i]] ", " $1 ")";
                                                            }
                                                            if(class[relation[i]]!=""){
                                                                   print "(" array[el] ", iof," class[relation[i]] ")";
                                                                   print "(" class[relation[i]] ", inst," array[el] ")";
                                                            }
                                                        }   
                                                    }
                                                }
                                                }
