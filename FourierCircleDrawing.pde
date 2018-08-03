float datas[][] = null;
float rp[][] = null;

void setup() {

  String[] lines = loadStrings("FourierMath/datas.txt");
  datas = new float[lines.length][2];
  rp = new float[lines.length][2];
  for (int i = 0; i < lines.length; i++) {
    String cache[] = split(lines[i], ",");
    if (cache.length<2) {
      break;
    }
    datas[i][0] = Float.parseFloat(cache[0].replace("[",""));
    datas[i][1] = Float.parseFloat(cache[1].replace("]",""));
    rp[i][0] = sqrt(datas[i][0]*datas[i][0]+datas[i][1]*datas[i][1]);
    rp[i][1] = atan2(datas[i][1],datas[i][0]);
  }
  size(1920, 1080);
  spot = createGraphics(width, height);
  coord = createGraphics(width, height);
  coord.beginDraw();
  coord.stroke(0,15,25,100);
  coord.line(0, coord.height/2f, coord.width, coord.height/2f);
  coord.line(coord.width/2f, 0, coord.width/2f, coord.height);
  coord.endDraw();
}
PVector size = new PVector(1, 1); // pixel/unit
PGraphics spot = null;
PGraphics coord = null;
PVector lastPos = new PVector();
float t = -0.3f;
int reversey = 1;

void draw() {
  background(255);
  t+=0.005f;
  image(coord, 0, 0);
  PVector center = new PVector();
  PVector pointer = new PVector();
  noFill();
  stroke(255);
  for (int i = 0; i<datas.length; i++) {
    int m = 0;
    if (i>0) m = ((i+1)/2)*((i%2 == 0)?-1:1);
    float r = rp[i][0];
    stroke(175);
    ellipse(center.x*size.x+width/2f, reversey*center.y*size.y+height/2f, r*size.x*2f, r*size.y*2f);
    float theta = reversey*t*m+rp[i][1];
    pointer.add(new PVector(r*cos(theta), r*sin(theta)));
    if (m == 0) pointer.set(datas[0][0], datas[0][1]);
    stroke(100);
    line(center.x*size.x+width/2f, reversey*center.y*size.y+height/2f, pointer.x*size.x+width/2f, reversey*pointer.y*size.y+height/2f);
    center.set(pointer);
  }
  stroke(10, 255, 10);
  fill(100, 124, 255, 150);
  ellipse(pointer.x*size.x+width/2f, reversey*pointer.y*size.y+height/2f, 8, 8);
  if(t>=0){
    spot.beginDraw();
    spot.noStroke();
    spot.stroke(0, 155, 255);
    spot.strokeWeight(3);
    spot.fill(0, 155, 255);
    spot.translate(spot.width/2f, spot.height/2f);
    spot.line(lastPos.x,lastPos.y,pointer.x,pointer.y);
    //spot.ellipse(pointer.x*size.x, reversey*pointer.y*size.y, 5, 5);
    spot.endDraw();
    image(spot, 0, 0);
  }
  lastPos.set(pointer);
  //noLoop();
}