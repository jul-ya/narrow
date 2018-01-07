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
  public float curBounceSize = circleSize/2;
  public float bounceDecreaser = circleSize/10;
  
  public CircleState(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    circleSize = 8000/shrink;
    circleRed = 0;
    startEncircle = false;
    startColorize = false;
    circleColor = color(0);
    grounded = true;
    colorAni = null;
    sizeAni = null;
    curBounceSize = circleSize;
  }
  
  void update(){
    super.update();
    pg.background(255);
    pg.smooth();
    pg.noStroke();
    
    if(curPlayer != null){
      
      /*if(circleSize <= 50/shrink)
        stateMachine.transitionTo(new PlexusState(stateMachine), 2);*/
      
      if(!startEncircle){
        if(sizeAni == null || !sizeAni.isPlaying()){
          if(sizeAni != null) sizeAni.end();
          sizeAni = Ani.to(stateMachine.applet, 5, "circleSize", 0/shrink, Ani.SINE_OUT);
          startEncircle = true;
        }
      }
      
      if(circleSize < 300/shrink && !startColorize){
        if(colorAni == null || !colorAni.isPlaying()){
          if(colorAni != null) colorAni.end();
          colorAni = Ani.to(stateMachine.applet, 2, "circleRed", 255);
          startColorize = true;
        }
      }
        
      curPlayer.isJumping();
      if(!curPlayer.isGrounded)
        grounded = false;
      if(!grounded && curPlayer.isGrounded && curBounceSize > 0){
        grounded = true;
        if(sizeAni != null) sizeAni.end();
        if(colorAni != null) colorAni.end();
        sizeAni = Ani.to(stateMachine.applet, 1, "circleSize", curBounceSize, Ani.QUART_IN);
        colorAni = Ani.to(stateMachine.applet, 1, "circleRed", 0);
        startColorize = false;
        startEncircle = false;
        curBounceSize -= bounceDecreaser;
      }
        
      circleColor = color(circleRed, 0, 0);
      
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