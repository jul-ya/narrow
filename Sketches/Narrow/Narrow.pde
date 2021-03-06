//Import Minim Library
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

float deltaTime;
PFont font;

// GENERAL CONFIG
int shrink = 5;
int WindowWidth = 3030/shrink; // for real Deep Space this should be 3030
int WindowHeight = 3712/shrink; // for real Deep Space this should be 3712
int WallHeight = 1914/shrink; // for real Deep Space this should be 1914 (Floor is 1798)
boolean showFrameRate = false; // set true to show frame rate

// CONFIG CIRCLE STATE
float circleSizeColorChange = 1000/shrink; // to change when it's time to color the circle red and let the player trigger the bounce (increase circle size again)
float circleShrinkTime = 9f; // time the circle needs to shrink to zero
float circleBounceTime = 1f; // time the bounce needs to reach bounce maximum
boolean circleStateDebug = false; // set true to disable state automatic changing

// CONFIG PLEXUS STATE
int numPoints = 20;    // number of userpoints - decrease to increase performance
int maxEnemies = 4;    // number of enemypoints - decrease to increase performance
float enemySpeed = 5;  // number of pixels to move per frame 
int pSize = 20/shrink;  // size of points
int eSize = 40/shrink;  // size of enemies
int lineWeight = 10/shrink; //linewidth
int maxTriangles = 125; //max Num of Triangles

// CONFIG RECTANGLE STATE
float rectIncreasePerSecondStart = 50/shrink; // the size increase in pixels per second at start
float rectIncreasePerSecondEnd = 2500/shrink; // the size increase in pixels per second at end
float rectIncreaseTime = 20f; // the time the state lasts

//*******************************
//END CONFIG
//*******************************

StateMachine stateMachine;

SoundInitiator soundInitiator;
SoundListener soundListener;

//Initialize Minim Features
Minim minim;
AudioPlayer circleTrack;
AudioPlayer plexusTrack;
AudioPlayer rectangleTrack;
AudioSample snap;
AudioSample jump;
AudioPlayer generateTriangle;
AudioPlayer noise;

void settings()
{
  size(WindowWidth, WindowHeight); 
}

void setup()
{
  //fullScreen(P2D, SPAN);
  //noCursor();
  
  frameRate(30);
  noStroke();
  fill(0);
  
  font = createFont("Arial", 18);
  textFont(font, 18);
  textAlign(CENTER, CENTER);

  Ani.init(this);
  minim = new Minim(this);
  
  soundInitiator = new SoundInitiator();
  soundListener = new SoundListener();
  soundInitiator.addListener(soundListener);
  
  stateMachine = new StateMachine(this);
  stateMachine.setState(new CircleState(stateMachine));
}

void draw()
{
  deltaTime = frameRate/1000.0;
  
  stateMachine.update();
}

void keyPressed()
{
  switch(key)
  { //<>// //<>//
  case 'x':
    stateMachine.transitionTo(new PlexusState(stateMachine), 2);
    break;
  case 'y':
    stateMachine.transitionTo(new CircleState(stateMachine), 2);
    break;
  case 'z':
    stateMachine.transitionTo(new RectangleState(stateMachine), 2);
    break;
  }
}