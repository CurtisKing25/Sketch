PShape [] s = new PShape[100];
boolean drawing = false;
int shapeCount = 0;
int scale = 40;
boolean showText = true;
int x;
int y;
int speed=10;
boolean up = false;
boolean left = false;
boolean down = false;
boolean right = false;
color lineColor = color(255, 0, 0);  // Initialize the line color to red

void setup()
{
  frameRate(60);
  fullScreen();
  x=width/2;
  y=height/2;
  background(255);
  strokeWeight(10);
  textSize(width/scale);
  for(int i=0;i<s.length;i++)
  {
    s[i] = createShape();
  }
}

void draw()
{
  background(255);
  for(int i=0;i<s.length;i++) shape(s[i],0,0);
  if(showText)
  {
    noStroke();
    rect(0,0,width,height/16);
    stroke(0);
    line(0,height/16,width,height/16);
    fill(0);
    text("q = clear, z= undo, x= new line, t=toggle",0,width/scale);
    fill(255);
  }
  cursor();
  stroke(255,0,0);
  line(width-(width/scale),0,width,width/scale);
  line(width,0,width-(width/scale),width/scale);
  stroke(0);
  if(left)x=x-speed;
  if(right)x=x+speed;
  if(up)y=y-speed;
  if(down)y=y+speed;
  if(drawing)s[shapeCount].curveVertex(x,y);
}

void mouseDragged()
{
  x=mouseX;
  y=mouseY;
  drawing=true;
  s[shapeCount].beginShape();
  s[shapeCount].curveVertex(x,y);
}

void mousePressed()
{
  x=mouseX;
  y=mouseY;
  if(x>width-(width/scale)&& y<width/scale) exit();
}

void mouseReleased()
{
  drawing = false;
  shapeCount++;
}

void keyPressed()
{
  if(key == 'w')
  {
    up=true;
  }
  if(key == 'a')
  {
    left=true;
  }
  if(key == 's')
  {
    down=true;
  }
  if(key == 'd')
  {
    right=true;
  }
  if(keyCode==ENTER && !drawing)
  {
    if(x>width-(width/scale)&& y<width/scale) exit();
    drawing = true;
    s[shapeCount].beginShape();
    s[shapeCount].curveVertex(x,y);
  }
  else if(keyCode==ENTER && drawing)
  {
    drawing = false;
    shapeCount++;
  }
  //if(key=='9')speed=100;
  if(key == 'q')
  {
    background(255);
    shapeCount = 0;
    for(int i=0;i<s.length;i++)s[i] = createShape();
    for(int i=0;i<s.length;i++) shape(s[i],0,0);
    if(showText)
    {
      noStroke();
      rect(0,0,width,height/16);
      stroke(0);
      line(0,height/16,width,height/16);
      fill(0);
      text("q = clear, z= undo, x= new line, w=hide",0,width/scale);
      fill(255);
    }
    stroke(255,0,0);
    line(width-(width/scale),0,width,width/scale);
    line(width,0,width-(width/scale),width/scale);
    stroke(0);
    fill(0);
  }
  
  if(key == 'z')
  {
    background(255);
    if(shapeCount>0)shapeCount--;
    s[shapeCount] = createShape();
    for(int i=0;i<s.length;i++) shape(s[i],0,0);
    if(showText)
    {
      noStroke();
      rect(0,0,width,height/16);
      stroke(0);
      line(0,height/16,width,height/16);
      fill(0);
      text("q = clear, z= undo, x= new line, w=hide",0,width/scale);
      fill(255);
    }
    stroke(255,0,0);
    line(width-(width/scale),0,width,width/scale);
    line(width,0,width-(width/scale),width/scale);
    stroke(0);
  }
  if(key == 'x')
  {
    shapeCount++;
    s[shapeCount] = createShape();
    s[shapeCount].beginShape();
    s[shapeCount].curveVertex(mouseX,mouseY);
  }
  if(key == 't') showText = !showText;
}

void keyReleased()
{
  left=false;
  right=false;
  up=false;
  down=false;
}

void cursor()
{
  fill(0);
  stroke(0);
  ellipse(x,y,10,10);
  fill(255);
}

void info()
{
}

//add speed change of cursor
//give cursor acceleration/momentum of some kind?
//save array/object with x and y positions for undo (z key)
//make colour swapper (RGB wheel)
//make queue for laser pointer effect
//Add all verticies to an array
//ray trace from current vertex to original vertex
//if overlap occurs end shape and start new shape
