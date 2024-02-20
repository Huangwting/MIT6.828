	.globl thread_switch
thread_switch:
	/* YOUR CODE HERE */
	/* 下面这四条语句是我没有想明白current_thread的结构
	先把current_thread->sp取出，此时sp=current_thread->stack-4-32
	movl current_thread, %eax
	movl (%eax), %esp

	// 将当前线程状态保存，那八个寄存器
	add $32, %esp
	pushal*/

	//此时%esp=current_thread->sp
	//而C中对thread_switch的调用自动把下一条指令eip入栈了，所以下面只要把寄存器保存
	pushal

	//将当前线程的esp保存
	movl current_thread, %eax
	movl %esp, (%eax)

	// 使current_thread指向next_thread
	movl next_thread, %eax
	movl %eax, current_thread

	// 恢复next_thread的状态
	movl current_thread, %eax
	movl (%eax), %esp
	popal

	// set next_thread to 0
	movl $0, next_thread
	ret				/* pop return address from stack */

