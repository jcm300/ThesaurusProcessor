BEGIN           {IGNORECASE=1}
{
    sub(/^\(/,"",$0);
    sub(/\)$/,"",$0);
    split($0,triple,",");
}
