import sensor, image, time, gc, lcd
from Maix import GPIO
from fpioa_manager import fm
import Maix
import KPU
from board import board_info

from modules import ws2812
#class_ws2812_body = ws2812(7,10)  #本体LED

#LED_POWER = 150
LED_POWER = 0
class_ws2812 = ws2812(35,23)  #Grove Port Yellow

def led_update():
    for leds in range(12):
        class_ws2812.set_led(leds*2, (LED_POWER, LED_POWER, LED_POWER))
    class_ws2812.display()

#Maix.utils.gc_heap_size(1500000)

#ENTER = 23
#WLED_EN = 32

#fm.register(WLED_EN, fm.fpioa.GPIOHS0, force=True)
#fm.register(ENTER, fm.fpioa.GPIO0, force=True)

#wled_en = GPIO(GPIO.GPIOHS0, GPIO.OUT)
#wled_en.value(1)

#print(KPU.memtest())
gc.collect()
sensor.reset()
sensor.set_vflip(True)
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QQVGA)

#sensor.set_auto_gain(False)         # オートゲインをオフ
#sensor.set_auto_whitebal(False, rgb_gain_db = (128, 128, 180)) # ゲインを設定しておく

#sensor.set_brightness(4)            # 明度の調整
#sensor.set_saturation(4)            # 彩度の調整
#sensor.set_contrast(2)              # コントラストの調整

#sensor.set_brightness(0)
#sensor.set_windowing((640,320))
sensor.skip_frames(time = 2000)

lcd.init(type=3, freq=15000000, color=(0,30,255))
lcd.rotation(2)

fm.register(board_info.BUTTON_A, fm.fpioa.GPIO1)
button_a=GPIO(GPIO.GPIO1, GPIO.IN, GPIO.PULL_UP)
button_a_pressed = 0

led_update()

clock = time.clock();

lcd.clear()

while(True):
    clock.tick()
    img = sensor.snapshot()

    if button_a.value() == 0 and button_a_pressed == 0:
        print("A_push")
        button_a_pressed=1
        if(LED_POWER == 0):
             LED_POWER = 150
        else:
             LED_POWER = 0
        led_update()
    if button_a.value() == 1 and button_a_pressed == 1:
        print("A_release")
        button_a_pressed=0

#print(KPU.memtest())
    #tmpImg = img.copy()
    #print("2")
    #print(KPU.memtest())
    cf=[0,0,0,0,0,0,0,0,0,0]
    #fish=["egg.jpg", "shrimp.jpg", "tsuna.jpg", "ikura.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "nothing.jpg"]


    #mask = tmpImg.binary([(20,64,-15,55,-80,-15)],invert=True)

#    workImg = img.copy()
#    workImg = workImg.cartoon(0.3, 0.2)
#    workImg = workImg.bilateral(1, color_sigma=1.0, space_sigma=0.5)

#    img = img.laplacian(2)
#    img = img.cartoon(0.05, 0.1)
#    foundCircles = img.find_circles(x_stride=2, y_stride=2, threshold=1200)
    #print(foundCircles)
    sta = img.get_statistics()

    cf[0] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 89) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[1] +=  abs(sta.l_lq() -42) + abs(sta.l_uq() - 71) + abs(sta.a_lq() +9) + abs(sta.a_uq() - 29) + abs(sta.b_lq() +47) + abs(sta.b_uq() -30)#shrimp
    cf[2] +=  abs(sta.l_lq() -49) + abs(sta.l_uq() - 64) + abs(sta.a_lq() +21) + abs(sta.a_uq() - 25) + abs(sta.b_lq() +22) + abs(sta.b_uq() -45)#tsuna
    cf[3] +=  abs(sta.l_lq() -40) + abs(sta.l_uq() - 71) + abs(sta.a_lq() +21) + abs(sta.a_uq() - 28) + abs(sta.b_lq() +50) + abs(sta.b_uq() -31)#ikura
    cf[4] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[5] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[6] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[7] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[8] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg
    cf[9] +=  abs(sta.l_lq() -32) + abs(sta.l_uq() - 83) + abs(sta.a_lq() +3) + abs(sta.a_uq() - 23) + abs(sta.b_lq() +55) + abs(sta.b_uq() -37)#egg

        #max_value = max(cf)
    max_value = cf[0]
    print("0 : ", cf[0])
    for i in range(1,10):
        print(i, " : ", cf[i])
        if(max_value > cf[i]):
            max_value = cf[i]

    max_index = cf.index(max_value)
    if(max_value > 100):
        max_index = 9

    print("max_index: ", max_index)
#    text_tmp = fish[max_index]
#    lcd.draw_string(30,40, "test", 255, 200)
    if(max_index ==0):
        lcd.display(image.Image("egg.jpg"))
        #lcd.clear()
    elif(max_index==1):
        lcd.display(image.Image("shrimp.jpg"))
    elif(max_index==2):
        lcd.display(image.Image("tsuna.jpg"))
    elif(max_index==3):
        lcd.display(image.Image("ikura.jpg"))
        #lcd.clear
    elif(max_index==9):
        lcd.display(image.Image("nothing.jpg"))
        #lcd.display(canvas)
        #lcd.clear()
    gc.collect()
    print(clock.fps())
