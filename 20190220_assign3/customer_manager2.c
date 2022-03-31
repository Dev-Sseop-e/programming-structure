#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "customer_manager.h"

/*----------------------------------------------------------------------
Uncomment and use the following code if you want
----------------------------------------------------------------------*/

#define UNIT_ARRAY_SIZE 1024

struct UserInfo {
  char *id;
  char *name;
  int purchase;              // purchase amount (> 0)
  struct UserInfo *nextOfId;
  struct UserInfo *nextOfName;
};

enum {BUCKET_COUNT = 1024};
struct HashTable_T {
  struct UserInfo *array[BUCKET_COUNT];
};

struct DB {
  struct HashTable_T *ht_id;
  struct HashTable_T *ht_name;
  int numItems;
};

/*--------------------------------------------------------------------*/
DB_T
CreateCustomerDB(void)
{
  DB_T d;
  d = (DB_T) calloc(1, sizeof(struct DB));  // Allocate a memory
  if (d == NULL) {
    fprintf(stderr, "Can't allocate a memory for DB_T\n");
    return NULL;
  }
  d->ht_id = (struct HashTable_T *)calloc(1, sizeof(struct HashTable_T));
  d->ht_name = (struct HashTable_T *)calloc(1, sizeof(struct HashTable_T));
  if (d->ht_id == NULL) {
    fprintf(stderr, "Can't allocate a memory for array of size %d\n", BUCKET_COUNT);
    free(d);
    return NULL;
  }
  if (d->ht_name == NULL) {
    fprintf(stderr, "Can't allocate a memory for array of size %d\n", BUCKET_COUNT);
    free(d);
    return NULL;
  }
  return d;
}
/*--------------------------------------------------------------------*/
enum {HASH_MULTIPLIER = 65599};
static int hash_function(const char *pcKey, int iBucketCount){
/* Return a hash code for pcKey that is between 0 and iBucketCount-1,
   inclusive. Adapted from the EE209 lecture notes. */
  int i;
  unsigned int uiHash = 0U;
  for (i = 0; pcKey[i] != '\0'; i++)
    uiHash = uiHash * (unsigned int)HASH_MULTIPLIER
             + (unsigned int)pcKey[i];
  return (int)(uiHash % (unsigned int)iBucketCount);
}
/*--------------------------------------------------------------------*/
void
DestroyCustomerDB(DB_T d)
{
  // check the element of d
  if(d != NULL && d->ht_id != NULL && d->ht_name != NULL &&
     d->ht_id->array != NULL && d->ht_name->array != NULL){
    // struct the searching pointer
    struct UserInfo *p_id;
    struct UserInfo *p_name;
    struct UserInfo *nextp_id;
    struct UserInfo *nextp_name;
    
    for(int i=0; i<BUCKET_COUNT; i++){
      for(p_id = d->ht_id->array[i]; p_id != NULL; p_id = nextp_id){
        nextp_id = p_id->nextOfId;
        free(p_id->id);
        free(p_id->name);
        free(p_id);
      }
    }
    for(int i=0; i<BUCKET_COUNT; i++){
      for(p_name = d->ht_name->array[i]; p_name != NULL; p_name = nextp_name){
        nextp_name = p_name->nextOfName;
        free(p_name); // free the remainder
      }
    }
    free(d->ht_id);
    free(d->ht_name);
    free(d);
  }
}
/*--------------------------------------------------------------------*/
int
RegisterCustomer(DB_T d, const char *id,
		 const char *name, const int purchase)
{
  // check the input
  if(name == NULL || id == NULL || d == NULL || purchase <= 0)
    return -1;

  const int h_id = hash_function(id, BUCKET_COUNT);
  const int h_name = hash_function(name, BUCKET_COUNT);

  struct UserInfo *search_id;
  for(search_id = d->ht_id->array[h_id]; search_id != NULL;
      search_id = search_id->nextOfId){
    if(strcmp(search_id->id, id) == 0) return -1; // failure
  }
  
  struct UserInfo *search_name;
  for(search_name = d->ht_name->array[h_name]; search_name != NULL;
      search_name = search_name->nextOfName){
    if(strcmp(search_name->name, name) == 0) return -1; // failure
  }
  // If it doesn't have duplication, allocate a memory
  struct UserInfo *add_customer = (struct UserInfo*)calloc(1, sizeof(struct UserInfo));
  // Allocate elements
  add_customer->id = strdup(id);
  add_customer->name = strdup(name);
  add_customer->purchase = purchase;

  if(d->ht_name->array[h_name] == NULL){
  // Array doesn't have any value
    d->ht_name->array[h_name] = add_customer;
    add_customer->nextOfName = NULL;
  }
  else{ // Else, insert the value to the first of array
    add_customer->nextOfName = d->ht_name->array[h_name];
    d->ht_name->array[h_name] = add_customer;
  }
  if(d->ht_id->array[h_id] == NULL){
  // Array doesn't have any value
    d->ht_id->array[h_id] = add_customer;
    add_customer->nextOfId = NULL;
  }
  else{ // Else, insert the value to the first of array
    add_customer->nextOfId = d->ht_id->array[h_id];
    d->ht_id->array[h_id] = add_customer;
  }
  d->numItems++;  // Add 1 at the numItems
  return 0;
}
/*--------------------------------------------------------------------*/
int
UnregisterCustomerByID(DB_T d, const char *id)
{
  if(d == NULL || id == NULL) return -1;
  // input check

  int h_id = hash_function(id, BUCKET_COUNT);

  if(d->ht_id->array[h_id]->id == NULL) return -1;  // failure
  // Compare the id
  else if(strcmp(d->ht_id->array[h_id]->id, id) == 0){
    char *name = d->ht_id->array[h_id]->name;
    int h_name = hash_function(name, BUCKET_COUNT);
    if(strcmp(d->ht_name->array[h_name]->name, name) == 0){
    // Compare the name
      free(d->ht_name->array[h_name]->name);
      free(d->ht_name->array[h_name]->id);
      free(d->ht_name->array[h_name]);
      d->ht_name->array[h_name] = NULL;
      d->ht_id->array[h_id] = NULL;
      return 0; // Success
    }
    else {
      // struct the searching pointer
      struct UserInfo *search_name;
      struct UserInfo *next_name;
      for(search_name = d->ht_name->array[h_name];
          search_name != NULL; search_name = next_name){
        next_name = search_name->nextOfName;
        if(strcmp(next_name->name, name) == 0){
          search_name->nextOfName = next_name->nextOfName;
          free(next_name->name);
          free(next_name->id);
          free(next_name);
          d->ht_id->array[h_id] = NULL;
          next_name = NULL;
          return 0; // Success
        }
      }
    }
  }
  else{
    // struct the searching pointer
    struct UserInfo *search_id;
    struct UserInfo *next_id;
    for(search_id = d->ht_id->array[h_id];
        search_id != NULL; search_id = next_id){
      next_id = search_id->nextOfId;
      if(next_id == NULL) return -1;  // failure
      if(strcmp(next_id->id, id) == 0){
      // compare the id
        char *name = next_id->name;
        int h_name = hash_function(name, BUCKET_COUNT);
        if(strcmp(d->ht_name->array[h_name]->name, name) == 0){
        // compare the name
          search_id->nextOfId = next_id->nextOfId;
          free(d->ht_name->array[h_name]->name);
          free(d->ht_name->array[h_name]->id);
          free(d->ht_name->array[h_name]);
          d->ht_name->array[h_name] = NULL;
          next_id = NULL;
          return 0; // Success
        }
        else {
          struct UserInfo *search_name;
          struct UserInfo *next_name;
          search_id->nextOfId = next_id->nextOfId;
          for(search_name = d->ht_name->array[h_name];
              search_name != NULL; search_name = next_name){
            next_name = search_name->nextOfName;
            if(strcmp(next_name->name, name) == 0){
            // compare the name
              search_name->nextOfName = next_name->nextOfName;
              search_id->nextOfId = next_id->nextOfName;
              free(next_name->name);
              free(next_name->id);
              free(next_name);
              next_id = NULL;
              next_name = NULL;
              return 0; // Success
            }
          }
        }
      }
    }
  }
  return -1;  // failure
}

/*--------------------------------------------------------------------*/
int
UnregisterCustomerByName(DB_T d, const char *name)
{
  if(d == NULL || name == NULL) return -1;
  // input check

  int h_name = hash_function(name, BUCKET_COUNT);

  if(d->ht_name->array[h_name]->name == NULL) return -1;
  // Compare the name
  else if(strcmp(d->ht_name->array[h_name]->name, name) == 0){
    char *id = d->ht_name->array[h_name]->id;
    int h_id = hash_function(id, BUCKET_COUNT);
    if(strcmp(d->ht_id->array[h_id]->id, id) == 0){
    // Compare the id
      free(d->ht_id->array[h_id]->id);
      free(d->ht_id->array[h_id]->name);
      free(d->ht_id->array[h_id]);
      d->ht_name->array[h_name] = NULL;
      d->ht_id->array[h_id] = NULL;
      return 0; // Success
    }
    else {
      // struct the searching pointer
      struct UserInfo *search_id;
      struct UserInfo *next_id;
      for(search_id = d->ht_id->array[h_id];
          search_id != NULL; search_id = next_id){
        next_id = search_id->nextOfId;
        if(strcmp(next_id->id, id) == 0){
          search_id->nextOfId = next_id->nextOfId;
          free(next_id->id);
          free(next_id->name);
          free(next_id);
          d->ht_name->array[h_name] = NULL;
          next_id = NULL;
          return 0; // Success
        }
      }
    }
  }
  else{
    // struct the searching pointer
    struct UserInfo *search_name;
    struct UserInfo *next_name;
    for(search_name = d->ht_name->array[h_name];
        search_name != NULL; search_name = next_name){
      next_name = search_name->nextOfName;
      if(next_name == NULL) return -1;  // failure
      if(strcmp(next_name->name, name) == 0){
      // compare the name
        char *id = next_name->id;
        int h_id = hash_function(id, BUCKET_COUNT);
        if(strcmp(d->ht_id->array[h_id]->id, id) == 0){
        // compare the id
          search_name->nextOfName = next_name->nextOfName;
          free(d->ht_id->array[h_id]->id);
          free(d->ht_id->array[h_id]->name);
          free(d->ht_id->array[h_id]);
          d->ht_id->array[h_id] = NULL;
          next_name = NULL;
          return 0; // Success
        }
        else {
          struct UserInfo *search_id;
          struct UserInfo *next_id;
          for(search_id = d->ht_id->array[h_id];
              search_id != NULL; search_id = next_id){
            next_id = search_id->nextOfId;
            if(strcmp(next_id->id, id) == 0){
            // compare the id
              search_name->nextOfName = next_name->nextOfName;
              search_id->nextOfId = next_id->nextOfId;
              free(next_id->id);
              free(next_id->name);
              free(next_id);
              next_id = NULL;
              next_name = NULL;
              return 0; // Success
            }
          }
        }
      }
    }
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByID(DB_T d, const char* id)
{
  if(d == NULL || id == NULL) return -1;
  // input check

  int h_id = hash_function(id, BUCKET_COUNT);
  struct UserInfo *p;
  // struct the searching pointer
  for(p = d->ht_id->array[h_id]; p != NULL; p = p->nextOfId){
    if(strcmp(p->id, id) == 0) return p->purchase;
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByName(DB_T d, const char* name)
{
  if(d == NULL || name == NULL) return -1;
  // input check

  int h_name = hash_function(name, BUCKET_COUNT);
  struct UserInfo *p;
  // struct the searching pointer
  for(p = d->ht_name->array[h_name]; p != NULL; p = p->nextOfName){
    if(strcmp(p->name, name) == 0) return p->purchase;
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetSumCustomerPurchase(DB_T d, FUNCPTR_T fp)
{
  if(d == NULL || fp == NULL) return -1;
  // input check

  int sum = 0;
  for(int i=0; i<BUCKET_COUNT; i++){
    for(struct UserInfo *search = d->ht_id->array[i];
        search != NULL; search = search->nextOfId){
      sum += (*fp)(search->id, search->name, search->purchase);
    }
  }
  
  return sum;
}