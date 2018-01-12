public class FinalState extends State {
  
  public FinalState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
    super.update();
    pg.background(0);
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
}