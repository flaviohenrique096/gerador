#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "newtypes.h"
#include "linkedlist.h"

/**
 * This is the definition of a node of the linked list. Each node has: a
 * void pointer to an arbitrary element that is to be held by the node,
 * a pointer to the previous node and a pointer to the next node.
 */
struct list {
    Item data;
    LinkedList *prev;
    LinkedList *next;
};

/**
 * This function returns an empty list, represented by the nil value.
 *
 * @return Empty list
 */
LinkedList *linkedlist() {
    return NULL;
}

/**
 * Returns the number of elements in @param list
 *
 * @param list
 * @return Length of @param list
 */
int list_length(LinkedList *list) {
    if(list == NULL) return 0;
    return 1 + list_length(next(list));
}

/**
 * This recursive function inserts @param data at the tail of @param list.
 * If @param list is empty, it just inserts in the list.
 *
 * @param list
 * @param data
 * @return Pointer to the head of the list
 */
LinkedList *insert(LinkedList *list, Item data) {
    if(list == NULL) {
        list = (LinkedList*)calloc(1, sizeof(LinkedList));
        list->data = data;
        list->prev = NULL;
        list->next = NULL;
        return list;
    }
    else if(next(list) == NULL) {
        list->next = (LinkedList*)calloc(1, sizeof(LinkedList));
        list->next->data = data;
        list->next->prev = list;
        list->next->next = NULL;
        return head(list);
    } else return insert(next(list), data);
}

LinkedList *insert_head(LinkedList *list, Item data) {
	if(list == NULL) {
		list = (LinkedList*)calloc(1, sizeof(LinkedList));
        list->data = data;
        list->prev = NULL;
        list->next = NULL;
	} else {
		list->prev = (LinkedList*)calloc(1, sizeof(LinkedList));
        list->prev->data = data;
		list->prev->prev = NULL;
        list->prev->next = list;
		list = list->prev;
	}
	return list;
}

/**
 * This recursive function updates the data of @param node to @param data.
 *
 * @param list
 * @param node
 * @param data
 */
void update(LinkedList *list, LinkedList *node, Item data) {
    if(list == NULL) return;
    if(list == node) list->data = data;
    else update(next(list), node, data);
}

/**
 * This recursive function deletes the node holding @param data from @param list.
 *
 * @param list
 * @param data
 * @return Pointer to the new head of the list or NIL
 */
LinkedList *remove(LinkedList *list, Item data) {
    if(list == NULL) return NULL;
    if(get(list) == data) {
        if(prev(list) == NULL && next(list) == NULL) {
            free(list);
            list = NULL;
            return list;
        }
        else if(prev(list) == NULL) {
            list = next(list);
            free(prev(list));
            list->prev = NULL;
            return list;
        }
        else if(next(list) == NULL) {
            list = prev(list);
            free(next(list));
            list->next = NULL;
            return head(list);
        }
        else {
            list->prev->next = next(list);
            list->next->prev = prev(list);
            free(list);
            return head(list);
        }
    } else return remove(next(list), data);
}

LinkedList *remove_head(LinkedList *list) {
	if(list == NULL) return NULL;
	if(prev(list) == NULL && next(list) == NULL) {
		free(list);
		list = NULL;
	} else {
		list = next(list);
		free(list->prev);
		list->prev = NULL;
	}
	return list;
}

LinkedList *clear(LinkedList *list) {
	for(list = list->next; list->next != NULL; list = next(list))
		free(list->prev);
	free(list);
	list = NULL;
	return list;
}

/**
 * Searches an item from the list and returns it.
 *
 * @param list
 * @param id
 * @param get_id
 * @return Item from the list
 */
Item search_list(LinkedList *list, int id) {
    if(list == NULL) return NULL;
    if(get(list) == id) return get(list);
    return search_list(next(list), id);
}

/**
 * This function returns the data of @param node.
 *
 * @param node
 * @return Element of @param node
 */
Item get(LinkedList *node) {
    return node->data;
}

/**
 * This function returns the previous node of @param node.
 *
 * @param node
 * @return Pointer to the previous node of @param node
 */
LinkedList *prev(LinkedList *node) {
    if(node == NULL) return NULL;
    return node->prev;
}

/**
 * This function returns the subsequent node of @param node.
 *
 * @param node
 * @return Pointer to the subsequent node of @param node
 */
LinkedList *next(LinkedList *node) {
    if(node == NULL) return NULL;
    return node->next;
}

/**
 * This function returns the head of @param list
 * whether or not @param list is indeed the first node.
 *
 * @param list
 * @return Pointer to the head of @param list
 */
LinkedList *head(LinkedList *list) {
    if(list == NULL) return NULL;
    if(prev(list) == NULL) return list;
    return head(prev(list));
}

/**
 * This function returns the tail of @param list
 * whether or not @param list is indeed the last node.
 *
 * @param list
 * @return Pointer to the tail of @param list
 */
LinkedList *tail(LinkedList *list) {
    if(list == NULL) return NULL;
    if(next(list) == NULL) return list;
    return tail(next(list));
}

LinkedList *append(LinkedList *a, LinkedList *b) {
    LinkedList *res;
    if(a != NULL && b != NULL) {
        ((LinkedList*)tail(a))->next = b;
        ((LinkedList*)head(b))->prev = tail(a);
        return a;
    }
    if(a == NULL) return b;
    return a;
}