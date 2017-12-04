class Connector{
 
  int id;
  int maxConnections;
  QPoint p;
  IntList connectionIDs;
  FloatList distances;
  int numConnections;
  float minDist = 9999999;
  int minDistID = -1;
  
  Connector(QPoint p, int id, int maxConnections)
  {
    this.p = p;
    this.id = id;
    this.maxConnections = maxConnections; 
    this.connectionIDs = new IntList(0);
    this.distances = new FloatList(0);
    this.numConnections = 0;
  }
  
  //Returns True if connection has been added
  boolean addConnection(int id, float dist){

    //If irst elements
    if(numConnections < maxConnections)
    {
      if(dist<minDist)
      {
        this.connectionIDs.append(id);
        this.distances.append(dist);
        this.increaseConnections();
        this.minDist = dist;
        this.minDistID = id;
      }
      return true;
    }
    else{       
        connectionIDs.remove(0);
        distances.remove(0);
        connectionIDs.append(id);
        distances.append(dist);
        return true;
    }
    
  }
  
  float getMinDist(){
     return this.minDist;
  }
  
  int getNumConnections()
  {
     return numConnections; 
  }
  
  void increaseConnections()
  {
    this.numConnections +=1; 
  }
  
  int getID()
  {
    return this.id;
  }

}