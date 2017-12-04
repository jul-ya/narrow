
// Version 4.1

float cursor_size = 25;
PFont font;
int windowWidth = 3030/5; // for real Deep Space this should be 3030
int windowHeight = 3712/5; // for real Deep Space this should be 3712
int wallHeight = 1914/5; // for real Deep Space this should be 1914 (Floor is 1798)

boolean ShowTrack = true;
boolean ShowPath = true;
boolean ShowFeet = true;

int show = 0xffff;

void settings()
{
  size(windowWidth, windowHeight); 
}

void setup()
{
  noStroke();
  fill(0);

  font = createFont("Arial", 18);
  textFont(font, 18);
  textAlign(CENTER, CENTER);

  initTracking(false, wallHeight);
}

void draw()
{
  // clear background with white
  background(255);

  // set upper half of window (=wall projection) bluish
  noStroke();
  fill(70, 100, 150);
  rect(0, 0, windowWidth, wallHeight);
  fill(150);
  text((int)frameRate + " FPS", width / 2, 10);

  if (ShowPath)
  {
    // show the motion path of each track on the floor    
    for (int trackID=0; trackID<GetNumTracks (); trackID++) 
    {      
      stroke(70, 100, 150, 25);
      int numPoints = GetNumPathPoints (trackID);
      if (numPoints > 1)
      {      
        int maxDrawnPoints = 300;      
        int startX = GetPathPointX(trackID, numPoints - 1);
        int startY = GetPathPointY(trackID, numPoints - 1);
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxDrawnPoints); pointID--) 
        {  
          int endX = GetPathPointX(trackID, pointID);
          int endY = GetPathPointY(trackID, pointID);
          line(startX, startY, endX, endY);
          startX = endX;
          startY = endY;
        }
      }
    }
  }

  if (ShowTrack)
  {
    // show each track with the corresponding  id number
    for (int trackID=0; trackID<GetNumTracks (); trackID++) 
    {
      noStroke();
      fill(192, 192, 192);
      ellipse(GetX(trackID), GetY(trackID), cursor_size, cursor_size);
      fill(0);
      text(GetCursorID(trackID), GetX(trackID), GetY(trackID));
    }
  }

  if (ShowFeet)
  {
    // show the feet of each track
    for (int trackID=0; trackID<GetNumTracks (); trackID++) 
    { 
      // if we had used keys <0> .. <9> to deactivate the feet for this track, then we skip it here
      if (((int)pow(2, trackID) & show) != (int)pow(2, trackID))
      {
        continue;
      }
      stroke(70, 100, 150, 200);
      noFill();
      // paint all the feet that we can find for one character
      for (int footID=0; footID<GetNumFeet (trackID); footID++)
      {
        ellipse(GetFootX(trackID, footID), GetFootY(trackID, footID), cursor_size / 3, cursor_size / 3);
      }
    }
  }
}

void keyPressed()
{
  switch(key)
  {
  case 'p':
    ShowPath = !ShowPath;
    break;
  case 't':
    ShowTrack = !ShowTrack;
    break;
  case 'f':
    ShowFeet = !ShowFeet;
    break;
  }
  
  // use keys <0> .. <9> to toggle foot drawing of tracks 0 .. 9
  if (key >= '0' && key <= '9')
  {
    show = show ^ (int)pow(2, key - '0');
  }
}