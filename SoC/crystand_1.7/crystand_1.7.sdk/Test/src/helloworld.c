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

    regNumb = 0x00000003;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n\n",DataIn1);
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

    regNumb = 0x00000004;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    //sleep(1);

    regNumb = 0x00000002;
    regWE = 0xffffffff;
    //printf("DataIn2 %#x\n",DataIn2);
    //printf("DataIn1 %#x\n",DataIn1);
    //printf("DataIn1 %#x\n\n",DataIn1);
    sleep(1);

    cha = (short int) DataIn1;
    chb = (short int) (DataIn1 >> 16);
    chc = (short int) DataIn2;
    chd = (short int) (DataIn2 >> 16);

    if (cha>=0x2000){
       	cha = cha+0xBFFF;
    }
    printf("\n\n\ncha %hi  \t",cha);
    if (chb>=0x2000){
       	chb = chb+0xBFFF;
    }
    printf("chb %hi  \t",chb);
    if (chc>=0x2000){
       	chc = chc+0xBFFF;
    }
    printf("chc %hi  \t",chc);
    if (chd>=0x2000){
       	chd = chd+0xBFFF;
    }
    printf("chd %hi",chd);

    //printf("regNum %#x\n",regNumb);
    //printf("DataOut %#x\n",DataOut);
    //printf("DataIn2 %#x\n",DataIn2);
    for (int i=0;i<100;i++){
        cha = (short int) DataIn1;
        chb = (short int) (DataIn1 >> 16);
        chc = (short int) DataIn2;
        chd = (short int) (DataIn2 >> 16);

        if (cha>=0x2000){
        	cha = cha+0xBFFF;
        }
        printf("\ncha %#hi  \t",cha);
        if (chb>=0x2000){
        	chb = chb+0xBFFF;
        }
        arr[i] = chb;
        printf("chb %#hi  \t",chb);
        if (chc>=0x2000){
        	chc = chc+0xBFFF;
        }
        printf("chc %#hi  \t",chc);
        if (chd>=0x2000){
        	chd = chd+0xBFFF;
        }
        printf("chd %#hi",chd);


    }

    for (int i=0;i<100;i++){
    	for (int j = 0; j<100-i-1;j++){
    		if (arr[j]>arr[j+1]){
    			short int tmp = arr[j];
    			arr[j]=arr[j+1];
    			arr[j+1]=tmp;
    		}
    	}
    }

    //for (int i=0; i<100;i++){
    //    printf("\ncha %#hi",arr[i]);
    //}

    int start_val = -300;
    int k =0;
    int step =30;
    int sum[20] = {0};
    for (int i=0; i<20; i++){
    	while ((arr[k]<=start_val+step*i)&&(k<100)){
    		sum[i]=sum[i]+1;
    		k++;
    	}
    }
    for (int i=0; i<20; i++){
    	printf("\nnumber of values %d and %d - %d",start_val+step*(i-1),start_val+step*(i),sum[i]);
    }

    cleanup_platform();
    return 0;
}
