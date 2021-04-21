import processing.sound.*;
import drop.*;
SDrop drop;
SoundFile soundfile;


boolean lores = false;
boolean started = false;
int rect_size = 10;
int x = 0;
int y = 0;
byte b[];
int index = 0;

void setup()
{
  size(1600, 1200);
  noStroke();
  frameRate(30);
  background(0);
  textSize(36);
     text("WARNING! The program might create bright, rapidly flashing lights. If this might have a negative impact on your health, please don't watch or close the program by pressing ESC key! \n\nDrop any file to start!", 150,150, width-300, height-300); 

/*
  String filename = "drums.wav";
  soundfile = new SoundFile(this, filename);
  soundfile.loop();
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Open a file and read its binary data 
  b = loadBytes(filename);
*/
  drop = new SDrop(this);
}

void draw()
{
  if(started)
  {
  // background(0);
  if (!lores)
  {
    loadPixels();
  }
  else
  {
   rect_size = mouseX/10; 
  }
  // Print each value, from 0 to 255 
  for (int i = 0; i < b.length; i++) { 

    // bytes are from -128 to 127, this converts to 0 to 255 
    int a = b[i] & 0xff;

    if (lores)
    {
      fill(a);
      rect(x, y, rect_size, rect_size);
      x+=rect_size;
      if (x>width-rect_size)
      {
        x=0;
        y+=rect_size;
        if (y>height-rect_size)
        {
          y=0;
        }
      }
    } else
    {
      color c = color(a);
      pixels[index] = c;
      index++;
      if (index>=width*height)
      {
        index=0;
      }
    }
  }
  if (!lores)
  {
    updatePixels();
  }
  }
  else
  {
  }
}


void dropEvent(DropEvent theDropEvent) {
  String filename = theDropEvent.toString();
  String[] filename_list = split(filename, ".");
  println(filename_list[1]);
  if (filename_list[1].equals("wav") == true || filename_list[1].equals("aiff") == true || filename_list[1].equals("mp3") == true)
  {
    soundfile = new SoundFile(this, filename);
    soundfile.loop();
    println("SFSamples= " + soundfile.frames() + " samples");
    println("SFDuration= " + soundfile.duration() + " seconds");
  }
  if (filename_list[1].equals("app") == false)
  {
    // Open a file and read its binary data 
    b = loadBytes(filename);
    started= true;
  }
}
