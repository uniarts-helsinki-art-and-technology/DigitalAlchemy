// Example of a program that loads and shows image files (png + jpg) from folder
// You need to specify the path to the folder

File dir; 
File [] files;
int i = 0;

void setup() {
  size(400,400);
  // specify the path in quotation marks
  dir= new File(dataPath("/path/to/local/folder/"));
  files= dir.listFiles();
}

void draw() { 
  
  String path = files[i].getAbsolutePath();

  if (path.toLowerCase().endsWith(".png") || path.toLowerCase().endsWith(".jpg"))
  {
    showImage(path);
  }

  if (i>files.length - 1)
  {
    i=0;
  }
  i++;
}


void showImage(String filepath)
{
  PImage photo; // VARIABLE
  photo = loadImage(filepath);
  image(photo, 0, 0);
}
