// calculates magnetic and electric force on particle
void calculateForceonParticle () {
  for ( int i = 0; i < n; i ++) {
    
    // particle position
    PVector p = particles[i];
    
    // vector for magnetic force
    float qx = particles[i].x;
    float qy = particles[i].y;
    PVector q = new PVector(qx, qy + 5);
    
    // vector for electric force
    float ax = particles[i].x;
    float ay = particles[i].y;
    PVector a = new PVector(ax, ay - 5);
    
    // Calculates magnetic force on particle
    PVector ForceOnPfromQ = magneticforce(p, q, charge[i], velocity[i]); // magnetic force
    PVector accelerationFromQ = PVector.div(ForceOnPfromQ, mass[i]); // a = F/m
    acceleration[i].add(accelerationFromQ);
   
    // Calculates electric force on particle
    PVector ForceOnPfromA = electricforce(p, a, charge[i]); // electric force
    PVector accelerationFromA = PVector.div(ForceOnPfromA, mass[i]); // a = F/m 
    acceleration[i].add(accelerationFromA);
    
  }
  
}

// Calculates magnetic force
PVector magneticforce (PVector p, PVector q, float c, PVector vel) {
  PVector pMinusQ = PVector.sub(p, q); // creates vector that is in -y direction
  pMinusQ.normalize(); // creates unit vector
  
  float magn = c * vel.mag() * magneticfield; // Fm = charge * velocty * magnetic field
  PVector Fm = pMinusQ.mult(magn); // magnetic force
  
  return Fm;
}

// Calculates electric force
PVector electricforce (PVector p, PVector a, float c) {
  PVector pMinusA = PVector.sub(p, a); // creates vector that is in +y direction
  pMinusA.normalize(); // creates unit vector
  
  float magn = c * electricfield; // fq = charge * electric field
  PVector Fq = pMinusA.mult(magn); // electric force
  
  return Fq; 
}
