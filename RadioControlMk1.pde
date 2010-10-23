/*
  
  Hobsbawm Radio Controller Mk 1

  Arduino-to-DAB radio interface
  
  This code controls a hacked Lava DAB radio.  A single
  pushbutton is connected to the Arduino circuit to 
  control the power on / channel change / power off
  behaviour though a series of single button pushes.
  
  First push - powers radio on from standby mode
  Second push - toggles to station preset 2
  Third push - toggles to station preset 3
  Fourth push - powers radio off to standby mode


  Code based on original code by Tom Igoe
  http://arduino.cc/en/Tutorial/ButtonStateChange

  v 3.1 23/10/2010
  
 
 */

// Set up control pins
const int  buttonPin = 2;    // the pin that the pushbutton is attached to
const int ledPin = 13;       // the pin that the LED is attached to

// Set up radio pins
const int pwrOnPin = 4;      // Connected to the STANDBY button
const int chan1Pin = 5;      // Connected to the Preset 1/4 button
const int chan2Pin = 6;      // Connected to the Preset 2/5 button


// Set up variables
int buttonPushCounter = 0;   // counter for the number of button presses
int buttonState = 0;         // current state of the button
int lastButtonState = 0;     // previous state of the button

void setup() {
  // initialize the button pin as a input:
  pinMode(buttonPin, INPUT);
  // initialize the LED as an output:
  pinMode(ledPin, OUTPUT);
  // initialize serial communication:
  Serial.begin(9600);
}


void loop() {
  // read the pushbutton input pin:
  buttonState = digitalRead(buttonPin);

  // compare the buttonState to its previous state
  if (buttonState != lastButtonState) {
    // if the state has changed, increment the counter
    if (buttonState == HIGH) {
      // if the current state is HIGH then the button
      // wend from off to on:
      buttonPushCounter++;
      Serial.println("on");
      Serial.print("number of button pushes:  ");
      Serial.println(buttonPushCounter, DEC);
      
      // Output state of radio controls
      switch(buttonPushCounter) {
        
        // First push
        case 1:
        
          // Write out to serial as a bug check
          Serial.println("Push 1: PWR on");

            // Set pin outputs
            digitalWrite(pwrOnPin, HIGH);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
            
            // Hold the state for 0.5 secs
            delay (500);
            
            // Reset pin outputs
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
            
          break;
          
        case 2:
          Serial.println("Push 2: CHAN1");
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, HIGH);
            digitalWrite(chan2Pin, LOW);
            
            delay (500);
            
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
            
          break;
          
        case 3:
          Serial.println("Push 3: CHAN2");
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, HIGH);
            
            delay (500);
            
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
            
          break;
          
        case 4:
          Serial.println("Push 4: PWR off");
            digitalWrite(pwrOnPin, HIGH);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
   
            delay (500);
            
            digitalWrite(pwrOnPin, LOW);
            digitalWrite(chan1Pin, LOW);
            digitalWrite(chan2Pin, LOW);
            
          break;
          
      } 
      
    }
    else {
      // if the current state is LOW then the button
      // wend from on to off:
      Serial.println("off"); 
    }

    // save the current state as the last state, 
    //for next time through the loop
    lastButtonState = buttonState;
  }
  
  // turns on the LED every four button pushes by 
  // checking the modulo of the button push counter.
  // the modulo function gives you the remainder of 
  // the division of two numbers:
  if (buttonPushCounter % 4 == 0) {
    digitalWrite(ledPin, HIGH);
    
    // Reset push count to zero
    buttonPushCounter = 0;
    
  } else {
   digitalWrite(ledPin, LOW);
  }
  
}
