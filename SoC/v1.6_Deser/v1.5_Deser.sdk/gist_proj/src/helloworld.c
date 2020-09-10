/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

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
#include "xil_printf.h"

#define regWE *(long*) 0x43C00000
#define regNumb *(long*) 0x43C00004
#define DataOut *(long*) 0x43C00008
#define DataIn1 *(long*) 0x43C0000C
#define DataIn2 *(long*) 0x43C00010
#define regDataIn *(long*) 0x43C00014

int main()
{
    init_platform();

    short int arr[100] = {0};
    short int cha = 0;
    short int chb = 0;
    short int chc = 0;
    short int chd = 0;

    DataOut = 0x0000001f; //11111
    sleep(1);

    regNumb = 0x00000000;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("RegDataIn %#x\n\n",regDataIn);
    sleep(1);

    regNumb = 0x00000001;
    regWE = 0xffffffff;
    //printf("\nDataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    regNumb = 0x00000003;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    regNumb = 0x00000004;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    regNumb = 0x0000001C;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    regNumb = 0x00000002;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    //cha = (short int) (DataIn1>>16);

    //if (cha>=0x2000){
    //   	cha = cha+0xBFFF;
    //}
    //printf("\n\n\ncha:\n %hi ",cha);
    printf("\n\n\ncha:\n");
    //printf("regNum %#x\n",regNumb);
    //printf("DataOut %#x\n",DataOut);
    //printf("DataIn2 %#x\n",DataIn2);
    for (int k; k<10;k++){
    for (int j=0;j<256;j++){
    	for (int i=0;i<32;i++){

    		regNumb = 0x00000002;
    		regWE = 0xffffffff;
    		//sleep(1);
        	cha = (short int) DataIn1;

        	if (cha>=0x2000){
        		cha = cha+0xBFFF;
        	}
        	printf("%hi ",cha);
    	}
    	printf("\n");
    }
    sleep(5);
    regNumb = 0x00000004;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);
    printf("\n");
    }


    cleanup_platform();
    return 0;
}
