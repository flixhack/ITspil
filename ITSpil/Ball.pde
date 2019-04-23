class Ball extends PhysObject {
  
 // PVector position;
  float radius, m;

  Ball(float x, float y, float r_) {
    pos = new PVector(x, y);
    size = r_;
    m = size*.1;
  }
  
  //void onCollision(PhysObject o){
  // if(o.expired == false)
  // this.expire();
  //}

  void display() {
    noStroke();
    fill(0,0,0);
    ellipse(pos.x, pos.y, size*2, size*2);
  }
}
