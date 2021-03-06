class Player
{
  public Player(PharusClient pc, int id, long tuioId, float x, float y)
  {
    this.pc = pc;
    this.id = id;
    this.tuioId = tuioId;
    this.x = x;
    this.y = y;
  }

  // --- All the information about a player ---
  PharusClient pc; // do not modify this, PharusClient updates it
  int id; // do not modify this, PharusClient updates it
  long tuioId; // do not modify this, PharusClient updates it
  int age; // do not modify this, PharusClient updates it
  float x; // do not modify this, PharusClient updates it
  float y; // do not modify this, PharusClient updates it
  ArrayList<Foot> feet = new ArrayList<Foot>(); // do not modify this, PharusClient updates it
  
  boolean isGrounded = true;

  // --- Some functions that have information about the player ---
  boolean isJumping()
  {
    // we assume that we jump if we have no feet and update
    if(feet.size() == 0 && age > 1){
      if(isGrounded){
        soundInitiator.playSound(SoundEvent.Jump);
        isGrounded = false;
      }
      return true;
    } else {
      isGrounded = true;
      return false;
    }
  }

  // handling of path information
  int getNumPathPoints()
  {
    TuioCursor tc = pc.tuioProcessing.getTuioCursor(tuioId);
    if (tc != null)
    {
      return tc.getPath().size();
    }
    return -1;
  }
  float getPathPointX(int pointID)
  {
    TuioCursor tc = pc.tuioProcessing.getTuioCursor(tuioId);
    if (tc != null)
    {
      ArrayList pointList = tc.getPath();
      if (pointList == null || pointList.size() <=  pointID)
      {
        return 0;
      }
      TuioPoint tp = (TuioPoint)pointList.get(pointID);
      return tp.getScreenX(width);
    }
    return 0;
  }
  float getPathPointY(int pointID)
  {
    TuioCursor tc = pc.tuioProcessing.getTuioCursor(tuioId);
    if (tc != null)
    {
      ArrayList pointList = tc.getPath();
      if (pointList == null || pointList.size() <=  pointID)
      {
        return 0;
      }
      TuioPoint tp = (TuioPoint)pointList.get(pointID);
      return tc.getScreenY(height - pc.wallHeight) + pc.wallHeight;
    }
    return 0;
  }  

  @Override
  public boolean equals(Object obj) 
  {
    if(obj instanceof Player){
      Player other = (Player)obj;
      return (this.id == other.id);
    } else {
      return false;
    }
  }
  
  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + (int) (id ^ (id >>> 32));
    return result;
  }
}

// helper class for feet
public class Foot
{
  public Foot(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  float x;
  float y;
}