/* lims.h --- 
 * 
 * Filename: lims.h
 * Description: 
 * Author: Jordon Biondo <biondoj@mail.gvsu.edu>
 * Created: Mon Oct 28 10:17:20 2013 (-0400)
 * Version: 
 * Last-Updated: Thu Oct 31 10:15:03 2013 (-0400)
 *           By: Jordon Biondo
 *     Update #: 6
 * URL: 
 * Doc URL: 
 * Keywords: 
 * Compatibility: c99
 * 
 */

/* Change Log:
 * 
 * 
 */

/* This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth
 * Floor, Boston, MA 02110-1301, USA.
 */

/* Code: */


#ifndef LIMS_H
#define LIMS_H

/**
 * Mutex type, same as semaphore id
 */
typedef int mutex;

/**
 * Create a mutex
 */
int mutex_new(void);

/**
 * Destroy a mutex
 */
int mutex_destroy(mutex this);

/**
 * Wait your turn
 */
int mutex_mine(mutex this);

/**
 * Yield the mutex
 */
int mutex_theirs(mutex this);

/**
 * with_mutex helper
 */
int assert_mutex_state(int state);

/**
 * Mutex block
 */
#define with_mutex(mut)							\
  for(int WITH_MUTEX_HELPER__dont_you_dare_modify_me__ = mutex_mine(mut); \
      (assert_mutex_state(WITH_MUTEX_HELPER__dont_you_dare_modify_me__) == 0 &&	\
       WITH_MUTEX_HELPER__dont_you_dare_modify_me__++ != 1);		\
      mutex_theirs(mut))


#endif /* LIMS_H */










