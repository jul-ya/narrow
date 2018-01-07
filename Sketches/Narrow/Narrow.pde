float cursor_size = 25;
PFont font;

int shrink = 5;
int WindowWidth = 3030/shrink; // for real Deep Space this should be 3030
int WindowHeight = 3712/shrink; // for real Deep Space this should be 3712
int WallHeight = 1914/shrink; // for real Deep Space this should be 1914 (Floor is 1798)

// CONFIG CIRCLE STATE
float circleSizeColorChange = 300/shrink; // to change when it's time to color the circle red and let the player trigger the bounce (increase circle size again)
float circleSizeStateChange = 50/shrink; // to change how big the circle is when the state is automatically changed
boolean circleStateDebug = false; // set true to disable state automatic changing

StateMachine stateMachine;

SoundInitiator soundInitiator;
SoundListener soundListener;

void settings()
{
  size(WindowWidth, WindowHeight); 
}

void setup()
{
  //fullScreen(P2D, SPAN);
  frameRate(30);
  
  noStroke();
  fill(0);
  
  font = createFont("Arial", 18);
  textFont(font, 18);
  textAlign(CENTER, CENTER);

  Ani.init(this);
  
  soundInitiator = new SoundInitiator();
  soundListener = new SoundListener();
  soundInitiator.addListener(soundListener);
  
  stateMachine = new StateMachine(this);
  stateMachine.setState(new CircleState(stateMachine));
}

void draw()
{
  background(255);
  
  stateMachine.update();
  
  fill(255,0,0);
  text((int)frameRate + " FPS", width / 2, 10);
}

void keyPressed()
{
  switch(key)
  { //<>// //<>// //<>//
  case 'x':
    stateMachine.transitionTo(new PlexusState(stateMachine), 2);
    break;
  case 'y':
    stateMachine.transitionTo(new CircleState(stateMachine), 2);
    break;
  }
}