#include <stdio.h>
#include "platform.h"
#include "xintc.h"
#include "xparameters.h"
#include "xio.h"
#include "xil_exception.h"

XIntc Intc;

void my_timer_interrupt_handler(void * baseaddr_p) {
	xil_printf("\n\rtimer timeout.");
}

int main()
{
    init_platform();
    XStatus Status;
    Xuint32 value1, value2, value3;
    
    xil_printf("Interrupt example\n\r");

    //Set Terminal count for my_timer
    XIo_Out32(XPAR_MY_TIMER_0_BASEADDR + 0x0, 0x5F5E100);

    // Run my_timer
    XIo_Out32(XPAR_MY_TIMER_0_BASEADDR + 0x4, 0x2);
    

    // Read my_timer register to verify that TC value is written
    value1 = XIo_In32(XPAR_MY_TIMER_0_BASEADDR + 0x0);
    xil_printf("\n\rvalue1 = %x.", value1);

    //initialize interrupt controller
    Status = XIntc_Initialize (&Intc, XPAR_INTC_0_DEVICE_ID);
    if (Status != XST_SUCCESS) xil_printf ("\r\nInterrupt controller initialization failure");
    else xil_printf("\r\nInterrupt controller initialized");
    
    // Connect my_timer_interrupt_handler
    Status = XIntc_Connect (&Intc, XPAR_INTC_0_MY_TIMER_0_VEC_ID,
                             (XInterruptHandler) my_timer_interrupt_handler,
                             (void *)0);

    if (Status != XST_SUCCESS) xil_printf ("\r\nRegistering MY_TIMER Interrupt Failed");
    else xil_printf("\r\nMY_TIMER Interrupt registered");

    //start the interrupt controller in real mode
    Status = XIntc_Start(&Intc, XIN_REAL_MODE);

    //enable interrupt controller
    XIntc_Enable  (&Intc, XPAR_INTC_0_MY_TIMER_0_VEC_ID);

	microblaze_enable_interrupts();
    
    while (1){
    	/*value3 = XIo_In32(XPAR_MY_TIMER_0_BASEADDR + 0x0);
    	value1 = XIo_In32(XPAR_MY_TIMER_0_BASEADDR + 0x4);
    	value2 = XIo_In32(XPAR_MY_TIMER_0_BASEADDR + 0x8);
        xil_printf("\n\rvalue1 = %x, value2 = %x, value3 = %x.", value1, value2, value3);*/
    }
    cleanup_platform();

    return 0;
}
