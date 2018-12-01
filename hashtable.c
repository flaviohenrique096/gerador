#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include "linkedlist.h"
#include "hashtable.h"

typedef struct elm Element;

struct elm {
    char key[50];
    void *value;
};

struct ht {
    int size;
    LinkedList **index;
};

Element *element(char *key, void *value) {
    Element *elm = (Element*)calloc(1, sizeof(Element));
    strcpy(elm->key, key);
    elm->value = value;
    return elm;
}

HashTable *hashtable(int size) {
    int i;
    HashTable *table = (HashTable*)calloc(1, sizeof(HashTable));
    table->size = size;
    table->index = (LinkedList**)calloc(size, sizeof(LinkedList*));
    for(i = 0; i < size; i++) table->index[i] = linkedlist();
    return table;
}

int hash(HashTable *table, char *key) {
    int i = 0;
    unsigned long int value = 0;
    int primes[50] = {11,13,17,19,23,29,31,37,41,43,
                      47,53,59,61,67,71,73,79,83,89,
                      97,101,103,107,109,113,127,131,137,139,
                      149,151,157,163,167,173,179,181,191,193,
                      197,199,211,223,227,229,233,239,241,251};
    while(value < ULONG_MAX && i < strlen(key)) {
        value <<= sizeof(int);
        value += key[i] * primes[i];
        i++;
    }
    return (int)(value % table->size);
}

void set(HashTable *table, char *key, void *value) {
    int i = hash(table, key);
    table->index[i] = insert(table->index[i], element(key, value));
}

char *key(HashTable *table, void *value) {
    int i;
    LinkedList *aux, *l = linkedlist();
    for(i = 0; i < table->size; i++)
        for(aux = table->index[i]; aux != NULL; aux = next(aux))
            if(((Element*)get(aux))->key != NULL)
                if(((Element*)get(aux))->value == value)
                    return ((Element*)get(aux))->key;
	return NULL;
}

void *value(HashTable *table, char *key) {
    int i = hash(table, key);
    LinkedList *aux;
    for(aux = table->index[i]; aux != NULL; aux = next(aux))
        if(((Element*)get(aux))->key != NULL)
            if(strcmp(((Element*)get(aux))->key, key) == 0)
                return ((Element*)get(aux))->value;
	return NULL;
}

void unset(HashTable *table, char *key) {
    int i = hash(table, key);
    LinkedList *aux;
    for(aux = table->index[i]; aux != NULL; aux = next(aux))
        if(strcmp(((Element*)get(aux))->key, key) == 0)
            remove(table->index[i], get(aux));
}

void reset(HashTable *table, char *key, void *data) {
    int i = hash(table, key);
    LinkedList *aux;
    for(aux = table->index[i]; aux != NULL; aux = next(aux))
        if(strcmp(((Element*)get(aux))->key, key) == 0)
            update(table->index[i], aux, element(key, data));
}

LinkedList *table_to_list(HashTable *table) {
    int i;
    LinkedList *l, *res = linkedlist();
    for(i = 0; i < table->size; i++)
        for(l = table->index[i]; l != NULL; l = next(l))
            res = insert(res, get(l));
    return res;
}
