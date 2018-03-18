BEGIN           {IGNORECASE=1}
{
    sub(/^\(/,"",$0);
    sub(/\)$/,"",$0);
    split($0,triple,",");
    sub(/^\s/,"",triple[1]);
    sub(/\s$/,"",triple[1]);
    sub(/^\s/,"",triple[3]);
    sub(/\s$/,"",triple[3]);
    triples[i]=triple[1] "," triple[3];
    i++;
    !ind[triple[1]]++;
}
END {
    for(x in triples){
        split(triples[x],aux,",");
        if(create[aux[1]]==""){
            print "<meta charset=\"utf-8\">" >> aux[1] ".html";
            !create[aux[1]]++;
        }
        if(ind[aux[2]]!="") print "<li><a href=\"" aux[2] ".html\">" aux[2] "</a></li>" >> aux[1] ".html"
        else print "<li>" aux[2] "</li>" >> aux[1] ".html"
    }
}
