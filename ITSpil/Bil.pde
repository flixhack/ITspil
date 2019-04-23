class Bil extends PhysObject {
  float dir,t=0,av=0;
  boolean hide = false;
  
  PShape shipShape;
  
  Bil() {
    reset();
    size = 4;
    shipShape = createShape();
    shipShape.beginShape();
    shipShape.stroke(255);
    shipShape.noFill();
    shipShape.vertex(size*1.5,0);
    shipShape.vertex(-size,-size);
    shipShape.vertex(0,0);
    shipShape.vertex(-size,size);
    shipShape.endShape(CLOSE);
  }
  
  void reset() {
    pos.x = 400;//width/2;
    pos.y = 420;//height/2;
    vel.x = vel.y = 0;
    t=av=dir=0;
  }
  
  void setHide(boolean b) { hide = b; }
  void setTurn(float a) { this.av = a; }
  void setThrust(float t) { this.t = t; }
  
  void display() {
    if (hide) return;
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(dir);
    shape(shipShape);
    popMatrix();
  }
  
  void update() {
    super.update();
    dir += this.av;
    vel.add(PVector.fromAngle(dir).setMag(t));
    vel.mult(0.98);
    
    if (pos.x > width) pos.x -= width;    
    if (pos.x < 0) pos.x += width;    
    if (pos.y > height) pos.y -= height;    
    if (pos.y < 0) pos.y += height;        
  } 
  
    void onCollision(PhysObject o) {
    if (o instanceof Ball && state==State.GAME) {
      // Oh dear.. theres a roid in the ship!!
      setHide(true);
      reset();
      for (int i=0;i<10;i++) {
      //  world.add(new Explosion(PVector.fromAngle(random(2*PI)).setMag(random(15)).add(s.pos),floor(random(10,300))));
      }
      state=State.MENU;
      lockInput(1500);
    }
  }
  
  
}
