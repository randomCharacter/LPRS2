/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xio.h"
#include "my_peripheral.h"

int main (void) {
  unsigned int DataRead;
  unsigned int OldData;
  // Clear the screen
  //xil_printf("%c[2J",27);
  MY_PERIPHERAL_ClearScreen();

  OldData = (unsigned int) 0xffffffff;
  while(1){
    // Read the state of the DIP switches
    DataRead = XIo_In32(XPAR_MY_PERIPHERAL_0_BASEADDR);
    // Send the data to the UART if the settings change
    if(DataRead != OldData){
      xil_printf("DIP Switch settings: 0x%2X\r\n", DataRead);
      // Set the LED outputs to the DIP switch values
      XIo_Out32(XPAR_MY_PERIPHERAL_0_BASEADDR, DataRead);
      // Record the DIP switch settings
      OldData = DataRead;
    }
  }
}
