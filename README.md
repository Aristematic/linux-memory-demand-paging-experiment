Linux Virtual Memory Experiment (Assembly)

A low-level systems experiment demonstrating how the Linux kernel handles virtual memory allocation and demand paging.

This project uses a small x86 assembly program written with NASM that repeatedly allocates memory pages using the mmap system call and then touches those pages to trigger page faults.

The goal of the experiment is to observe how the Linux kernel maps virtual memory pages to physical memory in real time.

How the Experiment Works

The assembly program repeatedly performs the following steps:

Calls the mmap system call to request a new memory page

The kernel returns a virtual memory address

The program writes to that memory page

The CPU triggers a page fault

The Linux kernel allocates a physical page

The kernel updates the page table mapping

Execution continues

This mechanism is known as Demand Paging.

The experiment allows us to observe this behavior live using Linux system monitoring tools.

Build

Compile the assembly program using NASM and the linker.

chmod +x build.sh
./build.sh

This produces the executable:

memstress
Run

Execute the program:

./memstress

The program will continuously allocate memory pages and write to them, triggering page faults handled by the Linux kernel.

Observing Page Faults

While the program is running, open another terminal and execute:

watch -n1 "cat /proc/vmstat | grep pgfault"

You will see the pgfault counter increasing in real time as memory pages are accessed and mapped by the kernel.

Additional Monitoring Tools

During the experiment, the following Linux tools can be used to observe system behavior.

Process and Memory Usage
htop
Virtual Memory Statistics
vmstat 1
System Call Tracing
strace ./memstress
Process Memory Mapping
cat /proc/<pid>/maps
Key Concepts Demonstrated

This experiment touches several important operating system concepts:

Virtual Memory

Page Tables

Demand Paging

Page Fault Handling

Linux Kernel Memory Management

System Calls (mmap)

Process Address Space

Page Size Verification

Linux typically allocates memory in 4KB pages.

You can verify this with:

getconf PAGE_SIZE

You will observe that each mmap allocation is aligned to 4096 bytes.

Technologies Used

x86 Assembly

NASM (Netwide Assembler)

Linux (Ubuntu)

Linux Kernel Memory Management

System Call Interface

Why This Experiment Matters

Modern infrastructure engineering often operates at high levels of abstraction:

Containers

Orchestration systems

Cloud infrastructure

Distributed platforms

However, all of these ultimately rely on the operating system and its memory management mechanisms.

Understanding how virtual memory, page faults, and demand paging work provides deeper insight into how systems behave under:

memory pressure

low-level debugging

performance analysis

Repository Structure
linux-virtual-memory-experiment
│
├── memstress.asm
├── build.sh
├── run.sh
├── screenshots
│   ├── htop.png
│   ├── vmstat.png
│   ├── strace.png
│   └── pgfault.png
└── README.md
Future Extensions

Possible extensions of this experiment:

Observing minor vs major page faults

Triggering the Linux OOM killer

Measuring memory allocation latency

Using perf to observe hardware counters

Visualizing process memory maps
