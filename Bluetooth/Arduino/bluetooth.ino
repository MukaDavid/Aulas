

const int ledPin = 13;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);  
  pinMode (ledPin, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  byte dado;
  while (Serial.available() > 0){
    dado = Serial.read();
    if (dado == 1) {
      digitalWrite(ledPin, HIGH);  
    }else if (dado == 0) {
      digitalWrite(ledPin, LOW);
    }
  }
}
