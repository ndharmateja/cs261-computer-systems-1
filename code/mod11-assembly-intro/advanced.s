.globl main
.data
my_array:
    .quad 15           # Element 0
    .quad -25          # Element 1 (This will trigger the negative clamping!)
    .quad 30           # Element 2
    .quad 5            # Element 3
array_size:
    .quad 4

.text
# ─── HELPER FUNCTION ──────────────────────────────────────────────────
# Arguments passed by caller: %rdi = array element, %rsi = running total
clamped_add:
    pushq %rbp
    movq %rsp, %rbp

    movq %rdi, %rax     # Move element into %rax
    addq %rsi, %rax     # Add running total to %rax (Flags are set here!)
    
    cmpq $0, %rax       # Is the sum less than 0?
    jge .done           # If Greater or Equal, jump to .done
    movq $0, %rax       # Otherwise, clamp the result to 0

.done:
    popq %rbp
    ret

# ─── MAIN FUNCTION ────────────────────────────────────────────────────
main:
    pushq %rbp
    movq %rsp, %rbp

    movq $0, %rcx                 # %rcx = Loop Index (i = 0)
    movq $0, %rbx                 # %rbx = Cumulative Running Total = 0
    leaq my_array(%rip), %r8      # %r8  = Base address pointer of our array
    movq array_size(%rip), %r9    # %r9  = Total array size limit (4)

.loop_start:
    cmpq %r9, %rcx                # Compare index (%rcx) with size (%r9)
    jge .loop_end                 # If i >= size, break out of loop

    # Load my_array[i] into %rdi using Scale-Index-Base addressing:
    # Address = Base (%r8) + (Index (%rcx) * Scale Factor (8 bytes))
    movq (%r8, %rcx, 8), %rdi     
    movq %rbx, %rsi               # Pass current running total into %rsi

    # Because %rcx, %r8, and %r9 are "Caller-Saved" registers, 
    # the function 'clamped_add' is allowed to overwrite them. 
    # We must preserve them on our stack frame before calling!
    pushq %rcx
    pushq %r8
    pushq %r9

    call clamped_add              # Call function! Return value lands in %rax

    # Restore our registers back from the stack in exact reverse order
    popq %r9
    popq %r8
    popq %rcx

    movq %rax, %rbx               # Update our running total (%rbx) with %rax
    incq %rcx                     # i++
    jmp .loop_start               # Jump back to start of loop

.loop_end:
    movq %rbx, %rax               # Place final sum into %rax for program exit
    popq %rbp
    ret