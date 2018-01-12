float dB = 0; //<>//
boolean play = true;
float circleDb = 0;

class AudioTrigger{
  
  void circleVolumeGain(){
    
    //load and play Audio File
    circleTrack = minim.loadFile("sounds/Ambience_01.aif");
    circleTrack.loop();
    //circleTrack.shiftVolume(0,1, 8000);
    circleTrack.shiftGain(-5,0, 8000);
        
    //Load Sound that is triggered at the end of the state
    snap = minim.loadSample( "sounds/Trigger.mp3", // filename
                            1024      // buffer size
                         );
                         
    //Load Sound that is triggered when the player is jumping
    jump = minim.loadSample( "sounds/Glockenspiel.wav", // filename
                            1024      // buffer size
                         );
  }
  
  //VolumeGain for Plexus State
  void plexusVolumeGain(){
    plexusTrack = minim.loadFile("sounds/Ambience_03.aif");
    plexusTrack.loop();
    plexusTrack.setGain(-60);
    //plexusTrack.shiftVolume(0,1, 8000);
   
  }  

//VolumeGain for RectangleState
  void rectangleVolumeGain(){
    rectangleTrack = minim.loadFile("sounds/Ambience_Flutter.aif");
    rectangleTrack.loop();
    rectangleTrack.shiftGain(-20,10, 15000);
    
    noise = minim.loadFile("sounds/noise.aif");
    noise.play();
    noise.shiftGain(-100,-5, 20000);
  }  
  
  void circleEndTrigger(){
                     
    //Triggers the sound once
    if(play == true){
      snap.shiftGain(-10,5, 500); 
      snap.trigger();
      circleTrack.shiftGain(0,-60, 20000); 
      play = false;
     }
  }
  
  void triangleSound(){
    generateTriangle = minim.loadFile("sounds/Click.wav");
    
    if(generateTriangle.isPlaying() == false){
      generateTriangle.play();     
    }
    
    //----------------------------//
    //Increase Atmo Volume
    dB += 0.1;
    plexusTrack.setGain(-10+dB);
    
  }
  
  void circleJumpSound(){
    jump.shiftGain(-10,5, 500); 
    jump.trigger();
  }
  
  void plexusEndTrigger(){
    plexusTrack.shiftGain(plexusTrack.getGain(),-30, 40000); 
  }  
  
  void rectangleEndTrigger(){
    plexusTrack.shiftGain(plexusTrack.getGain(),-60, 10000); 
    rectangleTrack.shiftGain(0,-60, 8000);
    noise.shiftGain(-5,-60, 8000);
  }  
  
  
}