#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "customer_manager.h"

/*----------------------------------------------------------------------
Uncomment and use the following code if you want
----------------------------------------------------------------------*/

#define UNIT_ARRAY_SIZE 64

struct UserInfo {
  char *name;                // customer name
  char *id;                  // customer id
  int purchase;              // purchase amount (> 0)
};

struct DB {
  struct UserInfo *pArray;   // pointer to the array
  int curArrSize;            // current array size (max # of elements)
  int numItems;              // # of stored items, needed to determine
			     // # whether the array should be expanded
			     // # or not
};

/*--------------------------------------------------------------------*/
DB_T
CreateCustomerDB(void)
{
  DB_T d;
  d = (DB_T) calloc(1, sizeof(struct DB));
  if (d == NULL) {
    fprintf(stderr, "Can't allocate a memory for DB_T\n");
    return NULL;
  }
  d->curArrSize = UNIT_ARRAY_SIZE; // start with 64 elements
  d->pArray = (struct UserInfo *)calloc(d->curArrSize,
               sizeof(struct UserInfo));
  if (d->pArray == NULL) {
    fprintf(stderr, "Can't allocate a memory for array of size %d\n",
	    d->curArrSize);
    free(d);
    return NULL;
  }
  return d;
}
/*--------------------------------------------------------------------*/
void
DestroyCustomerDB(DB_T d)
{
  /* fill out this function */
  if(d != NULL && d->pArray != NULL){
    for(int i=0; i<d->curArrSize; i++){
      free(d->pArray[i].name);
      free(d->pArray[i].id);
    }
  free(d->pArray);
  free(d);
  }
}
/*--------------------------------------------------------------------*/
int
RegisterCustomer(DB_T d, const char *id,
		 const char *name, const int purchase)
{
  /* fill out this function */
  if(name == NULL || id == NULL || d == NULL || purchase <= 0) return -1;

  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].name != NULL || d->pArray[i].id != NULL){
      if(strcmp(d->pArray[i].name, name) == 0 || strcmp(d->pArray[i].id, id) == 0) return -1;
    }
  }
  for(int j=0; j<d->curArrSize; j++){
    if(d->pArray[j].name == NULL && d->pArray[j].id == NULL) {
      d->pArray[j].name = strdup(name);
      d->pArray[j].id = strdup(id);
      d->pArray[j].purchase = purchase;
      free(strdup(name));
      free(strdup(id));
      break;
    }
    if(j == d->curArrSize-1){
      d->pArray = (struct UserInfo*)realloc(d->pArray, 2*(d->curArrSize)*sizeof(struct UserInfo));
      d->pArray[d->curArrSize].name = strdup(name);
      d->pArray[d->curArrSize].id = strdup(id);
      d->pArray[d->curArrSize].purchase = purchase;
      d->curArrSize = 2*(d->curArrSize);
      break;
    }
  }
  d->numItems++;
  return 0;
}
/*--------------------------------------------------------------------*/
int
UnregisterCustomerByID(DB_T d, const char *id)
{
  /* fill out this function */
  if(d == NULL || id == NULL) return -1;

  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].id != NULL) {
      if(strcmp(d->pArray[i].id, id) == 0) {
        free(d->pArray[i].name);
        free(d->pArray[i].id);
        d->pArray[i].name = NULL;
        d->pArray[i].id = NULL;
        d->numItems--;
        return 0;
      }
    }
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
UnregisterCustomerByName(DB_T d, const char *name)
{
  /* fill out this function */
  if(d == NULL || name == NULL) return -1;

  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].name != NULL) {
      if(strcmp(d->pArray[i].name, name) == 0) {
        free(d->pArray[i].name);
        free(d->pArray[i].id);
        d->pArray[i].name = NULL;
        d->pArray[i].id = NULL;
        d->numItems--;
        return 0;
      }
    }
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByID(DB_T d, const char* id)
{
  /* fill out this function */
  if(d == NULL || id == NULL) return -1;

  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].id != NULL) {
      if(strcmp(d->pArray[i].id, id) == 0) {
        return d->pArray[i].purchase;
      }
    }
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetPurchaseByName(DB_T d, const char* name)
{
  /* fill out this function */
  if(d == NULL || name == NULL) return -1;

  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].name != NULL) {
      if(strcmp(d->pArray[i].name, name) == 0) {
        return d->pArray[i].purchase;
      }
    }
  }
  return -1;
}
/*--------------------------------------------------------------------*/
int
GetSumCustomerPurchase(DB_T d, FUNCPTR_T fp)
{
  /* fill out this function */
  if(d == NULL || fp == NULL) return -1;

  int sum = 0;
  for(int i=0; i<d->curArrSize; i++){
    if(d->pArray[i].name != NULL && d->pArray[i].id != NULL)
    sum += (*fp)(d->pArray[i].id, d->pArray[i].name, d->pArray[i].purchase);
  }
  return sum;
}
//Compile : gcc209 -D_GNU_SOURCE -o testclient1 testclient.c customer_manager1.c