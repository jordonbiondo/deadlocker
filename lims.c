#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <sys/types.h> 
#include <sys/wait.h> 
#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/types.h> 
#include <sys/ipc.h> 
#include <sys/sem.h>
#include <errno.h>
#include <string.h>

#include "lims.h"

/**
 * Create a new mutex
 */
int mutex_new() {
  int this = semget(IPC_PRIVATE, 1 ,00600);
  if (this > 0) semctl(this, 0, SETVAL, 1);
  return this;
}

int mutex_get(int key) {
  int this = semget(key, 1 ,00600);
  if (this > 0) semctl(this, 0, SETVAL, 1);
  return this;
}



/**
 * Get rid of a mutex
 */
int mutex_destroy(mutex this) {
  return semctl(this, 0, IPC_RMID);
}


/**
 * Wait for your turn to own the mutex;
 */
int mutex_mine(mutex this) {
  struct sembuf buf = {
    .sem_num = 0,
    .sem_op = -1,
    .sem_flg = 0
  };
  return semop(this, &buf, 1);
}


/**
 * Yield the mutex to others
 */
int mutex_theirs(mutex this) {
  struct sembuf buf = {
    .sem_num = 0,
    .sem_op = 1,
    .sem_flg = 0
  };
  return semop(this, &buf, 1);
}

/**
 * Exit on error, used by with_mutex
 */
int assert_mutex_state(int state) {
  if (state < 0) {
    perror("Mutex failure: ");
    perror(strerror(errno));
    puts("\n");
    exit(errno);
  }
  return 0;
}
