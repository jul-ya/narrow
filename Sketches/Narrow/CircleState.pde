public class CircleState extends State {
  
  public CircleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
    super.update();
    pg.background(0);
    if(curPlayer != null){
      pg.stroke(255);
      pg.ellipse(curPlayer.x, curPlayer.y, 5, 5);
    }
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
}