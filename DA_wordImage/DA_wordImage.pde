
StringList list_of_words;
// change font size
int font_size = 10;
PImage img;

void setup() 
{
  // change size according your image file size
  size(800, 600, P2D);
  // load image from harddrive
  img = loadImage("testi.jpg");
  // set font size
  textSize(font_size);
  
  list_of_words= new StringList();
  // you can insert more words by duplicating a following line
  list_of_words.append("coffee");
  list_of_words.append("tea");
  list_of_words.append("images");

}

void draw() 
{
  // draw clear background
  background(255);
  // convert image to text and draw it
  convertImageToWords(img);
}

void convertImageToWords(PImage img)
{
  img.loadPixels();
  int l = list_of_words.size()-1;
  int last_word_lenght = font_size;
  for (int y = 0; y < img.height; y+=font_size) {
    for (int x = 0; x < img.width; x+=last_word_lenght) {
      color c = img.get(x, y);
      int b = int(brightness(c));
      int bright = int(map(b, 0, 255, 0, l));         
      String word = list_of_words.get(bright);
      fill(c);
      noStroke();
      text(word, x, y );
      last_word_lenght=floor(textWidth(word));
    }
  }
}
