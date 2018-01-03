public abstract class State{
  
  protected StateMachine m;
  public PGraphics pg;
  public Player curPlayer;
  public Attractor curAttractor;
  
  public State(StateMachine stateMachine){
    this.m = stateMachine;
    this.pg = createGraphics(WindowWidth, WindowHeight);
  }

  abstract void enterTransition(State from, float time);
  
  void begin(){
    pg.beginDraw();
  }
  
  void update(){
    if(curPlayer == null){
       for(HashMap.Entry<Player, Attractor> entry : attractorMap.entrySet())
      {
        curPlayer = entry.getKey();
        curAttractor = entry.getValue();
        break;
      }
    }
  }
  
  void end(){
    pg.endDraw();
  }
  
  abstract void exitTransition(State to, float time);
  
  void playerAdded(Player player){
    Attractor attractor = new Attractor(player.x, player.y);
    attractorMap.put(player, attractor);
    if(curPlayer == null){
      curPlayer = player;
      curAttractor = attractor;
    }
  }
  
  void playerRemoved(Player player){
    attractorMap.remove(player);
    if(player.equals(curPlayer)){
      curPlayer = null;
      curAttractor = null;
      for(HashMap.Entry<Player, Attractor> entry : attractorMap.entrySet())
      {
      curPlayer = entry.getKey();
      curAttractor = entry.getValue();
      break;
      }
    }
  }
  
}