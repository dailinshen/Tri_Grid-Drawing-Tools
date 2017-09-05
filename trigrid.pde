// light, mild, medium, heavy;
//color[] colors = {#E9EB7E, #D8DE26, #C2C820, #9EA21A};

// white pink, yello, green
//color[] colors = {#FFFFFF, #EF2D5F, #F2E646, #208275};

// white, purple, blue, yellow
color[] colors = {#FFFFFF, #B99CD1, #99D5CF, #F0E6A0};
int color_index = 0;




// specify in advance that we only want Tri_Unit object here by uisng generitics <Tri_Unit>
ArrayList<Tri_Unit> Tri_Grid;
float x_p = 0;
float y_p = 0;


int mouse_xp = -1;
int mouse_yp = -1;


float MIDDLE_LINE = 25 * sqrt(3);




class Tri_Unit {
  float x1, y1, x2, y2, x3, y3;
  int ci;
  Tri_Unit(float a1, float b1, float a2, float b2, float a3, float b3, int cc) {
    x1 = a1;
    y1 = b1;
    x2 = a2;
    y2 = b2;
    x3 = a3;
    y3 = b3;
    ci = cc;
  }
  void display() {
    if (ci != 0) {
      noStroke();
    } else {
      stroke(204);
    }
    fill(colors[ci]);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}




// This function is only called once.
void setup(){
  //fullScreen();
  size(1280, 720);
  background(colors[color_index]);
  smooth();
  strokeWeight(0.15);
  stroke(204);
  // call the constructor
  Tri_Grid = new ArrayList<Tri_Unit>();
  // add tri_units inside the Tri_Grid arraylist
  while (x_p < width) {
    // need to take care of the top corner
    while (y_p - 25 < height) {
      Tri_Grid.add(new Tri_Unit(x_p, y_p, x_p+MIDDLE_LINE, y_p-25, x_p+MIDDLE_LINE, y_p+25, color_index));
      Tri_Grid.add(new Tri_Unit(x_p, y_p, x_p, y_p+50, x_p+MIDDLE_LINE, y_p+25, color_index));
      Tri_Grid.add(new Tri_Unit(x_p+2*MIDDLE_LINE, y_p, x_p+MIDDLE_LINE, y_p-25, x_p+MIDDLE_LINE, y_p+25, color_index));
      Tri_Grid.add(new Tri_Unit(x_p+2*MIDDLE_LINE, y_p, x_p+2*MIDDLE_LINE, y_p+50, x_p+MIDDLE_LINE, y_p+25, color_index));
      y_p += 50;
    }
    y_p = 0;
    x_p += 2 * MIDDLE_LINE;
  }
}




// calculate the area of a triangle.
float area (float x1, float y1, float x2, float y2, float x3, float y3) {
  return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3);
}



// check if the mouse is over a triangle, return true of false.
boolean isOver(float x1, float y1, float x2, float y2, float x3, float y3) {
  boolean b1, b2, b3;
  
  b1 = area(mouse_xp, mouse_yp, x1, y1, x2, y2) < 0;
  b2 = area(mouse_xp, mouse_yp, x2, y2, x3, y3) < 0;
  b3 = area(mouse_xp, mouse_yp, x3, y3, x1, y1) < 0;
  
  return ((b1 == b2) && (b2 == b3));
}



// change the color of the clicked object on the event of mouseReleased.
void mouseReleased() {
  mouse_xp = mouseX;
  mouse_yp = mouseY;
  
  for (int i = 0; i < Tri_Grid.size(); i++) {
    Tri_Unit tu = Tri_Grid.get(i);
    
    if (isOver(tu.x1, tu.y1, tu.x2, tu.y2, tu.x3, tu.y3)){
      tu.ci = (tu.ci >= 3) ? 0 : (tu.ci + 1);
      // tu here is a reference pointer, shoul not remove and add it again to tri-grid.
      //Tri_Grid.remove(i);
      //Tri_Grid.add(tu); 
    }
  }
}





// This function is being called forever.
// Render the whole canvas each frame.
void draw() {
  // for every tri_unit inside tri_grid, display it.
  for (Tri_Unit tu : Tri_Grid) {
    tu.display();
  }
}