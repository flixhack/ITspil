int val; 

void setup() {
  Serial.begin(9600);
}

void loop() {
  val = (analogRead(A2)/4);
  Serial.write(val);
  delay(100);
}
