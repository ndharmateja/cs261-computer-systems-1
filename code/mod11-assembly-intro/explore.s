.globl main

.data
secret_msg: 
    .ascii "GDB_is_awesome\0"   # A null-terminated string to find in memory

.text
main:
    # 1. Load distinct hex values into registers
    movq $0xDEADBEEF, %rax
    movq $0xCAFEBABE, %rbx
    
    # 2. Perform arithmetic (Watch %rax change!)
    addq %rbx, %rax
    
    # 3. Play with the Stack (Watch %rsp move and memory update)
    pushq %rax             # Push the sum onto the stack
    movq $0, %rax          # Zero out %rax so we can see it change again
    popq %rcx              # Pop the sum off the stack into a new register (%rcx)
    
    # 4. Reference Memory (Load the address of our string)
    leaq secret_msg(%rip), %rdx
    
    # 5. Exit cleanly
    movq $0, %rax
    ret