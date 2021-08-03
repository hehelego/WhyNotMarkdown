# note on the bounded buffer problem

> the bounded buffer problem also known as the producer-consumer problem.

## the scenario

The producers and the consumers communicate via a bounded-buffer (a queue of fixed capacity).  
Each producer repeatedly generate message and put it into the queue,
while every consumer continously fetch message from the queue.  
When an producer attempt to add an element to the full buffer, it is blocked until there is enough space.
Similarly, when the buffer is empty and a consumer try to get data from a empty buffer, it waits until there is new message available.  

## a problematic unsynchronized implementation

```python
# global bounded-buffer queue
def Producer():
  while True:
    elem = produce()
    while queue.full():
      sleep(push_delay)
    queue.push(elem)
def Consumer():
  while True:
    while queue.empty():
      sleep(pop_delay)
    elem = queue.pop()
    consume(elem)
```

1. **the producers are not synchronized**.  
   A produce `p` leaves the while loop.  
   Before he put the `elem` into the queue, other consumers filled the buffer.  
   `p` puts `i` into the queue, causing buffer overflow.
2. **the consumers are not synchronized**.  
   Multiple consumers can leave the while loop, before any one of them fetch an element from the queue.  
   However, they would not wait if other consumer had already take the last element from the queue,
   which may lead to buffer underflow.

Q: How to fix the code?  
A: Use mutex (mutual exclusion) to protect the queue.  
Thus, only one process is permitted to read from or write to the queue at any moment.

## spin-waiting

```python
# global bounded-buffer queue
# global mutex lock
def Producer():
  while True:
    elem = produce()
    while True:
      lock.acquire()
      if not queue.full():
        queue.push(item)
        lock.release()
        break
      else:
        lock.release()
        sleep(push_delay)
def Consumer():
  while True:
    lock.acquire()
    if not queue.empty():
      elem = queue.pop()
      lock.release()
      consume(pop)
    else:
      lock.release()
      sleep(pop_delay)
```

## condition variables

A condition variable `cv` is a wait queue `q` and a associated mutex lock `m`.
Three operations on a condition variable

- `wait`:  
  0. the associated mutex lock `m` should be acquire before calling `wait`.
  1. release lock `m`
  2. put the current thread into `q` and sleep it.
  3. when the thread is notifed/signaled and wake up, re-acquire `m`
- `signal` (or `notifyOne`):  
  resume a blocked thread in the wait-queue.
- `broadcast` (or `notifyAll`):  
  resume all the blocked threads in the wait-queue.

```python
# global bounded-buffer queue: queue
# global mutex lock: lock
# global condition variables: cv_full, cv_empty
def Producer():
  while True:
    elem = produce()
    lock.acquire()
    while queue.full():
      cv_full.wait(lock)
    queue.push(elem)
    cv_empty.notifyOne()
    lock.release()
def Consumer():
  while True:
    lock.acquire()
    while queue.empty():
      cv_empty.wait(lock)
    elem = queue.pop()
    cv_full.notifyOne()
    lock.release()
    consume(elem)
```

## reference

- [wikipedia: producer-consumer problem](https://en.wikipedia.org/wiki/Producer-consumer_problem)
- [wikipedia: Monitor](https://en.wikipedia.org/wiki/Monitor_(synchronization))
- [UCSB CS170 lecture note: condition variable](https://sites.cs.ucsb.edu/~rich/class/cs170/notes/CondVar/index.html)
