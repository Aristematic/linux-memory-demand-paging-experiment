
# Linux Memory Demand Paging Experiment

This repository contains a simple x86-64 assembly program for Linux to demonstrate the concept of demand paging.

## Overview

In modern operating systems like Linux, memory requested by a process is not physically allocated until it is actually accessed. This mechanism is called **demand paging**.

This experiment uses a program, `memstress`, that repeatedly:
1.  Requests a new memory page from the kernel using the `mmap` syscall. This only reserves virtual address space, not physical RAM.
2.  "Touches" the page by writing a single byte to it. This triggers a page fault.
3.  The kernel's page fault handler then allocates a physical page of memory and maps it to the process's virtual address.

By running this program, you can observe the process's memory usage grow as it forces the kernel to allocate physical pages on demand.

## How it Works

The core logic is in `memstress.asm`. The program loops 1,000,000 times. In each iteration:

1.  **`mmap` syscall:**
    ```assembly
    mov rax, 9            ; syscall: mmap
    xor rdi, rdi          ; addr = NULL
    mov rsi, 4096         ; allocate one page (4KB)
    mov rdx, 3            ; PROT_READ | PROT_WRITE
    mov r10, 34           ; MAP_PRIVATE | MAP_ANONYMOUS
    syscall
    ```
    This reserves a 4KB page in the process's virtual address space. No physical memory (RAM) is used at this point.

2.  **Touch the page:**
    ```assembly
    mov rbx, rax          ; returned memory pointer
    mov byte [rbx], 1     ; touch page (forces page allocation)
    ```
    Writing `1` to the newly mapped memory address causes a minor page fault. The Linux kernel catches this fault and allocates a physical page of memory to back the virtual address, demonstrating demand paging.

## Prerequisites

You will need a Linux environment with the following tools installed:
*   `nasm` (The Netwide Assembler)
*   `ld` (The GNU Linker)

On Debian/Ubuntu-based systems, you can install them with:
```bash
sudo apt-get update && sudo apt-get install nasm
```

## Building

A build script is provided to assemble and link the executable.

```bash
chmod +x build.sh
./build.sh
```

This will create an executable file named `memstress`.

## Running the Experiment

A simple run script is included.

```bash
chmod +x run.sh
./run.sh
```

While the script is running, open another terminal and monitor the `memstress` process's memory usage using tools like `top`, `htop`, or `ps`. You will see its resident memory size (RSS or RES) climb steadily as it touches more pages and forces the kernel to allocate physical memory.

Example using `ps`:
```bash
# Watch the RSS (Resident Set Size) in kilobytes
watch -n 0.5 'ps -o pid,comm,rss -C memstress'
