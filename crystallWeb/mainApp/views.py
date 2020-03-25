from django.http import HttpResponse, HttpRequest, QueryDict, JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

import json
import struct

from periphery import MMIO

REG_ADDRESS = 0x43C00000
REG_SIZE = 0x10000

REG_COMMAND = 0x0001
REG_STATUS = 0x0010
REG_START_EVENT = 0x0011
REG_TRIGGER_TYPE = 0x0100
REG_TRIGGER_LEVEL = 0x0101


COMMAND_START = 0x0001

MEM_ADDRESS = 0x40000000
MEM_SIZE = 0x0000FFFF

def write_to_reg (reg_num , data):
    mem = MMIO(REG_ADDRESS , REG_SIZE)
    mem.write32(0x4 , reg_num)
    mem.write32(0x8 , data)
    mem.write32(0x0 , 0xFFFFFFFF)
    mem.close()

def read_from_reg (reg_num):
    mem = MMIO(REG_ADDRESS , REG_SIZE)
    data = mem.write32(0x4, reg_num)
    data = mem.read32(0xC)
    mem.close()
    return data

def read_charts ():
    mem = MMIO (MEM_ADDRESS, MEM_SIZE)
    data = mem.read(0, 2048)
    mem.close()
    data_ = struct.unpack("512I",data)
    #data__ = []
    #for i in range(0,512):
    #    data__.append(struct.unpack("I", data)[i])
    return data_


@csrf_exempt
def index(request):
    print (HttpRequest.body)
    if request.method ==  'GET':
        return render (request , 'index.html')

    if (request.method == 'POST'):
        print 'Raw Data: "%s"' % request.body
        js = json.loads(request.body)

        reg_num = 0
        data = 0

        if (js['command'] == 'writeRegister'):
            #for key, value in js.items():
            #    if key == 'data':
            #        data = int(value)
            #    elif key == 'regNumber':
            #        reg_num = int(value)
            #    else :
            #        print('error!!!!!!!!!!!!!!!!!!111')
            #print (reg_num, data)
            write_to_reg(int(js['regNumber']), int(js['data']))
            return HttpResponse('ok!')

        if (js['command'] == 'readRegister'):
            #for key, value in js.items():
            #    if key == 'regNumber':
            #        reg_num = int(value)
            #    else:
            #        print('error!!!!!!!!!!!!!!!!!!222')
            data = read_from_reg(int(js['regNumber']))
            response = JsonResponse({'reg_number': reg_num, 'data': data})
            return HttpResponse(response)

        if (js['command'] == 'readCharts'):                               
            response = {}                                                 
            write_to_reg(REG_START_EVENT, COMMAND_START)                  
            status = read_from_reg (REG_STATUS)                           
            while status != 1:                                            
                print(status)
                status = read_from_reg (REG_STATUS)                       
            data = read_charts()                                          
            for i in range(0,512):                                        
                response[str(i)] = data[i]                                
            response = JsonResponse(response)                             
            return HttpResponse(response)
       
         if (js['command'] == 'setTriggerType'):
            write_to_reg(REG_TRIGGER_TYPE, int(js['data']))
            return HttpResponse('ok!')
        
        if (js['command'] == 'setTriggerLevel'):
            write_to_reg(REG_TRIGGER_LEVEL, int(js['data']))
            return HttpResponse('ok!')
        
        if (js['command'] == 'sendStartEvent'):
            write_to_reg(REG_START_EVENT, 1)
            write_to_reg(REG_START_EVENT, 0)
            return HttpResponse('ok!')
