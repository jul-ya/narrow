class StateMachine {
  
  State currentState;
  
  void setState(State state){
    currentState = state;
  }

  void update() {
    currentState.update();
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
  }
}