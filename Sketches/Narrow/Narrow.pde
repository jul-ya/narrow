PFont font;

// GENERAL CONFIG
int shrink = 5;
int WindowWidth = 3030/shrink; // for real Deep Space this should be 3030
int WindowHeight = 3712/shrink; // for real Deep Space this should be 3712
int WallHeight = 1914/shrink; // for real Deep Space this should be 1914 (Floor is 1798)
boolean showFrameRate = false;

// CONFIG CIRCLE STATE
float circleSizeColorChange = 300/shrink; // to change when it's time to color the circle red and let the player trigger the bounce (increase circle size again)
float circleSizeStateChange = 50/shrink; // to change how big the circle is when the state is automatically changed
boolean circleStateDebug = false; // set true to disable state automatic changing


//CONFIG PLEXUS STATE
int numPoints = 30;    //number of userpoints - decrease to increase performance
int maxEnemies = 4;    //number of enemypoints - decrease to increase performance
float enemySpeed = 5;  // number of pixels to move per frame 
int pSize = 15/shrink;  //size of points
int eSize = 25/shrink;  //size of enemies
int lineWeight = 15/shrink; //linewidth

//*******************************
//END CONFIG
//*******************************

StateMachine stateMachine;

SoundInitiator soundInitiator;
SoundListener soundListener;

void settings()
{
  size(WindowWidth, WindowHeight); 
}

void setup()
{
  
  //fullScreen(P2D, SPAN); //Uncomment this!
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
}

void keyPressed()
{
  switch(key)
  { //<>//
  case 'x':
    stateMachine.transitionTo(new PlexusState(stateMachine), 2);
    break;
  case 'y':
    stateMachine.transitionTo(new CircleState(stateMachine), 2);
    break;
  }
}