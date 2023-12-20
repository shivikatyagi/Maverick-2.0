int sensorPin = A0;  
int ledPin = 13;      
int threshold = 200;    
void setup() {
  Serial.begin(9600);
  pinMode(sensorPin, INPUT);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  int sensorValue = digitalRead(sensorPin);
  Serial.println(sensorValue); 

  if (sensorValue == HIGH) {
    digitalWrite(ledPin,HIGH); 
  } else {
    digitalWrite(ledPin,LOW); 
  }

  delay(1000); 
}
