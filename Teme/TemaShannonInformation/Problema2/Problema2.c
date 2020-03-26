#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Arborele lui Huffman pentru caractere, folosind min heap

// compile:
// gcc -o Problema2 Problema2.c
// run:
// ./Problema2 tom_sawyer_intro_mini.txt

typedef struct _nod
{
    char val;
    int ap;
    double prob;
    struct _nod *st;
    struct _nod *dr;
} nod;

void heapify(nod **heap, int i)
{
    while (i > 0)
    {
        int parinte = i / 2;
        if (heap[i]->ap < heap[parinte]->ap)
        {
            nod *tmp = heap[i];
            heap[i] = heap[parinte];
            heap[parinte] = tmp;
        }
        i = parinte;
    }
}

nod *decapitare(nod **heap, int *heap_len)
{
    (*heap_len)--;
    int n = *heap_len;

    nod *tmp = heap[n];
    heap[n] = heap[0];
    heap[0] = tmp;

    int i = 0;
    while (i < n)
    {
        int st = 2 * i;
        int dr = 2 * i + 1;

        if (st >= n)
            break;

        if (dr >= n || heap[st]->ap < heap[dr]->ap)
        {
            if (heap[st]->ap >= heap[i]->ap)
            {
                break;
            }
            else
            {
                tmp = heap[st];
                heap[st] = heap[i];
                heap[i] = tmp;
                i = st;
            }
        }
        else
        {
            if (heap[dr]->ap >= heap[i]->ap)
            {
                break;
            }
            else
            {
                tmp = heap[dr];
                heap[dr] = heap[i];
                heap[i] = tmp;
                i = dr;
            }
        }
    }

    return heap[n];
}

void parcurgere_huffman(nod *huffman, char *cod, int i)
{
    if (huffman == NULL)
        return;

    if (huffman->val != 0)
    {
        printf("caracter=%c(%d) app=%d frecv=%f cod=%s\n", huffman->val, huffman->val, huffman->ap, huffman->prob, cod);
    }

    cod[i + 1] = '0';
    cod[i + 2] = '\0';
    parcurgere_huffman(huffman->st, cod, i + 1);
    cod[i + 1] = '1';
    cod[i + 2] = '\0';
    parcurgere_huffman(huffman->dr, cod, i + 1);
}

int main(int argc, char **argv)
{
    FILE *fhandle;
    int fisier_len;
    char *fisier_buffer;

    if (argc < 2)
    {
        printf("Mod de folosire: %s fisier ", argv[0]);
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

    int ap[256] = {0};
    for (int i = 0; i < fisier_len; i++)
    {
        ap[fisier_buffer[i]]++;
    }
    int heap_len = 0;
    for (int i = 0; i < 256; i++)
    {
        if (ap[i] > 0)
        {
            heap_len++;
        }
    }

    printf("%d caractere distincte\n", heap_len);
    nod **heap = calloc(heap_len, sizeof(nod *));

    int j = 0;
    for (int i = 0; i < 256; i++)
    {
        if (ap[i] > 0)
        {
            nod *arbore = malloc(sizeof(nod));
            arbore->dr = NULL;
            arbore->st = NULL;
            arbore->val = i;
            arbore->ap = ap[i];
            arbore->prob = (double)ap[i] / fisier_len;
            heap[j++] = arbore;
        }
    }
    for (int i = heap_len / 2; i < heap_len; i++)
    {
        heapify(heap, i);
    }

    while (heap_len > 1)
    {
        nod *arbore1 = decapitare(heap, &heap_len);
        nod *arbore2 = decapitare(heap, &heap_len);

        nod *arbore_nou = malloc(sizeof(nod));
        arbore_nou->val = 0;
        arbore_nou->prob = arbore1->prob + arbore2->prob;
        arbore_nou->ap = arbore1->ap + arbore2->ap;
        if (arbore1->ap < arbore2->ap)
        {
            arbore_nou->st = arbore1;
            arbore_nou->dr = arbore2;
        }
        else if (arbore1->ap > arbore2->ap)
        {
            arbore_nou->st = arbore2;
            arbore_nou->dr = arbore1;
        }
        else
        {
            if (arbore1->val == arbore2->val)
            {
                arbore_nou->st = arbore1;
                arbore_nou->dr = arbore2;
            }
            else if (arbore1->val == 0)
            {
                arbore_nou->st = arbore2;
                arbore_nou->dr = arbore1;
            }
            else
            {
                arbore_nou->st = arbore1;
                arbore_nou->dr = arbore2;
            }
        }

        heap[heap_len] = arbore_nou;
        heap_len++;
    }

    nod *huffman = heap[0];
    char cod[1024] = {0};

    parcurgere_huffman(huffman, cod, -1);
    return 0;
}