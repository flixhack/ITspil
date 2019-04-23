abstract class PhysObject {
  PVector pos,vel;
  float size = 0;
  boolean expired = false;
  PhysObject() { pos = new PVector(); vel = new PVector(); }
  void update() { pos.add(vel); }
  void expire() { expired=true;};
  void onCollision(PhysObject o) {};
  void onExpire() {};
  abstract void display();
}

class Physics {
  
  ArrayList<PhysObject> parts = new ArrayList();
  
  void reset() { parts.clear(); }
  void add(PhysObject o) { parts.add(o); }
  
  void updateWorld() {
    // update physics
    for (PhysObject part : parts) { part.update(); }
    // trigger collision events
    PhysObject a,b;
    for (int i=0;i<parts.size()-1;i++) { //<>//
      for (int t=i+1;t<parts.size();t++) {
        checkCollision(parts.get(i),parts.get(t));
      }
    }    
    // cleanup
    for (int i=parts.size()-1;i>=0;i--) {
      if (parts.get(i).expired) {
        parts.get(i).onExpire();
        parts.remove(i);
      }
    }
  }
  
  void checkCollision(PhysObject a, PhysObject b) {
    if (a instanceof Ball && b instanceof Ball) { return; }
    float overlap = PVector.dist(a.pos,b.pos)-(a.size+b.size);
    if (overlap < 0) {
      // reset to collision edge, wrt. obj sizes.
      //PVector n = PVector.sub(b.pos,a.pos).setMag(overlap);
      //a.pos.add(n.mult(b.size/(a.size+b.size)));
      //b.pos.add(n.mult(-a.size/(a.size+b.size)));
      // trigger calbacks
      //print("båm");
      a.onCollision(b);
      b.onCollision(a);
    }
  }
  
  int countType(Class<?> c) {
    int result = 0;
    for (PhysObject o : parts) { result+=int(c.isInstance(o)); }
    return result;
  }
  
  void display() {
    if (frameCount%10==0)
      println(frameRate);
    for (PhysObject part : parts) {
      part.display();
    }
  }
}
