import sensor, image, time, gc, lcd
from Maix import GPIO
from fpioa_manager import fm
import Maix
import KPU

from modules import ws2812
#class_ws2812_body = ws2812(7,10)  #本体LED

LED_POWER = 150
#LED_POWER = 0
class_ws2812 = ws2812(35,23)  #Grove Port Yellow
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

lcd.init(freq=15000000)

clock = time.clock();

lcd.clear()

while(True):
#    clock.tick()
    img = sensor.snapshot()
    #print(KPU.memtest())
    #tmpImg = img.copy()
    #print("2")
    #print(KPU.memtest())
    cf=[0,0,0,0,0,0,0,0,0,0]
    fish=["egg.jpg", "shrimp.jpg", "tsuna.jpg", "ikura.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "nothing.jpg"]


    #mask = tmpImg.binary([(20,64,-15,55,-80,-15)],invert=True)

#    workImg = img.copy()
#    workImg = workImg.cartoon(0.3, 0.2)
#    workImg = workImg.bilateral(1, color_sigma=1.0, space_sigma=0.5)

#    img = img.laplacian(2)
    img = img.cartoon(0.05, 0.1)
    foundCircles = img.find_circles(x_stride=2, y_stride=2, threshold=1200)
    #print(foundCircles)
    for index, item in enumerate(foundCircles):
        if(item[2] > 30):
            img.draw_circle(item[0], item[1], item[2], color=(255,0,0), thickness=2)
            print("sushi: ", item)
            distance = item[2] - 2
            distance_sq = (int)(distance / 1.4)

            #img.set_pixel(item[0]-distance, item[1], (255, 255, 255))
            pp1  = img.get_pixel(item[0]-distance, item[1])
            print("pp1-1: ", pp1)
            tmp1 = img.get_pixel(item[0]+distance, item[1])
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            print("pp1-2: ", pp1)
            tmp1 = img.get_pixel(item[0], item[1]-distance)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            print("pp1-3: ", pp1)
            tmp1 = img.get_pixel(item[0], item[1]+distance)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            print("pp1-4: ", pp1)
            tmp1 = img.get_pixel(item[0]+distance_sq, item[1]+distance_sq)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            tmp1 = img.get_pixel(item[0]-distance_sq, item[1]-distance_sq)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            tmp1 = img.get_pixel(item[0]+distance_sq, item[1]-distance_sq)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            tmp1 = img.get_pixel(item[0]-distance_sq, item[1]+distance_sq)
            pp1 = [x + y for x, y in zip(pp1, tmp1)]
            print("pp1: ", pp1)

            pp2  = img.get_pixel(item[0]+4, item[1]) #center
            tmp1 = img.get_pixel(item[0]-4, item[1]) #center
            pp2 = [x + y for x, y in zip(pp1, tmp1)]
            tmp1 = img.get_pixel(item[0], item[1]-4) #center
            pp2 = [x + y for x, y in zip(pp1, tmp1)]
            tmp1 = img.get_pixel(item[0], item[1]+4) #center            pp2 += [x + y for x, y in zip(pp1, tmp1)]
            pp2 = [x + y for x, y in zip(pp1, tmp1)]
            print("pp2: ", pp2)

            cf[0] += pp1[0] *   0 + pp1[1] * 0.6 + pp1[2] * 1.7 + pp2[0] * 0.5 + pp2[1] * 1 + pp2[2] * 0.4 #egg
            cf[1] += pp1[0] *   0 + pp1[1] * 2.5 + pp1[2] *   0 + pp2[0] * 0.5 + pp2[1] * 0.7 + pp2[2] * 0 #shrimp
            cf[2] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] * 1.2 + pp2[0] *   2 + pp2[1] *   0 + pp2[2] *   0 # + pp1[2] * pp2[0] #tuna
            print("pp1[2] * pp2[0]: ", pp1[2] * pp2[0])

            cf[3] += pp1[0] *   1.2 + pp1[1] * 1.0 + pp1[2] *   0 + pp2[0] * 1.1 + pp2[1] *   0.6 + pp2[2] *   0 #ikura
            cf[4] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   0 + pp2[0] *   0 + pp2[1] *   0 + pp2[2] *   0 #
            cf[5] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   0 + pp2[0] *   0 + pp2[1] *   0 + pp2[2] *   0 #
            cf[6] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   0 + pp2[0] *   0 + pp2[1] *   0 + pp2[2] *   0 #
            cf[7] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   0 + pp2[0] *   0 + pp2[1] *   0 + pp2[2] *   0 #
            cf[8] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   0 + pp2[0] *   0 + pp2[1] *   0 + pp2[2] *   0 #
            cf[9] += pp1[0] *   0 + pp1[1] *   0 + pp1[2] *   1 + pp2[0] *   1 + pp2[1] *   1 + pp2[2] *   0 #only rice
            break
       # cf[0] += pp2[0] * 0 + pp2[1] * 1 + pp2[2] * 1 #egg
       # cf[1] += pp2[0] * 0 + pp2[1] * 2 + pp2[2] * 0 #shrimp
       # cf[2] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1.5 #tuna
       # cf[3] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[4] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[5] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[6] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[7] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[8] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg
       # cf[9] += pp2[0] * 0 + pp2[1] * 0 + pp2[2] * 1 #egg

        #max_value = max(cf)
    max_value = 0
    for i in range(10):
        print(i, " : ", cf[i])
        if(max_value < cf[i]):
            max_value = cf[i]

    max_index = cf.index(max_value)
    if(max_value < 1500):
        max_index = 9

    print("max_index: ", max_index)
#    text_tmp = fish[max_index]
#    lcd.draw_string(30,40, text_tmp, 255, 200)
#    canvas = image.Image("ikura.jpg")
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
