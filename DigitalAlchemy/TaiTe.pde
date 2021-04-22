import peasy.PeasyCam;
//import drop.*;


//////////////////////////////////////////////////
//                VARIABLES
//////////////////////////////////////////////////
PImage testikuva2;

PeasyCam cam;
int offsetX=0;
int offsetY = 0;
float peasycam_dist = 2000.0;
int peasycam_speed = 50;
boolean record = false;
boolean record_sequence = false;
boolean show_help = false;
boolean isProcessing = false;
boolean cameraActive = true;

String magic_words_list[] = {
  "hylkeet", 
  " ", 
  "red to blue", 
  "blur", "blurs", "blurred", 
  "reds", 
  "sorting", 
  "mirror", 
  "stretch", 
  "transparency", 
  "magic", 
  " ", 
  "rectangle", 
  "noisy", 
  " ", 
  "save", 
  "record", 
  "stop", 
  "loadImage", 
  "image", 
  " ", 
  "float", 
  "freeze", 
  "reset", 
  "help", 

  "helpless"
};

PGraphics drawing;

String magic_words = "";

//////////////////////////////////////////////////
//                WINDOW SETTINGS
//////////////////////////////////////////////////

public void settings() {
  // size(1920, 1080, P3D);
  fullScreen(P3D);
}

//////////////////////////////////////////////////
//                KEYCODES
//////////////////////////////////////////////////

void keyTyped() {
  if ((key >= 'A' && key <= 'ö') || key == ' ' || key == '(' || key == ')') {
    magic_words = magic_words + key;
  }
}

void keyPressed()
{
  //  println(parseInt(key));
  if (parseInt(key) == 10) {
    cam.setActive(false);
    String[] list_of_magic_words = split(magic_words, ' ');
    runFunction(list_of_magic_words);
    isProcessing=false;

    magic_words="";
    println("Done processing");
    if (cameraActive)
    {
      cam.setActive(true);
    }
  }
  // zoomaus yksityiskohtaan

  // kuvan tallennus


  // ruudun tallennus


  // numeronäppäinten järjestys toteuttaa funktiot

  if (key == CODED) {

    switch(keyCode) {
    case UP:
      offsetY+=peasycam_speed;
      cam.lookAt(offsetX, offsetY, 0);
      break;
    case DOWN:
      offsetY-=peasycam_speed;
      cam.lookAt(offsetX, offsetY, 0);
      break;
    case LEFT:
      offsetX+=peasycam_speed;
      cam.lookAt(offsetX, offsetY, 0);
      break;
    case RIGHT:
      offsetX-=peasycam_speed;
      cam.lookAt(offsetX, offsetY, 0);
      break;
    case RETURN:
      //runFunction(input);
      break;
    }
  } else
  {
    switch(key) {
    case 'd':
      cam.setActive(false);
      break;
    }
  }
}

void runFunction(String letters[])
{
  int i = 0;
  while (i<letters.length)
  {
    println("Processing word: "+(i+1)+"/"+letters.length);
    isProcessing=true;
    switch(letters[i]) {
    case "hylkeet":
      testikuva = loadImage("testi.jpg");
      break;
    case "reds":
      redPixelsToBlue(testikuva);
      break;
    case "blur":
      blur(testikuva);
      break;
    case "blurs":
      blur(testikuva);
      break;
    case "blurred":
      blur(testikuva);
      break;
    case "white to red":
      whitePixelsToRed(testikuva, 250);
      break;
    case "sorting":
      pixelSorting(testikuva, int(random(10, 50)));
      break;
    case "mirror":
      mirror(testikuva);
      break;
    case "difference":
      //difference(testikuva, testikuva2);
      break;
    case "stretch":
      stretch(testikuva, int(random(testikuva.width)));
      break;
    case "transparency":
      transparent(testikuva);
      break;
    case "magic":
      convertImageToText(testikuva);
      break;
    case "distortion":
      PImage temp_img = loadImage("testi2.jpg");
      distortion(temp_img);
      break;
    case "rectangle":
      drawRect();
      break;
    case "noisy":
      noiseRect(200, 320, 130, 90);
      break;
    case "line":
      noiseLine(int(random(testikuva.height)));
      break;
    case "save":
      record=true;
      break;
    case "record":
      record_sequence = !record_sequence;
      break;
    case "stop":
      record_sequence = false;
      record = false;
      break;
    case "loadImage":
      testikuva = loadImage("testi.jpg");
      testikuva2 = loadImage("testi2.jpg");
      break;
    case "image":
      selectInput("Select a file to process:", "fileSelected");
      break;
    case "float":
      cam.lookAt(0, 0, 0);
      cam.reset(500);  // reset camera to its starting settings
      cam.setActive(true);  // false to make this camera stop responding to mouse
      cameraActive=true;
      break;
    case "freeze":
      cam.lookAt(0, 0, 0);
      cam.reset(500);  // reset camera to its starting settings
      cam.setActive(false);  // false to make this camera stop responding to mouse
      cameraActive=false;
      break;
    case "reset":
      cam.lookAt(0, 0, 0);
      cam.reset(500);  // reset camera to its starting settings
      break;
    case "SBS":
      show_help = true;
      break;
    case "charms":
      show_help = true;
      break;
    case "help":
      show_help = true;
      break;
    case "helpless":
      show_help = false;
      break;
    default:
      break;
    }
    i++;
  }
}
//////////////////////////////////////////////////
//                FUNCTIONS: PIXEL MANIPULATIONS
//////////////////////////////////////////////////


void whitePixelsToRed(PImage img, int threshold)
{
  threshold = constrain(threshold, 0, 255);
  int numPixels=img.width*img.height;
  for (int i = 0; i < numPixels; i++) {
    int r = (img.pixels[i] >> 16) & 0xFF ;
    if (r > threshold)
    {
      img.pixels[i] = color(128, 0, 0);
    }
  }
  img.updatePixels();
}

void redPixelsToBlue(PImage img)
{
  for (int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      int loc = i + img.width*j;
      int r = (img.pixels[loc] >> 16) & 0xFF ;
      if (r ==128)
      {
        img.pixels[loc] = color(0, 0, 100);
      }
    }
  }
  img.updatePixels();
}

void pixelSorting(PImage img, int lenght)
{
  if (lenght>img.height-1 || lenght<=0)
  {
    lenght=1;
  }
  for (int i=0; i<img.width; i++) {
    for (int j=img.height-1; j>0; j--) {
      int loc = i + img.width*j;
      int r = (img.pixels[loc] >> 16) & 0xFF ;
      if (r < int(random(128)) && j<img.height-lenght)
      {
        for (int k=0; k<lenght; k++) {
          int loc2 = i + img.width*(j+k);
          img.pixels[loc2] = img.pixels[loc];
          if (k+lenght>=img.height-10)
          {
            img.pixels[loc2] = img.pixels[i];
          }
        }
      }
    }
  }
  img.updatePixels();
}
void difference(PImage img1, PImage img2)
{
  img2.resize(img1.width, img1.height);
  int numPixels=img1.width*img1.height;
  for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
    color currColor = img1.pixels[i];
    color prevColor = img2.pixels[i];
    // Extract the red, green, and blue components from current pixel
    int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
    int currG = (currColor >> 8) & 0xFF;
    int currB = currColor & 0xFF;
    // Extract red, green, and blue components from previous pixel
    int prevR = (prevColor >> 16) & 0xFF;
    int prevG = (prevColor >> 8) & 0xFF;
    int prevB = prevColor & 0xFF;
    // Compute the difference of the red, green, and blue values
    int diffR = abs(currR - prevR);
    int diffG = abs(currG - prevG);
    int diffB = abs(currB - prevB);
    // The following line is much faster, but more confusing to read
    img1.pixels[i] = 0xff000000 | (diffR << 16) | (diffG << 8) | diffB;
  }
  img1.updatePixels();
}

void mirror(PImage img)
{
  for (int i=0; i<img.width/2; i++) {
    for (int j=0; j<img.height; j++) {
      int loc = i + img.width*j;
      int loc2 = (img.width - i - 1) + j*img.width;
      img.pixels[loc] = img.pixels[loc2];
    }
  }
  img.updatePixels();
}

void stretch(PImage img, int limit)
{
  limit = constrain(limit, 1, img.width);
  for (int i=0; i<limit; i++) {
    for (int j=0; j<img.height; j++) {
      int loc = i + img.width*j;
      for (int x=limit; x<img.width; x++) {
        int loc2 = x + img.width*j;
        img.pixels[loc2] = img.pixels[loc];
      }
    }
  }
  img.updatePixels();
}

void transparent(PImage img)
{
  for (int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      int loc = i + img.width*j;
      int a = int(random(0, 255));
      img.pixels[loc] = (100 >> 24) & 0xFF;
    }
  }
  img.updatePixels();
}

void convertImageToText(PImage img)
{
  String text = " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLunT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";

  img.loadPixels();
  drawing.beginDraw();

  for (int y = 0; y < img.height; y+=7) {
    for (int x = 0; x < img.width; x+=7) {
      color c = img.get(x, y);
      int b = int(brightness(c));
      int bright = int(map(b, 0, 255, 0, 60));         
      char letter= text.charAt(bright);
      drawing.fill(c);
      drawing.text(str(letter), x, y );
    }
  }
  drawing.endDraw();
}

void distortion(PImage img)
{
  drawing.beginDraw();
  drawing.beginShape();
  drawing.texture(img);
  drawing.noStroke();
  int mX = int(random(width));
  int mY = int(random(height));

  drawing.vertex(mX, mY, mX, mY);
  drawing.vertex(random(80)+80+mX, 5+mY, mX+100, mY);
  drawing.vertex(random(90)+95+mX, random(20)+90+mY, mX+100, mY+100);
  drawing.vertex(random(10)+40+mX, random(20)+95+mY, mX, mY+100);

  drawing.endShape();
  drawing.endDraw();
}


void blur(PImage img)
{
  img.filter(BLUR, 2);
}

//////////////////////////////////////////////////
//                FUNCTIONS: DRAWING
//////////////////////////////////////////////////

void doodling()
{
  if (mousePressed)
  {
    drawing.beginDraw();
    drawing.stroke(255, 0, 0);
    drawing.ellipse(mouseX, mouseY, 10, 10);
    drawing.endDraw();
  }
}

void doodling(PImage img)
{
  if (drawing.width!=img.width ||drawing.height!=img.height)
  {
    //drawing.resize(img.width, img.height);
  }
  if (mousePressed)
  {
    drawing.beginDraw();
    drawing.stroke(255, 0, 0);
    drawing.ellipse(mouseX, mouseY, 10, 10);
    drawing.endDraw();
  }
}

void drawRect()
{
  drawing.beginDraw();
  drawing.noStroke();
  drawing.fill(random(255), random(255), random(255));
  drawing.rect(random(width), random(height), 50, 50);
  drawing.endDraw();
}

void noiseRect(int _x, int _y, int _w, int _h)
{
  drawing.beginDraw();
  for (int y = _y; y<_y+_h; y=y+1)
  {
    for (int x = _x; x<_x+_w; x=x+1) // THIS LOOPS ONE LINE
    {
      drawing.set(x, y, color(random(255), random(255), random(255)));
    }
  }
  drawing.endDraw();
}

void noiseLine(int y)
{
  drawing.beginDraw();
  for (int x = 0; x<drawing.width; x=x+1) // THIS LOOPS ONE LINE
  {
    drawing.set(x, y, color(random(255), random(255), random(255)));
  }
  drawing.endDraw();
}

//////////////////////////////////////////////////
//                FUNCTIONS: DRAW
//////////////////////////////////////////////////

void drawFlippedImage( PImage img ) {
  PImage reverse = new PImage( img.width, img.height );
  //arrayCopy(img.pixels, reverse.pixels);
  for ( int i=0; i < img.width; i++ ) {
    for (int j=0; j < img.height; j++) {
      // reverse.set( img.width - 1 - i, j, img.get(i, j) );
      reverse.pixels[j*img.width+i] = img.pixels[(img.width - i - 1) + j*img.width]; // Reversing x to mirror the image
    }
  }
  drawImage(reverse);
}

void drawImageInScale( PImage img ) {
  float ratio;
  float w, h;
  if (img.width>img.height)
  {
    ratio = float(img.height)/float(img.width);
    w=width;
    h=width*ratio;

    if (h>height)
    {
      float h_ratio = height/h;
      w*=h_ratio;
      h*=h_ratio;
    }
  } else
  {
    ratio = float(img.width)/float(img.height);
    w=height*ratio;
    h=height;

    if (w>width)
    {
      float w_ratio = width/w;
      w*=w_ratio;
      h*=w_ratio;
    }
  }
  image(img, 0, 0, w, h);
}
void drawImage( PImage img ) {
  if (img!=null)
  {
    translate(-img.width/2, -img.height/2, 0);
    image(img, 0, 0);
    translate(0, 0, 1);
    image(drawing, 0, 0);
    translate(img.width/2, img.height/2, 0);
  }
}

void drawImageGrid(PImage img, int grid)
{
  translate(-img.width/2+offsetX, -img.height/2+offsetY, 0);

  for ( int i=0; i < grid; i++ ) {
    for (int j=0; j < grid; j++) {
      image(img, i*img.width/grid-i, j*img.height/grid-j, img.width/grid, img.height/grid);
    }
  }
  //        translate(img.width/2+offsetX, img.height/2+offsetY, 0);
}

//////////////////////////////////////////////////
//                FUNCTIONS: GENERAL
//////////////////////////////////////////////////

void startAlchemy()
{
  cam = new PeasyCam(this, peasycam_dist);
  cam.setSuppressRollRotationMode();  // Permit pitch/yaw only.
  cam.setWheelScale(0.5); // 1.0 by default

  moving_set_speed(50);


  drawing = createGraphics(width, height, P3D);
  drawing.beginDraw();
  drawing.clear();
  drawing.endDraw();

  while (testikuva==null) {
    delay(100);
    println("loading image..");
  }
  delay(100);

  testikuva2=testikuva;

  /*
  String[] args = {"TwoFrameTest"};
   SecondApplet sa = new SecondApplet();
   PApplet.runSketch(args, sa);
   */
}


void saveImageAsTIF(PImage img)
{
  img.save("output/image"+year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()+"-"+millis()+".tif");
}

void saveImageAsPNG(PImage img)
{
  img.save("output/image"+year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()+"-"+millis()+".png");
}

void moveImageWithKeyboard()
{
  float d = (float)cam.getDistance();
  scale(peasycam_dist*2/d);
}

void moveImageWithKeyboard(int speed)
{
  moving_set_speed(speed);
  float d = (float)cam.getDistance();
  scale(peasycam_dist*2/d);
}
void moving_set_speed(int s)
{
  peasycam_speed=s;
}

void recording()
{
  if (record) {
    saveImageAsPNG(testikuva);
    record = false;
  }
  if (record_sequence) {
    saveImageAsPNG(testikuva);
  }
}

void drawMagicWords()
{

  cam.beginHUD();
  // now draw things that you want relative to the camera's position and orientation
  if (show_help)
  {
    //background(0);
    int text_size = 20;
    textSize(text_size);
    int x = text_size*2;
    int y = text_size*2;
    for (int i = 0; i<magic_words_list.length; i++)
    {
      textAlign(LEFT);
      text(magic_words_list[i], x, y);
      y+=text_size*2;
      if (y>height)
      {
        x+=text_size*8;
        y= text_size*2;
      }
    }
  } else
  {
    textSize(22);
    textAlign(LEFT);
    fill(0, 50);
    text("Type 'charms' and hit ENTER for magic. Press ESC to quit.", 50, 51);
    text("Type 'charms' and hit ENTER for magic. Press ESC to quit.", 49, 49);
    text("Type 'charms' and hit ENTER for magic. Press ESC to quit.", 51, 50);
    fill(255);
    text("Type 'charms' and hit ENTER for magic. Press ESC to quit.", 50, 50);
  }

  textSize(30);
  textAlign(CENTER);
  // text(magic_words, width/2-textWidth(magic_words)/2, height-200, width, height);
  text(magic_words, 0, height/2, width, height);

  cam.endHUD(); // always
}

void drawText(String t, float x, float y, int s)
{
  textSize(s);
  fill(0);
  text(t, x-1, y);
  text(t, x+1, y);
  text(t, x, y+1);
  text(t, x, y-1);
  fill(255);
  text(t, x, y);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    testikuva = loadImage(selection.getAbsolutePath());
  }
}

//////////////////////////////////////////////////
//                FUNCTIONS: PEASYCAM
//////////////////////////////////////////////////


void reset_camera()
{
}

//////////////////////////////////////////////////
//                FUNCTIONS: DROP
//////////////////////////////////////////////////

/*
public class SecondApplet extends PApplet {
  SDrop drop;

  public void settings() {
    size(400, 400);
    drop = new SDrop(this);
    println("2nd window open");
  }
  public void draw() {
    background(255);
    fill(0);
    ellipse(100, 50, 10, 10);
  }
  public void dropEvent(DropEvent theDropEvent) {

    if (theDropEvent.isImage())
    {
      println("toString()\t"+theDropEvent.toString());
    }
  }
}
*/
