public class TestState1 extends State{
    //INIT
  //NodeStep
  int stepX = 20;
  int stepY = 20;
  //NodeShape
  int nSize = 3;
  //AttractorCount
  int aCount = 1;
  
  ArrayList<Node> nodes = new ArrayList<Node>(0);
  
  HashMap<Player, Attractor> attractorMap = new HashMap<Player, Attractor>();
  
  public TestState1(StateMachine stateMachine){
    super(stateMachine);
    placeNodes();
  }
  
  void enterTransition(State from, float time) {
    println("enter " + this.getClass().getName());
  }
  
  void update(){
    
    pg.background(0);
    attractNodes();
    
    //Draw
    displayNodes();
  }
  
  void exitTransition(State to, float time) {
    println("exit " + this.getClass().getName());
  }


//CUSTOM STUFF
  void displayNodes()
  { 
    //DEBUG/DUMMY - DRAW
    for(int i = 0; i < nodes.size(); i++)
    {
      pg.noStroke();
      pg.fill(255);
      pg.ellipse(nodes.get(i).x, nodes.get(i).y, nSize, nSize);
    }
  }
  
  void attractNodes(){
   
    for(HashMap.Entry<Player, Attractor> entry : attractorMap.entrySet())
    {
      Player p = entry.getKey();
      Attractor a = entry.getValue();
      
      a.x = p.x;
      a.y = p.y;
       //<>//
      for(int j = 0; j < nodes.size(); j++)
      {
        Node n = nodes.get(j);
        a.attract(n);
        n.update();
      } 
    }  
  } //<>//
  
  void placeNodes(){
    
    //Add Nodes depending on Grid
    for(int y = stepY/2; y < WindowHeight; y+=stepY){
      
      for(int x = stepX/2; x < WindowWidth; x+=stepX){
        {
          nodes.add(new Node(x,y));
        }
      }
    }
  }
  
  void playerAdded(Player player){
    attractorMap.put(player, new Attractor(player.x, player.y));
  }
  
  void playerRemoved(Player player){
    attractorMap.remove(player);
  }
}