import de.looksgood.ani.*;

float rectSize = 0;
float rectIncreasePerSecond = 300;

public class RectangleState extends State {
  
  public RectangleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    init();
  }
  
  void init(){
    rectSize = 0;
  }
  
  void update(){
    super.update();
    pg.background(255);
    pg.smooth();
    pg.noStroke();
    
    //if(curPlayer != null){
      
      /*for(int i = 2000; i > 0; i-=200){
        pg.stroke(circleColor, 255-i/7);
        pg.strokeWeight((2000-i)/50/shrink * circleSize/(8000/shrink));
        pg.noFill();
        pg.ellipse(curPlayer.x, curPlayer.y - WallHeight, circleSize + i/shrink, circleSize + i/shrink);
        pg.noStroke();
      }*/
      boolean white = false;
      
      rectSize += rectIncreasePerSecond * deltaTime;
      println(rectSize);
      for(int i = 0; i < 10; i++){
        if(white){
          pg.fill(0);
        } else {
          pg.fill(255);
        }
        white = !white;
        pg.rect((WindowWidth/2)-(rectSize/2),((WindowWidth-WallHeight)/2)-(rectSize/2),rectSize,rectSize);
      }
      
      /*pg.fill(circleColor);
      pg.ellipse(curPlayer.x, curPlayer.y - WallHeight, circleSize, circleSize);*/
    //}
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
}