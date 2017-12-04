public abstract class State {
  
  protected StateMachine stateMachine;
  
  public State(StateMachine stateMachine){
    this.stateMachine = stateMachine;
  }

  abstract void enterTransition(State from, float time);
  abstract void update();
  abstract void exitTransition(State to, float time);
  
}