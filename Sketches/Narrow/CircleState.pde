import de.looksgood.ani.*;

float circleSize = 8000/shrink;
float circleRed = 0;

public class CircleState extends State {
  
  boolean startEncircle = false;
  boolean startColorize = false;
  color circleColor = color(0);
  boolean grounded = true;
  Ani colorAni;
  Ani sizeAni;
  public float curBounceSize = circleSize/2f;
  public float bounceDecreaser = circleSize/10f;
  
  public CircleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    init();
  }
  
  void init(){
    circleSize = 8000/shrink;
    circleRed = 0;
    startEncircle = false;
    startColorize = false;
    circleColor = color(0);
    grounded = true;
    colorAni = null;
    sizeAni = null;
    curBounceSize = circleSize/2;
  }
  
  void update(){
    super.update();
    pg.background(255);
    /*pg.fill(255,150);
    pg.rect(0,0,WindowWidth,WallHeight);*/
    pg.smooth();
    pg.noStroke();
    
    if(curPlayer != null){
      
      if(circleSize <= 0 && !circleStateDebug)
        stateMachine.transitionTo(new PlexusState(stateMachine), 2);
      
      if(!startEncircle){
        if(sizeAni == null || !sizeAni.isPlaying()){
          if(sizeAni != null) sizeAni.end();
          sizeAni = Ani.to(stateMachine.applet, circleShrinkTime, "circleSize", 0, Ani.SINE_OUT);
          startEncircle = true;
        }
      }
      
      if(circleSize < circleSizeColorChange && !startColorize){
        if(colorAni == null || !colorAni.isPlaying()){
          if(colorAni != null) colorAni.end();
          colorAni = Ani.to(stateMachine.applet, circleShrinkTime/5f, "circleRed", 255);
          startColorize = true;
        }
      }
        
      curPlayer.isJumping();
      if(!curPlayer.isGrounded)
        grounded = false;
      if(!grounded && curPlayer.isGrounded && curBounceSize > 0){
        grounded = true;
        if(startColorize){
          if(sizeAni != null) sizeAni.end();
          if(colorAni != null) colorAni.end();
          sizeAni = Ani.to(stateMachine.applet, circleBounceTime, "circleSize", curBounceSize, Ani.QUART_IN);
          colorAni = Ani.to(stateMachine.applet, circleBounceTime, "circleRed", 0);
          startColorize = false;
          startEncircle = false;
          curBounceSize -= bounceDecreaser;
        }
      }
        
      circleColor = color(circleRed, 0, 0);
      
      for(int i = 2000; i > 0; i-=200){
        pg.stroke(circleColor, 255-i/7);
        pg.strokeWeight((2000-i)/50/shrink * circleSize/(8000/shrink));
        pg.noFill();
        pg.ellipse(curPlayer.x, curPlayer.y - WallHeight, circleSize + i/shrink, circleSize + i/shrink);
        pg.noStroke();
      }
      
      pg.fill(circleColor);
      pg.ellipse(curPlayer.x, curPlayer.y - WallHeight, circleSize, circleSize);
    }
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
    if(sizeAni != null) sizeAni.end();
    if(colorAni != null) colorAni.end();
  }
}