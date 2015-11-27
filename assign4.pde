float treasureX,treasureY;
float fighterX,fighterY;


int numCrash=8;
boolean crash[]=new boolean [numCrash];

//enemy

int numEnemyX=6;
float enemyX[]=new float[numEnemyX];
int numEnemyY=6;
float enemyY[]=new float[numEnemyY];

int numDiamondEnemyX=9;
float enemyDiamondX[]=new float[numDiamondEnemyX];
int numDiamondEnemyY=9;
float enemyDiamondY[]=new float[numDiamondEnemyY];

// flame
float flameX;
float flameY;
//shoot

PImage shoot;
int numFire=5;

float shootX[]=new float [numFire];
float shootY[]=new float [numFire];
int shootCount=-1;
int fire=0;

float speed=6;
int bgx1, bgx2;
int gameState;
float blood=38.8;
final int GAME_START=1, GAME_RUN=2,GAME_OVER=3;

PImage bg1,bg2;
PImage img1,img2,img3,img4;
PImage start1,start2,end1,end2;

int currentFlame;
int numFlame=5;
PImage [] flame=new PImage [numFlame];

boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

int count=1;
int enemyMode;
final int line=1, slash=2, diamond=3; 
void setup () {
  size(640,480);
  //image loading
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  bg1=loadImage("img/bg1.png");
  bg1.resize(640,480);
  bg2=loadImage("img/bg2.png");
  bg2.resize(640,480);
  img3=loadImage("img/fighter.png");
  img4=loadImage("img/treasure.png");
  img1=loadImage("img/hp.png");
  img2=loadImage("img/enemy.png");
  shoot=loadImage("img/shoot.png");
  //treasure locate
  treasureX=floor(random(0,599));
  treasureY=floor(random(0,439));
  image(img4,treasureX,treasureY);
  //fighter initial location
  fighterX=589;
  fighterY=235;
  gameState=GAME_START;
  enemyMode=line;
  
  //enemy initail location
  enemyY[0]=random(0,419);
  enemyX[0]=-80;
  //flame
  currentFlame=0;
  for(int j=0; j<numFlame; j++){
   flame[j]=loadImage("img/flame"+(j+1)+".png");
  }
 
  frameRate(60);
  
 
  
}

void draw() {
  switch(gameState){
    
   case GAME_START:
    image(start2,0,0);
    if (mouseX<441 && mouseX>208 && mouseY>379 && mouseY<411){
     image(start1,0,0);
     if (mousePressed){
      switch(gameState){
      case GAME_START:
      gameState=GAME_RUN;
      break;
      }
     }
    }
    break;
    
   case GAME_RUN: 
    //scrolling background
    bgx1=bgx1%1280;
    bgx1++;
    image(bg1,bgx1,0);
    image(bg2,bgx1-640,0);
    image(bg1,bgx1-1280,0);
    //fighter 
    if(fighterX<0){
    fighterX=0;
    }
    if(fighterX>589){
    fighterX=589;
    }
    if(fighterY<0){
    fighterY=0;
    }
    if(fighterY>429){
    fighterY=429;
    }
    image(img3,fighterX,fighterY);
    
    //treasure
    image(img4,treasureX,treasureY);
    //hp bar
    fill(255,0,0);
    rect(13,3,blood,20);
    //hp
    image(img1,0,0);
   
    //fighter get treasure
    if (sq(treasureX+20.5-fighterX-25.5)+sq(treasureY+20.5-fighterY-25.5)<sq(20.5+25.5)){
    treasureX=floor(random(0,599));
    treasureY=floor(random(0,439));
    blood+=19.4;
    }
    
    //blood upper bound 
    if (blood>=194.0){
    blood=194.0;
    }
  
   //fire

    
    if(shootCount>=-1){
      for(int i=0; i<numFire; i++){
    shootX[i]-=speed;
    image(shoot,shootX[i],shootY[i]);
   

    }
    if(shootX[0]+31<0.0){
    shootCount--;
    
    }
    }
    
    if(shootCount<-1){
    shootCount=-1;
    }
    
    if(shootCount>4){
    shootCount=4;
    }
    
    
  
   
    switch(enemyMode){
       
    case line:
    
    enemyX[0]+=speed;
    
    
    for(int i=1; i<numEnemyX; i++){  
      
    enemyX[i]=enemyX[0]-80*i;
    enemyY[i]=enemyY[0];
    if(crash[i-1]==false){
    if(fighterX<enemyX[i]+61&&fighterX+51>enemyX[i]&&fighterY+51>enemyY[i]&&fighterY<enemyY[i]+61){
    
    blood-=38.8;
    flameX=enemyX[i];
    flameY=enemyY[i];
    
   if(frameCount%6==0){
    currentFlame++;
   }
   if(currentFlame<5){
   image(flame[currentFlame],flameX,flameY);
   }
   if(currentFlame>5){
   currentFlame =0;
   }
   crash[i-1]=true;
    }
    
    
    
   
 
    }
   
    
    if(crash[i-1]==false){
    image(img2,enemyX[i],enemyY[i]);
      }
    
    
 //explode
 
 
    }//for end
    
    
    
    
    
    
    if(enemyX[0]-80*5>=width){
    enemyX[0]=-80;
    enemyY[0]=random(0,175);
    
    switch(enemyMode){
    case line:
    enemyMode=slash;
    crash[0]=false;
    crash[1]=false;
    crash[2]=false;
    crash[3]=false;
    crash[4]=false;
    crash[5]=false;
    crash[6]=false;
    crash[7]=false;
    break;
    }
  
    
    }
    break;
    
    case slash:
    enemyX[0]+=speed;
    for(int i=1; i<numEnemyX; i++){   
    
    enemyX[i]+=speed;
    enemyX[i]=enemyX[0]-80*i;
    
    enemyY[i]=enemyY[0]+61*(i-1);
    
    
    if(crash[i-1]==false){
    if(fighterX<enemyX[i]+61&&fighterX+51>enemyX[i]&&fighterY+51>enemyY[i]&&fighterY<enemyY[i]+61){
    
    
    blood-=38.8;
    
    flameX=enemyX[i];
    flameY=enemyY[i];
    enemyX[i]=1000;
    enemyY[i]=1000;
    if(frameCount%6==0){
    currentFlame++;
   }
   if(currentFlame<5){
   image(flame[currentFlame],flameX,flameY);
   }
   if(currentFlame>5){
   currentFlame =0;
   }
   crash[i-1]=true;
    }
   }//explode
   if(crash[i-1]==false){
   image(img2,enemyX[i],enemyY[i]); 
   }  
  }
    
    if(enemyX[0]-80*6>=width){
    enemyDiamondX[0]=-80;
    enemyY[0]=random(121,298);
    
    switch(enemyMode){
    case slash:
    enemyMode=diamond;
    crash[0]=false;
    crash[1]=false;
    crash[2]=false;
    crash[3]=false;
    crash[4]=false;
    crash[5]=false;
    crash[6]=false;
    crash[7]=false;
    break;
    }
    
    
    }
    
    
    break;
    
   case diamond:
   enemyDiamondX[0]+=speed;
    for(int i=1; i<numDiamondEnemyX; i++){
  
    
    
    if(i==1||i==8){
    enemyDiamondX[1]=enemyDiamondX[0];
    enemyDiamondX[8]=enemyDiamondX[0]-61*4;
    enemyDiamondY[i]=enemyY[0];
   
    }else if(i==2||i==6){
    enemyDiamondX[2]=enemyDiamondX[0]-61;
    enemyDiamondX[6]=enemyDiamondX[0]-61*3;
    enemyDiamondY[i]=enemyY[0]-61;
  
    }else if(i==3||i==7){
    enemyDiamondX[3]=enemyDiamondX[0]-61;
    enemyDiamondX[7]=enemyDiamondX[0]-61*3;
    enemyDiamondY[i]=enemyY[0]+61;
   
    }else if(i==4){
    enemyDiamondX[4]=enemyDiamondX[0]-61*2;
    enemyDiamondY[i]=enemyY[0]-122;

    }else{
    enemyDiamondX[i]=enemyDiamondX[0]-61*2;
    enemyDiamondY[i]=enemyY[0]+122;
    
    }
    
    if(crash[i-1]==false){
    if(fighterX<enemyDiamondX[i]+61&&fighterX+51>enemyDiamondX[i]&&fighterY+51>enemyDiamondY[i]&&fighterY<enemyDiamondY[i]+61){
    
    
    blood-=38.8;
    
    flameX=enemyDiamondX[i];
    flameY=enemyDiamondY[i];
    
   if(frameCount%6==0){
    currentFlame++;
   }
   if(currentFlame<5){
   image(flame[currentFlame],flameX,flameY);
   
   }
   if(currentFlame>5){
   currentFlame =0;
   }
   crash[i-1]=true;
    }
    }
    if(crash[i-1]==false){
    image(img2,enemyDiamondX[i],enemyDiamondY[i]);
    }
    }
    

     
       
    
      
      
   if(enemyDiamondX[0]-80*4>=width){
    enemyX[0]=-80;
    enemyY[0]=random(0,419);
    
    switch(enemyMode){
    case diamond:
    enemyMode=line;
    crash[0]=false;
    crash[1]=false;
    crash[2]=false;
    crash[3]=false;
    crash[4]=false;
    crash[5]=false;
    crash[6]=false;
    crash[7]=false;
    break;
    }
    
    
    }
    break;
    }// switch enemyMode end
    
   
    
   
  
    
    
    
    
    break; 
    
    case GAME_OVER:
    image(end2,0,0);
    if (mouseX<431 && mouseX>208 && mouseY>312 && mouseY<345){
     image(end1,0,0);
     if (mousePressed){
     switch(gameState){
     case GAME_OVER:
     gameState=GAME_RUN;
     enemyMode=line;
     //crash initial
    crash[0]=false;
    crash[1]=false;
    crash[2]=false;
    crash[3]=false;
    crash[4]=false;
    crash[5]=false;
    crash[6]=false;
    crash[7]=false;
    
    shootCount=0;
     treasureX=floor(random(0,599));
     treasureY=floor(random(0,439));
     fighterX=588;
     fighterY=245;
     blood=38.8;
     enemyX[0]=-80;
     enemyY[0]=random(0,419);
     break;
     }
     }
    }
    break;   
  }//switch gameState end

   //game over
   if(blood<=0.0){
   switch(gameState){
   case GAME_RUN:
   gameState=GAME_OVER;
   break;
   }
   }
   
   
   //fighter control
   if(upPressed){
   fighterY-=speed;
   }
   if(downPressed){
   fighterY+=speed;
   }
   if(leftPressed){
   fighterX-=speed;
   }
   if(rightPressed){
   fighterX+=speed;
   }
   
   
   
   
     
     
    
     
   
   
  }//draw end
 
    



void keyPressed(){
  if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=true;
    break;
  case DOWN:
    downPressed=true;
    break;
  case LEFT:
    leftPressed=true;
    break;
  case RIGHT:
    rightPressed=true;
    break;
  }
  }
  
  if(keyCode==' '&&shootCount<4){
  
  shootCount++;
  if(shootCount>=0){
  shootX[shootCount]=fighterX;
  shootY[shootCount]=fighterY+12;
  }
  }
 
 
  


}
void keyReleased(){
if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=false;
    break;
  case DOWN:
    downPressed=false;
    break;
  case LEFT:
    leftPressed=false;
    break;
  case RIGHT:
    rightPressed=false;
    break;
  }
  }
  
 
  
}
