#include "newtypes.h"

typedef struct list LinkedList;

/**
 * Creates and returns an empty list
 *
 * @return Empty list
 */
LinkedList *linkedlist();

/**
 * Returns the length of @param list
 *
 * @param list
 * @return Number of elements in @param list
 */
int list_length(LinkedList *list);

/**
 * Inserts an element at the tail of the list
 *
 * @param list
 * @param data
 * @return Pointer to the head of the list
 */
LinkedList *insert(LinkedList *list, Item data);

LinkedList *insert_head(LinkedList *list, Item data);

/**
 * Updates the data of @param node
 *
 * @param list
 * @param node
 * @param data
 */
void update(LinkedList *list, LinkedList *node, Item data);

/**
 * Removes an element from the list
 *
 * @param list
 * @param data
 * @return Pointer to the new head of the list or NIL
 */
LinkedList *remove(LinkedList *list, Item data);

LinkedList *remove_head(LinkedList *list);

LinkedList *clear(LinkedList *list);

/**
 * Searches an item from the list and returns it.
 *
 * @param list
 * @param id
 * @param get_id
 * @return Item from the list
 */
Item search_list(LinkedList *list, int id);

/**
 * Returns the element held by @param node
 *
 * @param node
 * @return Element of @param node
 */
Item get(LinkedList *node);

/**
 * Returns a pointer to the previous node of @param node
 *
 * @param node
 * @return Pointer to previous of @param node or nil
 */
LinkedList *prev(LinkedList *node);

/**
 * Returns a pointer to the next node of @param node
 *
 * @param node
 * @return Pointer to next of @param node or nil
 */
LinkedList *next(LinkedList *node);

/**
 * Returns the head of @param list
 *
 * @param list
 * @return Pointer to the first element of @param list
 */
LinkedList *head(LinkedList *list);

/**
 * Returns the tail of @param list
 *
 * @param list
 * @return Pointer to the last element of @param list
 */
LinkedList *tail(LinkedList *list);

LinkedList *append(LinkedList *a, LinkedList *b);
