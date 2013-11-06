#include <pthread.h>
#include <stdbool.h>

#ifndef DEADLOCKER_H
#define DEADLOCKER_H

#define PROC_LIMIT 32
#define RESOURCE_LIMIT 32

typedef struct {
  int id;
  int owner;
} resource;

typedef struct {
  pthread_t worker;
  pthread_t messager;
  bool requesting[RESOURCE_LIMIT];
  bool owning[RESOURCE_LIMIT];
} sim_process;

/**
 * List of procs
 */
sim_process procs[PROC_LIMIT];

/**
 * List of available resources
 */
resource resources[RESOURCE_LIMIT];

/**
 * Initialize the procs array
 */
bool init_procs(void);

/**
 * Initialize the resource array
 */
bool init_resources(void);

/**
 * Cleanup the memory of procs
 */
bool clean_procs(void);

/**
 * PROC owns RESOURCE
 */
bool assign_owner(int proc, int resource);

/**
 * Declare that PROC is requesting RESOURCE
 */
bool request_ownership(int proc, int resource);

/**
 * Is PROC requresting RESOURCE?
 */
bool proc_is_requesting(int proc, int resource);

/**
 * Is PROC owning RESOURCE?
 */
bool proc_is_owning(int proc, int resource);
  
/**
 * Main entry point 
 */
void entrypoint(int argc, char* argv[]);

#endif












