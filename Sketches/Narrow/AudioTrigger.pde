float dB = 0; //<>//
boolean play = true;

class AudioTrigger{
  
  void circleVolumeGain(){
    
    //load and play Audio File
    circleTrack = minim.loadFile("Antigravity.wav");
    circleTrack.loop();
    circleTrack.shiftVolume(0,1, 8000);
        
    //Load Sound that is triggered at the end of the state
    snap = minim.loadSample( "Trigger.mp3", // filename
                            1024      // buffer size
                         );
                         
    //Load Sound that is triggered when the player is jumping
    jump = minim.loadSample( "Glockenspiel.wav", // filename
                            1024      // buffer size
                         );
  }
  
  void plexusVolumeGain(){
    
    plexusTrack = minim.loadFile("Dreamscape.wav");
    plexusTrack.loop();
    plexusTrack.setGain(-60);
    //plexusTrack.shiftVolume(0,1, 8000);
   
  }  

  void rectangleVolumeGain(){
    rectangleTrack = minim.loadFile("Arrival.wav");
    rectangleTrack.loop();
    rectangleTrack.shiftVolume(0,1, 8000);
  }  
  
  void circleEndTrigger(){
                     
    //Triggers the sound once
    if(play == true){
      snap.shiftGain(-10,5, 500); 
      snap.trigger();
      circleTrack.shiftGain(0,-60, 10000); 
      play = false;
     }
  }
  
  void triangleSound(){
    generateTriangle = minim.loadFile("Glockenspiel.wav");
    
    if(generateTriangle.isPlaying() == false){
      generateTriangle.play();     
    }
    
    //----------------------------//
    //Increase Atmo Volume
    dB += 1;
    plexusTrack.setGain(-60+dB);
    
  }
  
  void circleJumpSound(){
    jump.shiftGain(-10,5, 500); 
    jump.trigger();
  }
  
  void plexusEndTrigger(){
    plexusTrack.shiftGain(0,-60, 10000); 
  }  
  
  void rectangleEndTrigger(){
    rectangleTrack.shiftGain(0,-60, 20000);
  }  
  
  
}