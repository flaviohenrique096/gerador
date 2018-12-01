#include "linkedlist.h"

typedef struct ht HashTable;

/**
 * Creates a hash table with @param size rows.
 *
 * @param size
 * @return Pointer to the hash table
 */
HashTable *hashtable(int size);

/**
 * Adds an element to the table.
 *
 * @param table
 * @param key
 * @param value
 */
void set(HashTable *table, char *key, void *value);

/**
 * Returns the key of a given value.
 *
 * @param table
 * @param value
 * @return Key of the value
 */
char *key(HashTable *table, void *value);

/**
 * Given a key, returns its value.
 *
 * @param table
 * @param key
 * @return Value associated to the key
 */
void *value(HashTable *table, char *key);

/**
 * Removes an item from the table.
 *
 * @param table
 * @param key
 */
void unset(HashTable *table, char *key);

/**
 * Updates the value of the key-value pair at the table.
 *
 * @param table
 * @param key
 * @param data
 */
void reset(HashTable *table, char *key, void *data);

LinkedList *table_to_list(HashTable *table);