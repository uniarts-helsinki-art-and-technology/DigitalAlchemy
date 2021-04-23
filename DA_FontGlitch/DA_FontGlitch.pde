import geomerative.*;
import processing.svg.*;

color font_fill_color = color(0, 200, 0);
color font_outline_color = color(200, 200, 0);

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] points;
ArrayList<RPoint[]> point_list = new ArrayList<RPoint[]>();

boolean get_points = true;
int number_of_letters;
String letters = "";
boolean record;

void setup() {
  // Initilaize the sketch
  size(600, 400);
  frameRate(24);
  // Choice of colors
  background(255);
  fill(255, 102, 0);
  stroke(0);
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
  // Enable smoothing
  smooth();
}

void draw() {

  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    beginRecord(SVG, "glitch"+year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second()+"-"+millis()+".svg");
      // Clean frame
  background(255);
  }
  else{
  // Clean frame
  background(255);
  text("Writing something. Glitch with mouse movement. Save vector file with mouse click." ,50,height-50);
  }
  // Set the origin to draw in the middle of the sketch
  translate(width/2, height/4);

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  
  if (get_points)
  {
    point_list.clear();
    for (int letter = 0; letter<number_of_letters; letter++)
    {
      if (grp.children[letter].getPoints()!= null)
      {
        points = grp.children[letter].getPoints();
        point_list.add(points);
      }
    }
    get_points=false;
  }

  // If there are any points
  if (points != null) {
    float mX = mouseX/500.0;
    float mY = mouseY/500.0;

    for (int j=0; j<point_list.size(); j++) {
      RPoint[] pointss = point_list.get(j);
      println(j+":"+pointss.length);
      beginShape();
      for (int i=0; i<pointss.length; i++) {
        int r = int(random(10, pointss.length)-10);

        if (r>=i)
        {
          float rX = random(-mX, mX);
          float rY = random(-mY, mX);
          vertex(pointss[i].x+rX, pointss[i].y+rY);
          pointss[i].x+=+rX;
          pointss[i].y+=rY;
        } else
        {
          vertex(pointss[i].x, pointss[i].y);
        }
      }
      
      endShape();
    }

    if (record) {
      endRecord();
      record = false;
    }
  }
}

void mousePressed()
{
  record=true;
}

void keyPressed() {
  // println(parseInt(key));
  if (key == BACKSPACE) {
    if (letters.length() > 0) {
      letters = letters.substring(0, letters.length()-1);
    }
  } else if (key==TAB)
  {
  } else if (parseInt(key)>64 && parseInt(key)<255) {
    letters = letters + key;
  } else if (parseInt(key) == 32 ) {
    letters = letters + "-";
  }
  setText(letters);
  get_points=true;
}

void setText(String s)
{
  String text = s;
  number_of_letters = text.length();
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText(text, "FreeSans.ttf", 48, CENTER);
//  grp = RG.getText(text, "30366655770.ttf", 72, CENTER);
}
