public class TestState2 extends State{
  
  public TestState2(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
  
}