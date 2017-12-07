public class TestState2 extends State{
  
  public TestState2(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
    pg.noStroke();
    pg.fill(70, 0, 150);
    pg.rect(0, 0, stateMachine.windowWidth, stateMachine.wallHeight);
    pg.fill(150);
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
  
}