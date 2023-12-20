float calibration_value = 30;
int phval = 0;
unsigned long int avgval;
int buffer_arr[10], temp;
const int sensorPin = A0;
const int ledPin = 13; 

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {

   int sensorValue = analogRead(sensorPin);

   float rotationAngle = map(sensorValue, 0, 1023, 0, 360);
  
  for (int i = 0; i < 10; i++) {
    buffer_arr[i] = analogRead(A1);
    delay(30);
  }

  for (int i = 0; i < 9; i++) {
    for (int j = i + 1; j < 10; j++) {
      if (buffer_arr[i] > buffer_arr[j]) {
        temp = buffer_arr[i];
        buffer_arr[i] = buffer_arr[j];
        buffer_arr[j] = temp;
      }
    }
  }

  avgval = 0;
  for (int i = 2; i < 8; i++)
    avgval += buffer_arr[i];

  float volt = (float)avgval * 5.0 / 1024 / 6;
  float ph_act = -5.70 * volt + calibration_value;

  Serial.print("pH: ");
  Serial.println(ph_act);
  Serial.print("Rotation: ");
  Serial.println(rotationAngle);
   if (rotationAngle > 180) {
    digitalWrite(ledPin, HIGH);
  } else {
    digitalWrite(ledPin, LOW);
  }
delay(1000);

}
