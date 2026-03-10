# Linux Virtual Memory Experiment (Assembly)

This project explores how the Linux kernel handles virtual memory allocation and demand paging.

The experiment uses a small x86 assembly program written with NASM that repeatedly allocates memory pages using the `mmap` syscall and then touches those pages to trigger page faults.

## What the program demonstrates

- Virtual memory allocation using `mmap`
- Demand paging in Linux
- Page fault generation
- Kernel page table updates

## How it works

Each loop iteration:

1. Calls the `mmap` syscall to allocate a 4KB page
2. Writes to the page to force physical allocation
3. Triggers a page fault handled by the kernel

## Observability Tools Used

During execution the following Linux tools were used to observe system behavior:

- `htop`
- `vmstat`
- `/proc/vmstat`
- `strace`
- `gdb`

Watching the `pgfault` counter in `/proc/vmstat` shows page faults increasing in real time as memory pages are allocated.

## Build

```bash
chmod +x build.sh
./build.sh

## RUN
./memstress
