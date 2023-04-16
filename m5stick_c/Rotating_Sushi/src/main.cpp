// #include <Arduino.h>
#include <M5StickC.h>

const int STEP = 0;
int speed = 3000; // interval time
int target_speed = 1000;
boolean isStop = 1;
const int ACCEL = 5;

void setup()
{

  M5.begin();
  M5.Lcd.setRotation(1);
  M5.Lcd.fillScreen(BLUE);
  M5.Lcd.setTextSize(4);
  M5.Lcd.print("start");

  pinMode(STEP, OUTPUT);
  digitalWrite(STEP, LOW);
}

void loop()
{
  M5.update();

  if (!isStop)
  {
    // Serial.print("1");
    digitalWrite(STEP, HIGH);
    delayMicroseconds(speed);
    digitalWrite(STEP, LOW);
    delayMicroseconds(speed);
    int diff = target_speed - speed;
    if (diff < -ACCEL)
    {
      M5.Lcd.setCursor(0, 0);
      M5.Lcd.printf("%d ", speed);
      speed -= ACCEL;
    }
    else if (diff > ACCEL)
    {
      M5.Lcd.setCursor(0, 0);
      M5.Lcd.printf("%d ", speed);
      speed += ACCEL;
    }
    if(speed > 3000-(ACCEL*2)){
      isStop = 1;
    }
  }
  if(M5.BtnA.wasReleasefor(100)){
    if(isStop){
      isStop = 0;
      target_speed = 1500;
      speed = 3000-ACCEL*3;
    }else if(target_speed == 1500){
      target_speed = 1000;
    }else if(target_speed == 1000){
      target_speed = 700;
    }else if(target_speed == 700){
      target_speed = 3000;
    }
  }
}