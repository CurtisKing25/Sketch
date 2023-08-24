PShape [] s = new PShape[100];
boolean drawing = false;
int shapeCount = 0;
int scale = 40;
boolean showText = true;

void setup()
{
  fullScreen();
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
    text("q = clear, z= undo, x= new line, w=hide",0,width/scale);
    fill(255);
  }
  stroke(255,0,0);
  line(width-(width/scale),0,width,width/scale);
  line(width,0,width-(width/scale),width/scale);
  stroke(0);
  if(drawing)s[shapeCount].curveVertex(mouseX,mouseY);
}


void mousePressed()
{
  if(mouseX>width-(width/scale)&& mouseY<width/scale) exit();
  drawing = true;
  s[shapeCount] = createShape();
  s[shapeCount].beginShape();
  s[shapeCount].curveVertex(mouseX,mouseY);
}

void mouseReleased()
{
  //S[shapeCount].noStroke();
  //S[shapeCount].curveVertex(secondX,secondY);
  drawing = false;
  shapeCount++;
}

void keyPressed()
{
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
  if(key == 'w') showText = !showText;
}

//Add all verticies to an array
//ray trace from current vertex to original vertex
//if overlap occurs end shape and start new shape
