// velocity selector

int n = 10; // number of particles
float s = 5; // max speed of particles
float q = 0.01; // max charge on particles

float m = 1; // mass range
float r = 20; // radius of particle

// coordinates of parallel plates
float Tx = 100; // top plate x 
float Ty = 100; // top plate y 
float Bx = 100; // bottom plate x
float By = 300; // bottom plate y

PVector [] particles = new PVector[n]; // stores position of particles
float [] mass = new float [n]; // mass of particles
float [] charge = new float [n]; // charge of particles
PVector [] velocity = new PVector [n]; // velocity of particles (direction and magnitude)
PVector [] acceleration = new PVector [n]; // acceleration of partilces

float magneticfield = 0.5; // magnetic field in T
float v = 0.07; // voltage in volts 
float dbp = 0.05; // distance between plates in m 
float electricfield = v / dbp; // electrc field in N/C 

void setup() {
  frameRate(30);
  size(800, 800);
  
  // set intial values for particle position, mass, charge, velocity, acceleration of particles)
  for (int i = 0; i < n; i++) {
    
      particles[i] = new PVector(100, 200);
      
      mass [i] = random(0.5, m);
      
      charge[i] = random(0.001, q);
      
      velocity[i] = new PVector (random(0.5, s), 0);
      
      acceleration[i] = new PVector(0,0);
  }
}

void draw() {
  background(0);
  
  // draws the top and bottom plate
  pushMatrix(); 
  fill(0, 150, 250);
  rect(Tx, Ty, 500, 25);
  fill(0, 150, 250);
  rect(Bx, By, 500, 25);
  
  // draws text for postive and negative plate and direction of magnetic field
  fill(150, 150, 150);
  textSize(20);
  text(" + ", 700, 100);
  text(" - ", 700, 300);
  text(" x ", 700, 200);
  popMatrix();
  
  for (int i = 0; i < n; i ++) {
    
    // draws particles
    fill(0, 150, 150);
    noStroke();
    circle (particles[i].x, particles[i].y, r);

  }
  
  
  //calculate magnetic and electric force
  calculateForceonParticle(); 
  
  for (int i = 0; i < n; i++) {
   
    // the particle hits the top plate 
    if (particles[i].y <= (Ty + 25)) {
      particles[i].x = particles[i].x;
      particles[i].y = particles[i].y;
    }
    
    // the partilce hits the bottom plate
    else if (particles[i].y >= By) {
      particles[i].x = particles[i].x;
      particles[i].y = particles[i].y;
    }
    
    else {
      velocity[i].add(acceleration[i]);
      particles[i].add(velocity[i]);
    }
  }
}
