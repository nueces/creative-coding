/*
 * Creative Coding
 * Week 1, 01 - Draw your name!
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014 Monash University
 
 * This program allows you to draw using the mouse.
 * Press 's' to save your drawing as an image to the file "yourName.jpg"
 * Press 'r' to erase your drawing and start with a blank screen
 * 
 */
import gifAnimation.*;

GifMaker gifExport;
int version = 0;
int digit = 3;
int shape = 0;
boolean roll_dice = false;
boolean aleatory = false;

int RECTANGLE = 0;
int ELLIPSE = 1;
int TRIANGLE = 2;

// debug
String str_shape = "";

int delay = 1;

// setup function -- called once when the program begins
void setup() {

  // set the display window to size 500 x 500 pixels
  size(500, 500);

  // set the background colour to white
  background(255);

  // set the rectangle mode to draw from the centre with a specified radius
  rectMode(RADIUS);

  // set frame rate for the gif export.
  frameRate(30);

  // create a new gif.
  gifExport = new GifMaker(this, "yourName.gif");
  gifExport.setRepeat(0);
  gifExport.setTransparent(random(256),random(256),random(256));

}


// draw function -- called continuously while the program is running
void draw() {
    /* draw a rectangle at your mouse point while you are pressing 
    the left mouse button */
    if (mousePressed) {
        if (mouseButton == LEFT) {
            // draw a rectangle with a small random variation in size
            stroke(random(100));
            fill(0, 150); // set the fill colour to black with transparency
            rect(mouseX, mouseY, random(10), random(10));
            delay = 0;
        }
        else if (mouseButton == RIGHT) {
        // set the stroke and fill colour to white.
            stroke(255);
            fill(255);
            ellipse(mouseX, mouseY, 30, 30);
            delay = 0;
        }
        else {
            delay = 1;
            // set a random value for the red, green and blue colour.
            int red = (int)random(256);
            int green = (int)random(256);
            int blue = (int)random(256);

            // rolling a three side dice.
            if (roll_dice) {
                shape = (int)random(3);
                if (!aleatory) {
                    roll_dice = false;
                }
            }
            stroke(red, green, blue);
            // use the complemetary colour.
            fill(255-red, 255-green, 255-blue);

            if (shape == RECTANGLE) {
                rect(mouseX, mouseY, random(80), random(80));
            }
            else if (shape == ELLIPSE) {
                ellipse(mouseX, mouseY, random(80), random(80));
            }
            else if (shape == TRIANGLE) {
                int f = 30; 
                float r = random(f) * f;
                float p = sin(30) * r;
                float q = sin(60) * r;
               
                float x1 = mouseX - q % f;
                float y1 = mouseY - p % f;
                float x2 = mouseX; 
                float y2 = mouseX + r % f;
                float x3 = mouseX + q % f;
                float y3 = mouseY - p % f;
               
                triangle(x1,y1, x2, y2, x3, y3);
            }
        }
        // save the frame in the gif.    
        gifExport.setDelay(delay);
        gifExport.addFrame();
    }

    // save your drawing when you press keyboard 's'
    if (keyPressed == true ) {
        if (key == 'S') {
            saveFrame("yourName-saved-" + nf(version++, digit) + ".jpg");
        }
        // erase your drawing when you press keyboard 'r'
        else if (key == 'R') {
            background(255);
            // reset gif.
            gifExport = new GifMaker(this, "yourName.gif");
            gifExport.setRepeat(0);
            gifExport.setTransparent(random(256),random(256),random(256));
        }
        // create a gif version when you press the keyboard 'g'.
        else if (key == 'G') {
            // save the gif to the disk.
            gifExport.finish();
        }
        // choose a random shape in every draw.
        else if (key == 'd') {
            aleatory = false;  
            roll_dice = true;
            str_shape = "chosed later";
        }
        // allways aleatory
        else if (key == 'a') {
            aleatory = true;
            roll_dice = true;
            str_shape = "allways aleatory";
        }
        // rect
        else if (key == 'r') {
            shape = RECTANGLE;
            aleatory = false;
            roll_dice = false;
            str_shape = "rectangle";
        }
        else if (key == 'e') {
            shape = ELLIPSE;
            aleatory = false;
            roll_dice = false;
            str_shape = "ellipse";
        }
        else if (key == 't') {
            shape = TRIANGLE;
            aleatory = false;
            roll_dice = false;
            str_shape = "triangle";
        }
        // print for information and debug.
        println("key pressed:" + key + ", shape: " + str_shape + ", aleatory: " + aleatory + ", rool dice:" + roll_dice);
   }
}
