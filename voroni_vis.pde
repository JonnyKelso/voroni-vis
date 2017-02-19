int num_points = 0;
int max_points = 100;
Point[] points = new Point[max_points];
color[] colors = new color[max_points];
PImage img;
int max_distance = width * height; //int(sqrt(sq(width) + sq(height)));

void setup() 
{
  // set window size
  size(640, 480);

  img = createImage(width, height, RGB);
  img.loadPixels();
  for (int i = 0; i < max_points; i++) { 
    colors[i] = get_color();
  } 
  
  for (int i = 0; i < img.pixels.length; i++) { 
    img.pixels[i] = colors[0]; 
  } 

  img.updatePixels();
}

void draw() 
{
  //background(background_color);

  image(img,0,0);
  draw_points();
  // draw instructions to the screen
  //drawUI();
}



void keyPressed()
{
  // increment or decrement the new resolution level appropriately.

  if (key == '+')
  {

  }
  else if (key == 'l' || key == 'L')
  {
    selectInput("Select an image file to process:", "fileSelected");
  }
}

void mousePressed()
{
  if(num_points < max_points) //<>//
  {
    Point pt = new Point(mouseX, mouseY);
    points[num_points] = pt;
    num_points++;
  }
  int closest_index = 0;
  for(int pix_y = 0; pix_y < height; pix_y++)
  {
    for(int pix_x = 0; pix_x < width; pix_x++)
    {
    
      closest_index = find_closest_point(pix_x, pix_y);
      img.pixels[pix_x + (pix_y* width)] = colors[closest_index];
      //img.pixels[pix_x + (pix_y* width)] = color(pix_x,0,0); //<>//
    }  
  }
  img.updatePixels();
  
  //println("mouseX = " + mouseX + " mouseY = " + mouseY + " closest pt = " + closest_index);
}
int find_closest_point(int x, int y)
{
  int shortest_distance = max_distance;
  int closest_index = 0;
  for(int i = 0; i < num_points; i++)
  {
    int distance = get_distance_between_points(x, y, points[i].x, points[i].y);
    if(distance < shortest_distance)
    {
      shortest_distance = distance;
      closest_index = i;
      //println("px = " + x + " py = " + y + " closest pt = " + closest_index);
    }
  }
  return closest_index;
}
int get_distance_between_points(int x, int y, int a, int b)
{
  int distance = int(sqrt(sq(x - a) + sq(y - b)));
  return distance;
}
color get_color()
{
  return color(random(255), random(255), random(255));
}
// show text instructions for use
void drawUI()
{
  fill(255, 255, 255);
  textSize(18);
  text("press '-' to decrease resolution", 10, height-60);
  text("press '+' to increase resolution", 10, height-40);
  text("press 'L' to load new image", 10, height-20);
}
void draw_points()
{
  for(int i = 0; i < num_points; i++)
  {
    ellipse(points[i].x, points[i].y, 5,5);
  }
}