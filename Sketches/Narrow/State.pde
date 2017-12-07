public abstract class State {
  
  protected StateMachine m;
  public PGraphics pg;
  
  public State(StateMachine stateMachine){
    this.m = stateMachine;
    this.pg = createGraphics(WindowWidth, WindowHeight);
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
  
  abstract void playerAdded(Player player);
  abstract void playerRemoved(Player player);
  
}