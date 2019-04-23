import processing.serial.*; //<>//
Serial port1;


Bil s;
Background bg;
Physics fys;
State state = State.MENU;
int level = 1;
int score = 0;
int z;
enum State {
  MENU,
  GAME
}

void setup(){
  size(800, 480);
  
  s = new Bil();
  bg = new Background();
  fys = new Physics();
  port1 = new Serial(this, "/dev/ttyAMC0", 9600);
  
  s.setHide(true);
  fys.add(s);
  //fys.add(balls[0]);
 // fys.add(balls[1]);
  border();
  state=State.MENU;
  lockInput(500);
  
  
}
void border(){
  
  for(float i = 0; i < 2*PI; i+=2*PI/90 ){
    PVector c1 = PVector.fromAngle(i);
    c1.x *= 395; c1.y *= 200;
    c1.add(new PVector(400,240));
    fys.add(new Ball(c1.x, c1.y, 8));
  }
  for(float i = 0; i < 2*PI; i+=2*PI/80){
    PVector c2 = PVector.fromAngle(i);
    c2.x *= 350; c2.y *= 155;
    c2.add(new PVector(400,240));
    fys.add(new Ball(c2.x, c2.y, 8));
  }
}

void resetGame() {
  level=1;
  score=0;
  fys.reset();
  s.reset();
  fys.add(s);
  //fys.add(balls[0]);
  //fys.add(balls[1]);
  border();
  state=State.GAME;
}

void nextLevel() {
  score+=level*250;
  level++;
  }

void scoreBoard() {
  textFont(createFont("Arial",height/32,false));
  textAlign(LEFT);
  text("LEVEL: "+level,0,height/32);
  text("SCORE: "+score,0,2*height/32);
}

void showMenu() {
  textFont(createFont("Arial",height/20,false));
  textAlign(CENTER);
  text("CARS by Martin Jensen & Felix Mathiassen",width/2,height/2);
  textFont(createFont("Arial",height/24,false));
  text("Press PEDAL to start",width/2,height/2+height/8);
}




void draw(){
  bg.display();
  if(port1.available()>0){z = port1.read(); s.setThrust(z/1000);
  fys.updateWorld();
  fys.display();
  if (state == State.MENU) { showMenu(); }

   
}
  


  
