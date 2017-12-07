float cursor_size = 25;
PFont font;

int shrink = 5;
int WindowWidth = 3030/shrink; // for real Deep Space this should be 3030
int WindowHeight = 3712/shrink; // for real Deep Space this should be 3712
int WallHeight = 1914/shrink; // for real Deep Space this should be 1914 (Floor is 1798)

boolean ShowTrack = true;
boolean ShowPath = true;
boolean ShowFeet = true;

StateMachine stateMachine;
State testState1;
State testState2;

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

  //initPlayerTracking();
  Ani.init(this);
  
  stateMachine = new StateMachine(WindowWidth, WindowHeight, WallHeight, this);
  testState1 = new TestState1(stateMachine);
  testState2 = new TestState2(stateMachine);
  stateMachine.setState(testState1);
}

void draw()
{
  // clear background with white
  background(255);

  //drawPlayerTracking();
  
  stateMachine.update();
  
  text((int)frameRate + " FPS", width / 2, 10);
}

void keyPressed()
{
  switch(key)
  {
  case 'p':
    ShowPath = !ShowPath; //<>//
    break;
  case 't':
    ShowTrack = !ShowTrack;
    break;
  case 'f':
    ShowFeet = !ShowFeet;
    break;
  case 'x':
    stateMachine.transitionTo(testState2, 5);
    break;
  }
}