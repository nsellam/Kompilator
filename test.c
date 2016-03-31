int main()
{ int i,j,k,r;
    i = 3;
    j = 4;
    k = 8;
    printf(i);
    r = i + j * i + (k - j)/j;
    printf(r);
    j = k;
    printf(j);
    r = r / j;
    printf(r);
}
/*
{ int i,j,k,r;
    i = 3;
    j = 4;
    k = 8;
    printf(i);
    r = (i + j)* (i + k / j);
    printf(r);
}
*/
