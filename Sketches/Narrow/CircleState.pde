import de.looksgood.ani.*;
float circleSize = 255;

public class CircleState extends State {
  
  public CircleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    encirclePlayer();
  }
  
  void update(){
    super.update();
    pg.background(255);
    if(curPlayer != null){
      pg.fill(0);
      pg.stroke(0);
      pg.ellipse(curPlayer.x, curPlayer.y, circleSize, circleSize);
    }
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
  
  void encirclePlayer(){
    Ani.to(stateMachine.applet, 10, "circleSize", 0);
  }
}