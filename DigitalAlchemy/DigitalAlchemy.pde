PImage testikuva;
String file_name = "testi.jpg";

void setup()
{
  testikuva = loadImage(file_name);
  startAlchemy();
  
}




void draw()
{
  background(0);
  if(!isProcessing)
  {
  // Should manipulate pixels!  drawFlippedImage(testikuva);
  // doodling(testikuva);
  moveImageWithKeyboard(100);
  drawImage(testikuva);
  //drawImageGrid(testikuva,5);
  recording();
  drawMagicWords();
  }
}
