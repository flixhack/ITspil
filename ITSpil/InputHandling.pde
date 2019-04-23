int inputLockedUntil = 0;

void lockInput(int duration_ms) {
  inputLockedUntil = millis() + duration_ms;
}


void keyPressed(){
  
  switch (state) {
    case MENU:
    if (key == ' ') {
      resetGame();
      s.setHide(false);
      state=State.GAME;
    }
    return;
    
    case GAME:
      if (key == CODED) {
        switch (keyCode) {
          case LEFT: s.setTurn(-4 * PI/180);break;
          case RIGHT: s.setTurn(4 * PI/180);break;
          case UP: s.setThrust(0.18);break;
        }
      }
   }
}
void keyReleased() {
  if (millis() < inputLockedUntil) return;
  
  switch (state) {
    case GAME:
      if (key == CODED) {
        switch (keyCode) {
          case LEFT: s.setTurn(0);break;
          case RIGHT: s.setTurn(0);break;
          case UP: s.setThrust(0);break;
        }
      }
      return;
    default:
  }
}
