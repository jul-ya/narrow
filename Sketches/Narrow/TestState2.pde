//Nearest Neighbour State
public class TestState2 extends State{
  
  public TestState2(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
  
    drawPlayerGrid();
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
  
  
  void drawPlayerGrid()
  {
      //Do Something
    
  }
  
    
  void playerAdded(Player player){
    //nnMap.put(player, new Attractor(player.x, player.y));
    //Just add one Player
  }
  
  void playerRemoved(Player player){
    //nnMap.remove(player);
  }
  
}