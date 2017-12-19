//Nearest Neighbour State
//meins - Elmar
public class TestState2 extends State{
  
  //****************CONFIG********************
  float sd_y = 50;  //Standard Deviation X
  float sd_x = 50; //Standard Deviation Y
  
  int numPoints = 30;
  float maxConnections = 5;
  float maxDist = 150;
  
  //NEW VARS
  int maxConnectWidth = 500;
  int pSize = 3;
  int alpha = 150;
  int maxEnemies = 1;
  float enemyWidth = 100;
  
  //****************END CONFIG******************
  boolean running = false;
  //PlayerPoints
  Player p; 
  //Attractor pa;
  Attractor pa;
  ArrayList<Node> playerNodes = new ArrayList<Node>(0);
  
  //Enemy Points
  ArrayList<Node> enemies = new ArrayList<Node>(0);
  
  //Triangles to draw
  ArrayList<Triangle> triangles = new ArrayList<Triangle>(0);
  
  //PlayerMap is global now (StateMachine)
  

  public TestState2(StateMachine stateMachine){
    super(stateMachine);
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
    init();
  }
  
  void update(){
    smooth();
    noFill();
    stroke(255);
    //If Game has started
    if(running)
    { 
      //Just to See if Game is running
      background(100);
      
      updatePlayer();
      updatePoints();
      connect();
      displayConnections();
      
      //Enemy Stuff
      spawnEnemies();
      updateEnemies();
      drawEnemies();
      drawTriangles();
    }
  
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }
  
  void playerAdded(Player player){
    attractorMap.put(player, new Attractor(player.x, player.y));
    if(attractorMap.size() == 1){
      init();
    }
  }
  
  void playerRemoved(Player player){
    attractorMap.remove(player);
  }
  
  
  
  //**************INIT*************//
  
  //Initialisation
  //TODO -> Transfer TUIO-Data
  void init()
  {
    //Create Player Attractor
      
    for(HashMap.Entry<Player, Attractor> entry : attractorMap.entrySet())
    {
      p = entry.getKey();
      pa = entry.getValue();
      break;
    }

    //Clear and Create Points around Player
    playerNodes.clear();
    createRandomStartNodes();
    running = true;
  }
  
  //Creating Gaussian Random Start Points
  //TODO Transfer TUIO DATA
  void createRandomStartNodes(){
    //Helpers
    float num = 0f;
    float mean_x = p.x;  //TODO TUIO
    float mean_y = p.y;  //TODO TUIO
    float start_x, start_y;
    
    //Create
    playerNodes.add(new Node(p.x, p.y)); //TODO TUIO
    Random generator = new Random();
    for (int i = 0; i < numPoints; i++) {
        //Gen X-Coord
        num = (float) generator.nextGaussian();
        start_x = sd_x * num + mean_x;
        //Gen Y-Coord
        num = (float) generator.nextGaussian();
        start_y = sd_y * num + mean_y;
        //Fill Array
        playerNodes.add(new Node(start_x, start_y));
    }
  }
  
  //ENEMY STUFF
  void spawnEnemies(){
  while(enemies.size() < maxEnemies)
  {
    Node e = new Node(0,0);
    e.setVelocity(new PVector(2,2)); 
    e.setDamping(0);
    enemies.add(e);
  }
}


  void updateEnemies(){
    
    for(int i = 0; i < enemies.size(); i++)
    {
      Node e = enemies.get(i);
      e.update();
      
      int connections = 0;
      int index1 = 0, index2= 0;
      float currMinDist = 999999;
      for (int j = 0; j < playerNodes.size(); j++) {
        Node c = playerNodes.get(j);
        float dist = dist(c.x, c.y, e.x,e.y);
        if(dist < currMinDist){
          if( dist < enemyWidth)
          {
            index2 = index1;
            index1 = j;
            currMinDist = dist; 
            connections += 1;
          }
        }
      }
      
      //Add Triangle -  remove Point
      if(connections > 1)
      {
        triangles.add(new Triangle(new PVector(e.x, e.y), new PVector(playerNodes.get(index1).x, playerNodes.get(index1).y), new PVector(playerNodes.get(index2).x, playerNodes.get(index2).y)));
        enemies.remove(i);
      }
    }
  }
  
  void drawEnemies()
  {
      stroke(255,0,0);
      fill(255,0,0);
      for(int i = 0; i < enemies.size(); i++)
      {
        Node e = enemies.get(i);
        ellipse(e.x, e.y, pSize, pSize);
      }
      
  }
  
  void drawTriangles(){
    
      for( int i = 0; i < triangles.size(); i++)
      {
        Triangle t = triangles.get(i);
        t.paint();
      }
      
  }
  
  //**************DRAW*************//
  
  //Update Player Position 
  //TODO -> Transfer TUIO Player Data to here
  void updatePlayer(){
    pa.x = p.x; 
    pa.y = p.y;
  }
  
  
  //Update Points to Player Pos
  void updatePoints()
  {
    //Update Player Vis
     Node playerPoint = playerNodes.get(0);
     playerPoint.x = p.x;
     playerPoint.y = p.y;
     
     //Update All other Points
     for(int i = 1; i <  playerNodes.size(); i++)
     {
       Node n = playerNodes.get(i);
       pa.attract(n);  
     
       //Push myself away from other nodes
       for(int j=1; j < playerNodes.size(); j++){
         if(i!=j){
          n.deflect(playerNodes.get(j));
         }
       }
       //Write Vel to Node
       n.update();
     }
  }
  
  
  //Connect
  void connect(){
    for (int i = 0; i < playerNodes.size(); i++) {
      Node c = playerNodes.get(i);
      float currMinDist = 999999;
      int index = 0;
      // TODO Insert Loop for Max Connections
      if(c.getNeighbours().size() < maxConnections){
        for(int j= 0; j < playerNodes.size(); j++){
            if(i!=j){//Dont check the same Point   
              Node o = playerNodes.get(j); //Get the other Point
              if(!c.isNeighbour(o)){  //Check if current Point isnt already a Neighbour of the Current outer Point
                 float dist = dist(c.x, c.y, o.x,o.y);
                 if(dist < maxConnectWidth){ //Check max Connect Width
                   if(dist < currMinDist){  //Check current Iteration Width
                     index = j;
                     currMinDist = dist;
                   } 
                 }
               } 
            }       
        }
        c.addNeighbour(playerNodes.get(index));
      }
    }  
  }
  
  void displayConnections(){
      //Get all Points
      for(int i = 0; i < playerNodes.size(); i++){
        Node c = playerNodes.get(i); //Get First
        ArrayList<Node> cn = c.getNeighbours();//Iterate over all Neighbours of the current Point
        for(int j = 0; j < cn.size(); j++){
          Node np = cn.get(j);
          if(np.isVisited(c) == false){
              //Draw 
              display(c, np);
              //Add both to Visited
              np.addToVisited(c);
              c.addToVisited(np);
          }  
        }
      }  
      for(int i = 0; i < playerNodes.size(); i++){
       
        Node c = playerNodes.get(i); //Get First
        c.visited.clear();
      }
  }
  
  
  void display(Node c, Node o)
  {
     stroke(255);
     fill(255);
     ellipse(c.x, c.y, pSize, pSize);
     noFill();
     float dist = dist(c.x, c.y, o.x,o.y);
     stroke(255,255,255,alpha-dist);
     line(c.x, c.y, o.x, o.y);
  }
  
}