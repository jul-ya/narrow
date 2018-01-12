public class RectangleState extends State {
  
  boolean white = false;
  float rectSize = 0;
  float rectIncreasePerSecond = 300;
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
  }
  
  void update(){
    super.update();
    pg.background(255);
    pg.smooth();
    pg.noStroke();
    
    if(curPlayer != null){
      
      if(rectSize > WindowWidth*1.65)
        rectSize = WindowWidth;
        
      println(heightPercentage);
      rectSize += rectIncreasePerSecond * deltaTime;
      
      for(int i = 0; i < 10; i++){
        if(white){
          pg.fill(0);
        } else {
          pg.fill(255);
        }
        float curSize = rectSize-(i*100);
        curSize = max(curSize, 0);
        white = !white;
        pg.rect(curPlayer.x, curPlayer.y - WallHeight, curSize, curSize*heightPercentage);
      }
    }
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
}