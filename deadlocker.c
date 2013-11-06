#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "deadlocker.h"


bool init_procs(void) {
  static bool happened = false;
  if (!happened) {
    for (int i = 0; i < PROC_LIMIT; i++) {
      for (int j = 0; j < RESOURCE_LIMIT; j++) {
	procs[i].owning[j] = false;
	procs[i].requesting[j] = false;
      }
    }
    happened = true;
    return true;
  } else {
    return false;
  }
}


bool init_resources(void) {
  static bool happened = false;
  if (!happened) {
    for (int i = 0; i < RESOURCE_LIMIT; i++) {
      resources[i].id = i+1;
      resources[i].owner = -1;
    }
    happened = true;
    return true;
  } else {
    return false;
  }
}


bool clean_procs(void) {
  static bool happened = false;
  if (!happened) {
    for (int i = 0; i < PROC_LIMIT; i++) {
      // fill me in
    }
    happened = true;
    return true;
  } else {
    return false;
  }
}

/**
 * PROC owns RESOURCE
 */
bool assign_owner(int proc, int resource){
  resources[resource].owner = proc;
  procs[proc].owning[resource] = true;
  return true;
}

/**
 * Declare that PROC is requesting RESOURCE
 */
bool request_ownership(int proc, int resource){
  procs[proc].requesting[resource] = true;
  return true;
}

bool proc_is_requesting(int proc, int resource) {
  return procs[proc].requesting[resource];
}

bool proc_is_owning(int proc, int resource) {
  return procs[proc].owning[resource];
}


void entrypoint(int argc, char* argv[]) {
  printf("here!\n");
  for (int i = 0; i < RESOURCE_LIMIT; i++) {
    printf("%d: %d\n", i, resources[i].owner);
  }
}

