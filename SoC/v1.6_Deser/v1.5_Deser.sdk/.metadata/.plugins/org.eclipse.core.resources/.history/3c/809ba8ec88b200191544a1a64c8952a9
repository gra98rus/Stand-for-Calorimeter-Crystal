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
#include <stdlib.h>
#include "xadcps.h"
#include "xspips.h"

#define regWE *(long*) 0x43C00000
#define regNumb *(long*) 0x43C00004
#define DataOut *(long*) 0x43C00008
#define DataIn1 *(long*) 0x43C0000C
#define DataIn2 *(long*) 0x43C00010
#define regDataIn *(long*) 0x43C00014

#define ADC_SPI_TEST_IO_REG_NUM (0x0D)
#define ADC_SPI_TRANSFER_REG_NUM (0xFF)
#define ADC_SPI_TRANSFER_REG_VAL (0x01)
#define ADC1_3_SPI_DEVICE_ID		XPAR_XSPIPS_0_DEVICE_ID

#define XADC_DEVICE_ID 		XPAR_XADCPS_0_DEVICE_ID

#define Z24_TEST_MODE_MID_SCALE (0xC0)

#define OFFSET_BINARY (0X14)

static XAdcPs XAdcInst;      /* XADC driver instance */
XAdcPs *XAdcInstPtr = &XAdcInst;

XSpiPs AdcSpi[2];
XSpiPs_Config *SpiConfig[2];


void pause(int cycles_num)
{
	volatile int pause_cnt = 0;
	for(pause_cnt=0; pause_cnt<cycles_num; pause_cnt++);
}

int main()
{
    init_platform();

    short int cha = 0;
    short int chb = 0;
    short int chc = 0;
    short int chd = 0;

    DataOut = 0x0000001f; //11111
    sleep(1);

    //regNumb = 0x00000000; //reset
    //regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
    //sleep(1);

    //regNumb = 0x00000001; //clock_generation_look
    //regWE = 0xffffffff;
    //printf("\nDataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
    //sleep(1);

    //regNumb = 0x00000010; //resync
    //regWE = 0xffffffff;
    //printf("\nDataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
    //sleep(1);

	print("\n\rADC test\n\r");

	if( init_xadc() != XST_SUCCESS)
		printf("init_xadc() fault!\n\r");
	printf("init_xadc is corrected\n\r");
	if( init_adc_spi() != XST_SUCCESS)
	{
		printf("init_spi() fault!\n\r");
		return -1;
	}
	printf("init_spi is corrected\n\r");
	set_adc_test_mode(0,Z24_TEST_MODE_MID_SCALE);
	printf("ADC in test mode\n\r");


    cleanup_platform();
    return 0;
}

void adc_write_reg(int adc_num, int reg_num, int wdata)
{

	u8 WriteAdcSpiRegBuf[3];
	int spi_i=0;
	adc_num = 0;

	XSpiPs_SetSlaveSelect(AdcSpi, adc_num);
	printf("start writing\n");

//	printf("ADC %d, SPI %d : %d\n\r", adc_num, spi_i, XSpiPs_GetSlaveSelect(AdcSpi+spi_i));

	WriteAdcSpiRegBuf[0] = 0x00 | (( reg_num & 0x1F00) >> 8);  // write 1 byte, reg_num[12..8]
	WriteAdcSpiRegBuf[1] = ( reg_num & 0x0FF);      //               reg_num[7 ..0]
	WriteAdcSpiRegBuf[2] = wdata & 0x0F;
	XSpiPs_PolledTransfer(AdcSpi+spi_i, WriteAdcSpiRegBuf, NULL, sizeof(WriteAdcSpiRegBuf));
}

void set_adc_test_mode(int adc_num, int adc_test_mode) // adc_num = 0..5, adc_mode (see AD9228 datasheet)
{
	adc_num = 0;
//while(1)
	{
		adc_write_reg(adc_num, 0x0,  0x18);
		adc_write_reg(adc_num, 0x5,  0x0F);
		adc_write_reg(adc_num, ADC_SPI_TEST_IO_REG_NUM,  adc_test_mode);
		adc_write_reg(adc_num, ADC_SPI_TRANSFER_REG_NUM, ADC_SPI_TRANSFER_REG_VAL);

		printf("test mode is set\n");

	}
}

void set_output_mode (int adc_num, int adc_mode) // adc_num = 0..5, adc_mode (see AD9228 datasheet)
{
	adc_num = 0;
//while(1)
	{
		adc_write_reg(adc_num, 0x0,  0x18);
		adc_write_reg(adc_num, 0x5,  0x0F);
		adc_write_reg(adc_num, OFFSET_BINARY,  adc_mode);
		adc_write_reg(adc_num, ADC_SPI_TRANSFER_REG_NUM, ADC_SPI_TRANSFER_REG_VAL);

		printf("offset is set\n");

	}
}

int init_xadc(void)
{
	int Status;
	XAdcPs_Config *ConfigPtr;


	/*
	 * Initialize the XAdc driver.
	 */
	ConfigPtr = XAdcPs_LookupConfig(XADC_DEVICE_ID);
	if (ConfigPtr == NULL) {
		return XST_FAILURE;
	}
	XAdcPs_CfgInitialize(XAdcInstPtr, ConfigPtr,
				ConfigPtr->BaseAddress);

	/*
	 * Self Test the XADC/ADC device
	 */
	Status = XAdcPs_SelfTest(XAdcInstPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	return XST_SUCCESS;
}

int init_adc_spi(void)
{
	int Status;
	int spi_i = 0;

	int pDevId = 0;
	/*
	 * Initialize the SPI device.
	 */

		SpiConfig[0] = XSpiPs_LookupConfig(pDevId);
		if (NULL == SpiConfig) {
			return XST_FAILURE;
		}

		printf("0x%0X \n\r", (unsigned int)(SpiConfig[spi_i]->BaseAddress));
		Status = XSpiPs_CfgInitialize(AdcSpi+spi_i, SpiConfig[spi_i], SpiConfig[spi_i]->BaseAddress);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

		/*
		 * Perform a self-test to check hardware build.
		 */
		Status = XSpiPs_SelfTest(AdcSpi+spi_i);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}


		XSpiPs_SetOptions(AdcSpi+spi_i, XSPIPS_MASTER_OPTION |  XSPIPS_FORCE_SSELECT_OPTION);

		XSpiPs_SetClkPrescaler(AdcSpi+spi_i, XSPIPS_CLK_PRESCALE_64);


	return XST_SUCCESS;
}
