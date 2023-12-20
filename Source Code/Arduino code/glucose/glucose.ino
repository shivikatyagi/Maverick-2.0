const int sensorPin = A0;
const int ledPin = 13;   

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  
  int sensorValue = analogRead(sensorPin);

  float rotationAngle = map(sensorValue, 0, 1023, 0, 360);

  Serial.print("Rotation Angle: ");
  Serial.print(rotationAngle);
  Serial.println(" degrees");

  if (rotationAngle > 180) {
    digitalWrite(ledPin, LOW);
  } else {
    digitalWrite(ledPin, HIGH);
  }

  delay(1000);
}
