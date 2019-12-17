/*
https://forum.processing.org/one/topic/keyboard-emulation.html
https://docs.oracle.com/javase/6/docs/api/java/awt/event/KeyEvent.html
https://docs.oracle.com/javase/6/docs/api/java/awt/event/KeyEvent.html#KEY_TYPED
https://gist.github.com/Happsson/778dd86ba1747f12d025f32db54673d4
*/


import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.util.Arrays;
import java.awt.*;

int baud = 9600;

Serial mPort;
boolean connected;
Robot robot;

String serialArray = "";
float[] incommingMessage = new float[10];
int index = 0;
int drawVal; 
void setup()  { 
  size(400, 400);
  smooth();
  fill(0);
  colorMode(RGB, 1);
  println("initializing robot");
  try{
    robot = new Robot();
  }catch(AWTException e){
   println("Could not start robot"); 
  }
  
  for(int i = 0; i < Serial.list().length; i++){
    serialArray += "["+i+"]: " + Serial.list()[i] + "\n";
  }

} 


 void serialEvent(Serial mPort){

  //int inByte = mPort.read();
  //println((char)inByte);
  //robot.keyPress(inByte);
  //robot.keyRelease(inByte);
}

void draw()  { 

  background(0,0,0);
  if(!connected){
   textSize(30);
   fill(1,1,1,1);
   text("Please select port \n(enter on keyboard)", 10,50);
   textSize(18);
   text(serialArray, 10,150);
  }else{
 if(connected){
     textSize(30);
     fill(1,1,1,1);
     text("Running\nConnected", 10,50);
     
       while (mPort.available() > 0) {
          int inByte = mPort.read();
          print((char)inByte);
          if(inByte == 10){
            //'\n'
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
          }else if(inByte == 9){
            //'\t'
            robot.keyPress(KeyEvent.VK_TAB);
            robot.keyRelease(KeyEvent.VK_TAB);
          }else if(inByte == 32){
            //space ' '
            robot.keyPress(KeyEvent.VK_SPACE);
            robot.keyRelease(KeyEvent.VK_SPACE);
          }else if(inByte >= 97 && inByte <= 122){
            //a-z
            robot.keyPress(inByte-32);
            robot.keyRelease(inByte-32);
          }else if(inByte >= 48 && inByte <= 57){
            //Number 0-9
            robot.keyPress(inByte);
            robot.keyRelease(inByte);
          }else if(inByte >= 65 && inByte <= 90){
            //Captital letter
            robot.keyPress(KeyEvent.VK_SHIFT);
            robot.keyPress(inByte);
            robot.keyRelease(inByte);
            robot.keyRelease(KeyEvent.VK_SHIFT);
          }else if(inByte == '.'){
            // '.'
            robot.keyPress(KeyEvent.VK_PERIOD);
            robot.keyRelease(KeyEvent.VK_PERIOD);
          }else if(inByte == ','){
            // ','
            robot.keyPress(KeyEvent.VK_COMMA);
            robot.keyRelease(KeyEvent.VK_COMMA);
          }else if(inByte == '@'){
            // '@'
            //robot.keyPress(KeyEvent.VK_AT);
            //robot.keyRelease(KeyEvent.VK_AT);
          }else if(inByte == '-'){
            // '@'
            robot.keyPress(KeyEvent.VK_MINUS);
            robot.keyRelease(KeyEvent.VK_MINUS);
          }else if(inByte == '+'){
            // '+'
            //robot.keyPress(KeyEvent.VK_PLUS);
            //robot.keyRelease(KeyEvent.VK_PLUS);
          }else if(inByte == '/'){
            // '/'
            robot.keyPress(KeyEvent.VK_SLASH);
            robot.keyRelease(KeyEvent.VK_SLASH);
          } else if(inByte == ';'){
            // ';'
            robot.keyPress(KeyEvent.VK_SEMICOLON);
            robot.keyRelease(KeyEvent.VK_SEMICOLON);
          } else if(inByte == ':'){
            // ':'
            //robot.keyPress(KeyEvent.VK_COLON);
            //robot.keyRelease(KeyEvent.VK_COLON);
          }else if(inByte == '='){
            // '='
            robot.keyPress(KeyEvent.VK_EQUALS);
            robot.keyRelease(KeyEvent.VK_EQUALS);
          }else if(inByte == '['){
            // '['
            robot.keyPress(KeyEvent.VK_OPEN_BRACKET);
            robot.keyRelease(KeyEvent.VK_OPEN_BRACKET);
          }else if(inByte == ']'){
            // '['
            robot.keyPress(KeyEvent.VK_CLOSE_BRACKET);
            robot.keyRelease(KeyEvent.VK_CLOSE_BRACKET);
          }else if(inByte == 92){
            // '\'
            robot.keyPress(KeyEvent.VK_BACK_SLASH);
            robot.keyRelease(KeyEvent.VK_BACK_SLASH);
          }else if(inByte == '^'){
            // '^'
            //robot.keyPress(KeyEvent.VK_CIRCUMFLEX);
            //robot.keyRelease(KeyEvent.VK_CIRCUMFLEX);
          }else if(inByte == '$'){
            // '$'
            //robot.keyPress(KeyEvent.VK_DOLLAR);
            //robot.keyRelease(KeyEvent.VK_DOLLAR);
          }else if(inByte == '!'){
            // '!'
            //robot.keyPress(KeyEvent.VK_EXCLAMATION_MARK);
            //robot.keyRelease(KeyEvent.VK_EXCLAMATION_MARK);
          }else if(inByte == '('){
            // '('
            //robot.keyPress(KeyEvent.VK_LEFT_PARENTHESIS);
            //robot.keyRelease(KeyEvent.VK_LEFT_PARENTHESIS);
          }else if(inByte == ')'){
            // ')'
            //robot.keyPress(KeyEvent.VK_RIGHT_PARENTHESIS);
            //robot.keyRelease(KeyEvent.VK_RIGHT_PARENTHESIS);
          }else if(inByte == '#'){
            // '#'
            //robot.keyPress(KeyEvent.VK_NUMBER_SIGN);
            //robot.keyRelease(KeyEvent.VK_NUMBER_SIGN);
          }else if(inByte == '_'){
            // '_'
            //robot.keyPress(KeyEvent.VK_UNDERSCORE);
            //robot.keyRelease(KeyEvent.VK_UNDERSCORE);
          }
      }
     
   }
  }
} 

void keyPressed(){
  if(!connected){
  if(((int) key >= 48 && (int) key <= 57)){
    int val = key - 48;
    if(val < Serial.list().length){
      serialArray = "Connecting..";
     tryConnect(val); 
    }else{
     println("invalid choice"); 
    }
  }
  }
}
void tryConnect(int port){
  
  
  if(mPort != null){
      mPort.stop(); 
  }
  try{
    mPort = new Serial(this, Serial.list()[port], baud); 
    connected = true;
    mPort.bufferUntil(10);
  }catch(Exception e){
    connected = false;
  }
  
}
