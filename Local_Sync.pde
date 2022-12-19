// Local SYNC
// Local syncronization with Turing patterns
// By Jaroslav Trnka, 2020
// https://github.com/JaroslavTrnka1
// jaroslav_trnka@centrum.cz

int grid = 40;
int cell;
float [][] phase = new float[grid][grid];
float step = 0.2;
int sensitivity = 20;
int frame = 1;

void setup() {
  size(400, 400);
  cell = int(height/grid);
    for (int i=0; i < grid; i++) {
      for (int j=0; j < grid; j++) {
        phase [i][j] = random(TWO_PI);
      }
    }
}

void draw() {
    for (int x=0; x < grid; x++) {
      for (int y=0; y < grid; y++) {
        fill((sin(phase[x][y]) + 1) * 127);
        rect(x*cell,y*cell,(x+1)*cell,(y+1)*cell);
        phase[x][y] += correction (x,y);
        phase[x][y] +=step;
      }
    }
}

float correction (int a, int b) {
  PVector sum;
  sum = new PVector();
  float kor;
  for (int k = max(a - frame, 0); k <= min(a + frame, grid-1); k++) {
    for (int l = max(b - frame, 0); l <= min(b + frame, grid-1); l++) {
      sum.add(PVector.fromAngle(phase [abs(k)][abs(l)]));
    }
  }
  kor = sum.heading();
  kor -= (phase[a][b] % TWO_PI);  //Devition from neighbours
  if (kor > PI) {
    kor = kor - TWO_PI;
  }
  if (kor < -PI) {
    kor = kor + TWO_PI;
  }
  kor = kor * step/PI;
  kor = kor * sensitivity / 100;
  return(kor);
}
