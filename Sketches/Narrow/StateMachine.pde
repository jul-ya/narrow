import de.looksgood.ani.*;
float alpha = 255;

class StateMachine {
  
  State currentState;
  State newState;
  
  public PharusClient pc;
  
  PApplet applet;
  
  StateMachine(PApplet applet){
    this.applet = applet;
    
    this.pc = new PharusClient(applet, WallHeight);
    pc.setMaxAge(50);
    pc.setjumpDistanceMaxTolerance(0.05f); 
  }
  
  void setState(State state){
    currentState = state;
    newState = state;
  }

  void update() {
    if(alpha >= 255){
      
      currentState = newState;
      
      currentState.begin();
      currentState.update();
      currentState.end();
      
      image(currentState.pg, 0, 0);
    } else {
      currentState.begin();
      currentState.update();
      currentState.end();
      
      newState.begin();
      newState.update();
      newState.end();
      
      image(currentState.pg, 0, 0);
      tint(255, alpha);
      image(newState.pg, 0, 0);
    }
  }
  
  State getCurrentState(){
    return currentState;
  }
  
  boolean isInState(State state){
   return currentState == state;
  }

  void transitionTo(State newState, float time) {
    this.newState = newState;
    currentState.exitTransition(newState, time);
    newState.enterTransition(currentState, time);
    
    alpha = 0;
    Ani.to(applet, time, "alpha", 255);
  }
}