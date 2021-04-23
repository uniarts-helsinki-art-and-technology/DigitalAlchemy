
// you can change the order or amount of letters by editing this string of characters
String text = " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLunT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
// change font size
int font_size = 20;
PImage img;

void setup() 
{
  // change size according your image file size
  size(800, 600, P2D);
  // load image from harddrive
  img = loadImage("testi.jpg");
  // set font size
  textSize(font_size);
}

void draw() 
{
  // draw clear background
  background(255);
  // convert image to text and draw it
  convertImageToText(img);
}

void convertImageToText(PImage img)
{
  img.loadPixels();
  int l = text.length()-1;
  for (int y = 0; y < img.height; y+=font_size) {
    for (int x = 0; x < img.width; x+=font_size) {
      color c = img.get(x, y);
      int b = int(brightness(c));
      int bright = int(map(b, 0, 255, 0, l));         
      char letter= text.charAt(bright);
      fill(c);
      noStroke();
      text(str(letter), x, y );
    }
  }
}
