class StateMachine {
  
  State currentState;
  PGraphics graphicsCurrent;
  PGraphics graphicsNew;
  public int windowWidth;
  public int windowHeight;
  public int wallHeight;
  
  StateMachine(int windowWidth, int windowHeight, int wallHeight){
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    this.wallHeight = wallHeight;
  }
  
  void setState(State state){
    currentState = state;
  }

  void update() {
    currentState.begin();
    currentState.update();
    currentState.end();
    
    image(currentState.pg, 0, 0);
  }
  
  State getCurrentState(){
    return currentState;
  }
  
  boolean isInState(State state){
   return currentState == state;
  }

  void transitionTo(State newState, float time) {
    currentState.exitTransition(newState, time);
    newState.enterTransition(currentState, time);
    currentState = newState;
    
    //float alpha = 255;
    //Ani.to(this, time, "alpha", 255);
  }
}