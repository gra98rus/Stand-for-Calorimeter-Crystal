from django.http import HttpResponse, HttpRequest, QueryDict, JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

import json
import struct

from periphery import MMIO

REG_ADDRESS = 0x43C00000
REG_SIZE = 0x10000

REG_COMMAND           = 0x0001
REG_STATUS            = 0x0010
REG_START_EVENT       = 0x0011
REG_TRIGGER_TYPE      = 0x0100
REG_TRIGGER_LEVEL     = 0x0101
REG_SELECTED_CHANNELS = 0x0110
REG_BASKET_NUM        = 0x0111
REG_SHAPER            = 0x1000
REG_SPECTRUM_SPEC     = 0x1001
REG_AMPLIFIERS        = 0x1010
REG_SPI_DATA          = 0x1011
REG_SPI_VALID_BYTES   = 0x1100
REG_SPI_START         = 0x1101
REG_DESER_RESYNC      = 0x1110
REG_DESER_RESET       = 0x1111

COMMAND_START = 0x0001

MEM_ADDRESS = 0x40000000
MEM_SIZE = 0x0000FFFF

SPECTRA_MEM_ADDRESS = 0x42000000
SPECTRA_MEM_SIZE = 0x0003FFFF

trigger_type = 1
selected_level = 0
trigger_level_0 = 0
trigger_level_1 = 0
trigger_level_2 = 0
trigger_level_3 = 0
shapers_config_0 = 0
shapers_config_1 = 0
shapers_config_2 = 0
shapers_config_3 = 0
amplifiers_config_0 = 0
amplifiers_config_1 = 0
amplifiers_config_2 = 0
adc_mode = 1

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
    data_ = struct.unpack("1024h",data)
    #data__ = []
    #for i in range(0,512):
    #    data__.append(struct.unpack("I", data)[i])
    return data_

def read_spectrum(spectrum_num):
    mem = MMIO (SPECTRA_MEM_ADDRESS, SPECTRA_MEM_SIZE)
    data = mem.read(0x4000 * spectrum_num, 16384)
    mem.close()
    data_ = struct.unpack("4096I",data)
    return data_

def send_pulse(address):
    write_to_reg(address, 1)
    i = 0
    while i < 100:
        i = i + 1
    write_to_reg(address, 0)

def resync_deser():
    send_pulse(REG_DESER_RESET)
    write_to_reg(REG_SPI_DATA, 24)
    write_to_reg(REG_SPI_VALID_BYTES, 3)
    send_pulse(REG_SPI_START)

    write_to_reg(REG_SPI_DATA, 3399)
    write_to_reg(REG_SPI_VALID_BYTES, 3)
    send_pulse(REG_SPI_START)
    ready = 0
    while not ready:
        send_pulse(REG_DESER_RESYNC)
        send_pulse(REG_START_EVENT)
        send_pulse(REG_START_EVENT)
        data = read_charts()
        print('Not good sync: ' + str(data[0:8]))
        for i in range (0, 7):
            if(int(data[i]) == 0):
                print('Synchronized! ' + str(data[0:8]))
                ready = 1

    if(int(adc_mode)):
        write_to_reg(REG_SPI_DATA, 3392)
    else:
        write_to_reg(REG_SPI_DATA, 3399)
    write_to_reg(REG_SPI_VALID_BYTES, 3)
    send_pulse(REG_SPI_START)

@csrf_exempt
def index(request):
    print (HttpRequest.body)
    if request.method ==  'GET':
        return render (request , 'index.html')

    if (request.method == 'POST'):
        print ('Raw Data: "%s"' % request.body)
        js = json.loads(request.body.decode('utf-8'))

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

        if (js['command'] == 'read_charts'):
            response = {}
            write_to_reg(REG_START_EVENT, COMMAND_START)
            status = read_from_reg(REG_STATUS)
            data = read_charts()
            for i in range(0,1024):
                response[str(i)] =  data[i]
            response = JsonResponse(response)
            return HttpResponse(response)

        if (js['command'] == 'readSpectrum'):
            response = {}
            data = read_spectrum(int(js['spectrum_num']))
            for i in range(0,4096):
                response[str(i)] = data[i]
            response = JsonResponse(response)
            return HttpResponse(response)

        if (js['command'] == 'setTriggerType'):
            write_to_reg(REG_TRIGGER_TYPE, int(js['data']))
            global trigger_type
            trigger_type = int(js['data'])
            return HttpResponse('ok!')

        if (js['command'] == 'set_trigger_level'):
            write_to_reg(REG_TRIGGER_LEVEL, int(js['data']))
            print (bin(int(js['data'])))
            global trigger_level_0
            global trigger_level_1
            global trigger_level_2
            global trigger_level_3
            if (int(js['data']) & 0b1100000000000000 == 0):
                trigger_level_0 = int(js['data'])
            elif (int(js['data']) & 0b1100000000000000 == 0x4000):
                trigger_level_1 = int(js['data'])
            elif (int(js['data']) & 0b1100000000000000 == 0x8000):
                trigger_level_2 = int(js['data'])
            else:
                trigger_level_3 = int(js['data'])
            return HttpResponse('ok!')

        if (js['command'] == 'setSelectedChannels'):
            write_to_reg(REG_SELECTED_CHANNELS, int(js['data']))
            global selected_level
            selected_level = int(js['data'])
            return HttpResponse('ok!')

        if (js['command'] == 'setBasketNum'):
            write_to_reg(REG_BASKET_NUM, int(js['data']))
            return HttpResponse('ok!')

        if (js['command'] == 'setShapersConfig'):
            write_to_reg(REG_SHAPER, int(js['data']))
            global shapers_config_0
            global shapers_config_1
            global shapers_config_2
            global shapers_config_3
            if (int(js['data']) & 0b1100 == 0):
                shapers_config_0 = int(js['data']) & 0b0011
            elif (int(js['data']) & 0b1100 == 0b0100):
                shapers_config_1 = int(js['data']) & 0b0011
            elif (int(js['data']) & 0b1100 == 0b1000):
                shapers_config_2 = int(js['data']) & 0b0011
            else:
                shapers_config_3 = int(js['data']) & 0b0011
            return HttpResponse('ok!')

        if (js['command'] == 'set_ampl_config'):
            write_to_reg(REG_AMPLIFIERS, int(js['data']))
            global amplifiers_config_0
            global amplifiers_config_1
            global amplifiers_config_2
            if (int(js['data']) & 0b1100 == 0):
                amplifiers_config_0 = int(js['data']) & 0b0011
            elif (int(js['data']) & 0b1100 == 0b0100):
                amplifiers_config_1 = int(js['data']) & 0b0011
            else:
                amplifiers_config_3 = int(js['data']) & 0b0011
            return HttpResponse('ok!')

        if (js['command'] == 'sendStartEvent'):
            send_pulse(REG_START_EVENT)
            return HttpResponse('ok!')

        if (js['command'] == 'set_spectrum_conf'):
            write_to_reg(REG_SPECTRUM_SPEC, int(js['spectrum_num'])<<11 | 1<<10 | int(js['bins_num'])<<7 | int(js['point']))
            print (bin(int(js['spectrum_num'])<<11 | 1<<10 | int(js['bins_num'])<<7 | int(js['point'])))
            return HttpResponse('ok!')

        if(js['command'] == 'adc_mode'):
            global adc_mode
            if(int(js['data'])):
                adc_mode = 3392
            else:
                adc_mode = 3399
            write_to_reg(REG_SPI_DATA, 24)
            write_to_reg(REG_SPI_VALID_BYTES, 3)
            send_pulse(REG_SPI_START)

            write_to_reg(REG_SPI_DATA, adc_mode)
            write_to_reg(REG_SPI_VALID_BYTES, 3)
            send_pulse(REG_SPI_START)

            write_to_reg(REG_SPI_DATA, 65281)
            write_to_reg(REG_SPI_VALID_BYTES, 3)
            send_pulse(REG_SPI_START)
            adc_mode = int(js['data'])
            return HttpResponse('ok!')

        if (js['command'] == 'sync_deser'):
            resync_deser()
            return HttpResponse('ok!')

        if (js['command'] == 'update_config_on_page'):
            response = JsonResponse({"trigger_type" : trigger_type, "selected_level" : selected_level, "trigger_level_0" : trigger_level_0, "trigger_level_1" : trigger_level_1, "trigger_level_2" : trigger_level_2, "trigger_level_3" : trigger_level_3, "shapers_config_0" : shapers_config_0, "shapers_config_1" : shapers_config_1, "shapers_config_2" : shapers_config_2, "shapers_config_3" : shapers_config_3, "ampl_config_0" : amplifiers_config_0, "ampl_config_1" : amplifiers_config_1, "ampl_config_2" : amplifiers_config_2, "adc_mode" : adc_mode})
            return HttpResponse(response)

resync_deser()

