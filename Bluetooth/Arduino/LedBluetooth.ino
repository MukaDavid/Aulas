#include <BluetoothSerial.h>

const int ledPin = 21;
BluetoothSerial SerialBT;

void setup() {
  // put your setup code here, to run once:
  SerialBT.begin("ESP32");
  pinMode (ledPin, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  byte dado;
  while (SerialBT.available() > 0){
    dado = SerialBT.read();
    if (dado == 1) {
      digitalWrite (ledPin, HIGH);  
    }else if (dado == 0) {
      digitalWrite (ledPin, LOW);
    }
  }
}
