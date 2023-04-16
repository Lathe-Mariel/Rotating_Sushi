// #include <Arduino.h>
#include <M5StickC.h>

const int STEP = 0;
int speed = 30000; // interval time
int target_speed = 10000;
boolean isStop = 1;

void setup()
{

  M5.begin();
  M5.Lcd.setRotation(1);
  M5.Lcd.fillScreen(BLUE);
  M5.Lcd.setTextSize(4);
  M5.Lcd.print("start");
  // Serial.begin(9600);

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
    if (diff < -50)
    {
      M5.Lcd.setCursor(0, 0);
      M5.Lcd.printf("%d ", speed);
      speed -= 50;
    }
    else if (diff > 50)
    {
      M5.Lcd.setCursor(0, 0);
      M5.Lcd.printf("%d ", speed);
      speed += 50;
    }
    if(speed > 29940){
      isStop = 1;
    }
  }
  if(M5.BtnA.wasReleasefor(100)){
    if(isStop){
      isStop = 0;
      target_speed = 15000;
      speed = 29000;
    }else if(target_speed == 15000){
      target_speed = 10000;
    }else if(target_speed == 10000){
      target_speed = 7000;
    }else if(target_speed == 7000){
      target_speed = 30000;
    }
  }
}