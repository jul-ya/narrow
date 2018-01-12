import de.looksgood.ani.*;

float rectIncreasePerSecond = 10;
float rectAlpha = 0;

float rectIncreasePerSecondStart = 10;
float rectIncreasePerSecondEnd = 1200;
float rectIncreaseTime = 20f;

public class RectangleState extends State {
  
  boolean white = false;
  float rectSize = 0;
  float heightPercentage = (float)(WindowHeight-WallHeight)/(float)WindowWidth;
  
  public RectangleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    init();
  }
  
  void init(){
    rectSize = 0;
    rectIncreasePerSecond = rectIncreasePerSecondStart;
    Ani.to(stateMachine.applet, rectIncreaseTime, "rectIncreasePerSecond", rectIncreasePerSecondEnd, Ani.SINE_IN);
    Ani.to(stateMachine.applet, rectIncreaseTime, "rectAlpha", 255, Ani.QUAD_IN);
  }
  
  void update(){
    super.update();
    pg.background(0);
    pg.smooth();
    pg.noStroke();
    
    if(curPlayer != null){
      
      if(rectIncreasePerSecond == rectIncreasePerSecondEnd && !stateMachine.stateInit)
        stateMachine.transitionTo(new PlexusState(stateMachine), 2);
        
      rectSize += rectIncreasePerSecond * deltaTime;
      
      for(int i = 0; i < 100; i++){
        if(white){
          pg.fill(rectAlpha);
        } else {
          pg.fill(0);
        }
        float curSize = rectSize-(i*100);
        curSize = max(curSize, 0);
        white = !white;
        pg.rect(curPlayer.x - curSize/2,curPlayer.y - WallHeight - curSize*heightPercentage/2, curSize, curSize*heightPercentage);
      }
    }
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
}