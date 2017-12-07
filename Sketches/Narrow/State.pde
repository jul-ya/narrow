public abstract class State {
  
  protected StateMachine stateMachine;
  public PGraphics pg;
  
  public State(StateMachine stateMachine){
    this.stateMachine = stateMachine;
    this.pg = createGraphics(stateMachine.windowWidth, stateMachine.windowHeight);
  }

  abstract void enterTransition(State from, float time);
  
  void begin(){
    pg.beginDraw();
  }
  
  abstract void update();
  
  void end(){
    pg.endDraw();
  }
  
  abstract void exitTransition(State to, float time);
  
}