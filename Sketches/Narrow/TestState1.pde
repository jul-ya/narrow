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
    ArrayList<Attractor> attractors = new ArrayList<Attractor>(0);
  
  
  public TestState1(StateMachine stateMachine){
    super(stateMachine);
    //Create NodeGrid
    placeNodes();
    
    //Create Attractor 
    //***********TODO****** - Create Attractor per TUIO Player)
    createAttractor();
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
   
    for(int i = 0; i < attractors.size(); i++)
    {
      Attractor a = attractors.get(i);
      a.x = mouseX;
      a.y = mouseY; //<>//
      
      for(int j = 0; j < nodes.size(); j++)
      {
        Node n = nodes.get(j);
        a.attract(n);
        n.update();
      } 
    }  
  }
  
  void createAttractor(){
   
    for(int i = 0; i < aCount; i++)
    {
      attractors.add(new Attractor(0,0));
    }
  
  }
  
  
  void placeNodes(){
    
    //Add Nodes depending on Grid
    for(int y = stepY/2; y < height; y+=stepY){
      
      for(int x = stepX/2; x < width; x+=stepX){
        {
          nodes.add(new Node(x,y));
        }
      }
    }
    
    
  }
}