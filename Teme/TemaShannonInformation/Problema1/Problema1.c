#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>

//Structura folosita pentru implementarea unui tabel de dispersie
typedef struct _nod
{
    char *val;
    int ap;
    double prob;
    struct _nod *urm;
} nod;

unsigned long hash(unsigned char *str, unsigned char *str_finish) // functia de hash
{
    unsigned long hash = 5381;
    char c;

    while (str != str_finish && (c = *str))
    {
        hash = ((hash << 5) + hash) + c;
        str++;
    }

    return hash;
}

void sub_ab(char *fisier_buffer, int fisier_len, nod **htable, int htable_len, int lungime_str)
{
    for (int i = 0; i < fisier_len; i += lungime_str)
    {
        unsigned long h = hash(fisier_buffer + i, fisier_buffer + i + lungime_str);
        int idx = h % htable_len;
        if (htable[idx] == NULL) // prima aparitie a grupului de lungime_str litere
        {
            htable[idx] = malloc(sizeof(nod));
            htable[idx][0].val = malloc((lungime_str + 1) * sizeof(char));
            for (int j = 0; j < lungime_str; j++)
            {
                htable[idx][0].val[j] = fisier_buffer[i + j];
            }
            htable[idx][0].val[lungime_str] = '\0';
            htable[idx][0].ap = 1;
            htable[idx][0].prob = 0;
            htable[idx][0].urm = NULL;
            //puts(htable[idx][0].val);
        }
        else
        {
            nod *p = htable[idx];
            nod *last_p;
            while (p && strncmp(p->val, fisier_buffer + i, lungime_str) != 0)
            {
                last_p = p;
                p = p->urm;
            }
            if (p == NULL)
            {
                last_p->urm = malloc(sizeof(nod));
                last_p->val = malloc((lungime_str + 1) * sizeof(char));
                for (int j = 0; j < lungime_str; j++)
                {
                    last_p->val[j] = fisier_buffer[i + j];
                }
                last_p->val[lungime_str] = '\0';
                last_p->ap = 1;
                last_p->prob = 0;
                last_p->urm = NULL;
                //puts(last_p->val);
            }
            else
            {
                p->ap++;
                //printf("%s nr ap: %d\n", p->val, p->ap);
            }
        }
    }
}

void sub_a(char *fisier_buffer, int fisier_len, nod **htable, int htable_len)
{
    sub_ab(fisier_buffer, fisier_len, htable, htable_len, 2);
}

void sub_b(char *fisier_buffer, int fisier_len, nod **htable, int htable_len)
{
    sub_ab(fisier_buffer, fisier_len, htable, htable_len, 3);
}

void sub_c(char *fisier_buffer, int fisier_len, nod **htable, int htable_len)
{
    int last_i = -1;
    for (int i = 0; i < fisier_len; i++)
    {
        if (fisier_buffer[i] == ' ')
        {
            if (i != last_i - 1)
            {
                unsigned long h = hash(fisier_buffer + last_i + 1, fisier_buffer + i - 1);
                int idx = h % htable_len;
                int lungime_str = i - last_i - 1;
                if (htable[idx] == NULL) // prima aparitie a grupului de lungime_str litere
                {
                    htable[idx] = malloc(sizeof(nod));
                    htable[idx][0].val = malloc((lungime_str + 1) * sizeof(char));
                    for (int j = 0; j < lungime_str; j++)
                    {
                        htable[idx][0].val[j] = fisier_buffer[last_i + 1 + j];
                    }
                    htable[idx][0].val[lungime_str] = '\0';
                    htable[idx][0].ap = 1;
                    htable[idx][0].prob = 0;
                    htable[idx][0].urm = NULL;
                }
                else
                {
                    nod *p = htable[idx];
                    nod *last_p;
                    while (p && strncmp(p->val, fisier_buffer + last_i + 1, lungime_str) != 0)
                    {
                        last_p = p;
                        p = p->urm;
                    }
                    if (p == NULL)
                    {
                        last_p->urm = malloc(sizeof(nod));
                        last_p->urm->val = malloc((lungime_str + 1) * sizeof(char));
                        for (int j = 0; j < lungime_str; j++)
                        {
                            last_p->urm->val[j] = fisier_buffer[last_i + 1 + j];
                        }
                        last_p->urm->val[lungime_str] = '\0';
                        last_p->urm->ap = 1;
                        last_p->urm->prob = 0;
                        last_p->urm->urm = NULL;
                    }
                    else
                    {
                        p->ap++;
                        //printf("%s nr ap: %d\n", p->val, p->ap);
                    }
                }
            }
            last_i = i;
        }
    }
}

int main(int argc, char **argv)
{
    FILE *fhandle;
    int fisier_len;
    char *fisier_buffer;
    char subpunct;

    if (argc != 3)
    {
        printf("Mod de folosire: %s fisier subpunct", argv[0]);
        return -1;
    }
    subpunct = tolower(argv[2][0]);
    if (subpunct < 'a' || subpunct > 'c')
    {
        puts("Subpunctele sunt: a, b sau c");
        return -1;
    }
    fhandle = fopen(argv[1], "r");
    if (!fhandle)
    {
        puts("Eroare citire fisier");
        return -1;
    }

    fseek(fhandle, 0, SEEK_END);
    fisier_len = ftell(fhandle);
    rewind(fhandle);

    if ((fisier_buffer = malloc(fisier_len * sizeof(char))) == NULL)
    {
        puts("Eroare alocare memorie");
        return -1;
    }
    fread(fisier_buffer, fisier_len, 1, fhandle);
    fclose(fhandle);

    //alocam in memorie tabelul de dispersie
    nod **htable;
    int htable_len = fisier_len / sizeof(nod *);
    if (htable_len % 2 == 0)
        htable_len++;
    if ((htable = calloc(htable_len, sizeof(nod *))) == NULL)
    {
        puts("Eroare alocare memorie");
        return -1;
    }

    if (subpunct == 'a')
    {
        sub_a(fisier_buffer, fisier_len, htable, htable_len);
    }
    else if (subpunct == 'b')
    {
        sub_b(fisier_buffer, fisier_len, htable, htable_len);
    }
    else
    {
        sub_c(fisier_buffer, fisier_len, htable, htable_len);
    }

    free(fisier_buffer);
    return 0;
}