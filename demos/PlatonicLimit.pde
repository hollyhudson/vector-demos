public class Vertex {
  float x,y,z;
  color edgeColor;
  public Vertex (float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    edgeColor = color(200);
  }
}

public class PlatonicLimit {
  final int TETRAHEDRON = 0;
  final int CUBE = 1;
  final int OCTAHEDRON = 2;
  final int ICOSAHEDRON = 3;
  final int DODECAHEDRON = 4;
  
  //changes the shape to be permutated
  int primitive = TETRAHEDRON;
  boolean animationOn = true;
  boolean gridOn = true;
  color background = color(0);
  color gridLinesColor = color(200);
  //change to set edge length multiplier
  float edgeLengthMultiplier = 1f;
  //make true to generate another scene
  boolean next = false;
  
  float edgeLength;
  int sideCount;
  float gridSize;
  float interval;
  Vertex[][] edges;
  int lastPrimitive;
  int drawCount;
  
  float rotateXAngle = PI * 5/6;
  float rotateYAngle = PI * -5/6;
  float rotateZAngle = 0;
  
  ArrayList<Integer> combinationSet;
  
  boolean checkMask(int position, int mask) {
    return (mask & 1 << position) != 0;
  }
  
  void drawEdges(PApplet applet, int combination, int sideCount) {
    for (int i = 0; i < sideCount; i++) {
      if (checkMask(i, combination)) {
        //stroke(lerpColor(edges[i][0].edgeColor, edges[i][1].edgeColor, .5));
        //uncomment to party
        //stroke(random(255), random(255), random(255));
        float finalEdgeLength = edgeLength * edgeLengthMultiplier;
        applet.line(edges[i][0].x * finalEdgeLength, edges[i][0].y * finalEdgeLength, edges[i][0].z * finalEdgeLength,
              edges[i][1].x * finalEdgeLength, edges[i][1].y * finalEdgeLength, edges[i][1].z * finalEdgeLength);
      }
    }
  }
  
  int findGridSize(int combos) {
    return ceil(sqrt(combos)) + 1;
  }
  
  void initCube() {
    Vertex a = new Vertex(-1, -1, -1);
    Vertex b = new Vertex(-1, 1, -1);
    Vertex c = new Vertex(1, -1, -1);
    Vertex d = new Vertex(-1, -1, 1);
    Vertex e = new Vertex(-1, 1, 1);
    Vertex f = new Vertex(1, 1, -1);
    Vertex g = new Vertex(1, -1, 1);
    Vertex h = new Vertex(1, 1, 1);
    Vertex[][] tmpEdges = {
                          {a, b}, {a, c}, {a, d},
                          {h, e}, {h, f}, {h, g},
                          {b, e}, {b, f},
                          {g, c}, {g, d},
                          {f, c}, {d, e}
                         };
    edges = tmpEdges;
  }
  
  void initTetrahedron() {
    Vertex a = new Vertex(0, (sqrt(3f) - 1f/sqrt(3f)), 0);
    Vertex b = new Vertex(-1f, -1f/sqrt(3f), 0);
    Vertex c = new Vertex(1f, -1f/sqrt(3f), 0);
    Vertex d = new Vertex(0, 0, 2f * sqrt(2f/3f));
    Vertex[][] tmpEdges = {{a, b}, {a, c},  {a, d}, {b, c}, {b, d}, {c, d}};
    edges = tmpEdges;
  }
  
  void initOctahedron() {
    Vertex a = new Vertex(1f, 0, 0);
    Vertex b = new Vertex(0, 1f, 0);
    Vertex c = new Vertex(0, 0, 1f);
    Vertex d = new Vertex(0, -1f, 0);
    Vertex e = new Vertex(0, 0, -1f);
    Vertex f = new Vertex(-1f, 0, 0);
    Vertex[][] tmpEdges = {{a, b}, {a, c}, {a, d}, {a, e}, {f, b}, {f, c}, {f, d}, {f, e}, {b, c}, {b, e}, {d, c}, {d, e}};
    edges = tmpEdges;
  }
  
  void initIcosahedron() {
    float t2 = PI / 10;
    float t4 = PI / 5;
    float R  = (1f/2f) / sin(t4);
    float H  = cos(t4) * R;
    float Cx = R * cos(t2);
    float Cy = R * sin(t2);
    float H1 = sqrt(1f * 1f - R * R);
    float H2 = sqrt((H + R) * (H + R) - H * H);
    float z2 = (H2 - H1) / 2f;
    float z1 = z2 + H1;
    
    Vertex a = new Vertex(0, 0, z1);
    Vertex b = new Vertex(0, R, z2);
    Vertex c = new Vertex(Cx, Cy, z2);
    Vertex d = new Vertex(1f/2f, -H, z2);
    Vertex e = new Vertex(-1f/2f, -H, z2);
    Vertex f = new Vertex(-Cx, Cy, z2);
    Vertex g = new Vertex(0, -R, -z2);
    Vertex h = new Vertex(-Cx, -Cy, -z2);
    Vertex i = new Vertex(-1f/2f, H, -z2);
    Vertex j = new Vertex(1f/2f, H, -z2);
    Vertex k = new Vertex(Cx, -Cy, -z2);
    Vertex l = new Vertex(0, 0, -z1);
    
    Vertex[][] tmpEdges = {
                            {a, b}, {a, c}, {a, d}, {a, e}, {a, f},
                            {l, g}, {l, h}, {l, i}, {l, j}, {l, k},
                            {b, c}, {c, d}, {d, e}, {e, f}, {f, b},
                            {g, h}, {h, i}, {i, j}, {j, k}, {k, g},
                            {b, i}, {i, f}, {f, h}, {h, e}, {e, g},
                            {g, d}, {d, k}, {k, c}, {c, j}, {j, b}
                          };
    edges = tmpEdges; 
  }
  
  void initDodecahedron() {
    float phi = (sqrt(5f) - 1f) / 2f;
    float constA = 1f / sqrt(3f);
    float constB = constA / phi;
    float constC = constA * phi;
    float constR = 1f;
   
    Vertex a = new Vertex(0, -1f * constC * constR, -1f * constB * constR);
    Vertex b = new Vertex(0, 1f * constC * constR, -1f * constB * constR);
    Vertex c = new Vertex(0, -1f * constC * constR, 1f * constB * constR);
    Vertex d = new Vertex(0, 1f * constC * constR, 1f * constB * constR);
    
    Vertex e = new Vertex(-1f * constC * constR, -1f * constB * constR, 0);
    Vertex f = new Vertex(1f * constC * constR, -1f * constB * constR, 0);
    Vertex g = new Vertex(-1f * constC * constR, 1f * constB * constR, 0);
    Vertex h = new Vertex(1f * constC * constR, 1f * constB * constR, 0);
    
    Vertex i = new Vertex(-1f * constB * constR, 0, -1f * constC * constR);
    Vertex j = new Vertex(-1f * constB * constR, 0, 1f * constC * constR);
    Vertex k = new Vertex(1f * constB * constR, 0, -1f * constC * constR);
    Vertex l = new Vertex(1f * constB * constR, 0, 1f * constC * constR);
    
    Vertex m = new Vertex(-1f * constA * constR, -1f * constA * constR, -1f * constA * constR);
    Vertex n = new Vertex(-1f * constA * constR, -1f * constA * constR, 1f * constA * constR);
    Vertex o = new Vertex(-1f * constA * constR, 1f * constA * constR, -1f * constA * constR);
    Vertex p = new Vertex(-1f * constA * constR, 1f * constA * constR, 1f * constA * constR);
    Vertex q = new Vertex(1f * constA * constR, -1f * constA * constR, -1f * constA * constR);
    Vertex r = new Vertex(1f * constA * constR, -1f * constA * constR, 1f * constA * constR);
    Vertex s = new Vertex(1f * constA * constR, 1f * constA * constR, -1f * constA * constR);
    Vertex t = new Vertex(1f * constA * constR, 1f * constA * constR, 1f * constA * constR);
    
    Vertex[][] tmpEdges = {
                            {a, b}, {c, d}, {e, f}, {g, h}, {i, j}, {k, l},
                            {m, a}, {m, e}, {m, i}, {n, c}, {n, e}, {n, j},
                            {o, b}, {o, g}, {o, i}, {p, d}, {p, g}, {p, j},
                            {q, a}, {q, f}, {q, k}, {r, c}, {r, f}, {r, l},
                            {s, b}, {s, h}, {s, k}, {t, d}, {t, h}, {t, l},
                          };
    edges = tmpEdges; 
  }
  
  void initShape() {
    switch(primitive) {
      case TETRAHEDRON:
        initTetrahedron();
        break;
      case OCTAHEDRON:
        initOctahedron();
        break;
      case ICOSAHEDRON:
        initIcosahedron();
        break;
      case DODECAHEDRON:
        initDodecahedron();
        break;
      case CUBE:
      default:
        initCube();
        break;
    }
  }
  
  void recurseCombination(int selection, int total, int combination) {
    if (selection > 0 && total >= selection) {
      //set bit to 1, move start recursion with one less select
      int newCombination = combination | (1 << total - 1);
      recurseCombination(selection - 1, total - 1, newCombination);
      if (total > selection)
        //don't set bit to 1, move start recursion with same # of select
        recurseCombination(selection, total - 1, combination);
    } else {
      combinationSet.add(combination);
    }
  }
  
  void init() {
    combinationSet = new ArrayList<Integer>();
    int selection;
    switch(primitive) {
      case TETRAHEDRON:
        sideCount = 6;
        selection = (int) (sideCount - random(2));
        break;
      case OCTAHEDRON:
        sideCount = 12;
        selection = sideCount;
        break;
      case ICOSAHEDRON:
        sideCount = 30;
        selection = sideCount;
        break;
      case DODECAHEDRON:
        sideCount = 30;
        selection = sideCount;
        break;
      case CUBE:
      default:
        selection = 12;
        selection = (int) (sideCount - random(2));
        break;
    }
    recurseCombination(selection, sideCount, 0);
    gridSize = findGridSize(combinationSet.size());
    interval = width / gridSize;
    edgeLength = interval / 4;
    lastPrimitive = primitive;
    initShape();
  }
  
  void setup(PApplet applet) {
      init();
      applet.ortho();
      applet.noFill();
      applet.frameRate(30);
      drawCount = 0;
  }
  
  void draw(PApplet applet) {
    if (lastPrimitive != primitive) {
      init();
    }
    applet.background(background);
    applet.stroke(gridLinesColor);
    applet.pushMatrix();
    applet.translate(interval / 2,  interval / 2);
    if (gridOn) {
      for(int i = 0; i < gridSize; i++){
          float columnX = i * interval;
          applet.line(columnX, 0, columnX, (gridSize - 1) * interval);
      }
      for(int i = 0; i < gridSize; i++){
        float rowY = i * interval;
        applet.line(0, rowY, (gridSize - 1) * interval, rowY);
      }
    }
    applet.translate((gridSize - 1) * interval - interval / 2f,  interval / 2f);
    int column = 0;
    for(Integer combination : combinationSet) {
      applet.pushMatrix();
      applet.rotateX(rotateXAngle);
      applet.rotateY(rotateYAngle);
      applet.rotateZ(rotateZAngle);
      drawEdges(applet, combination, sideCount);
      applet.popMatrix();
      if (++column == gridSize - 1) {
        applet.translate(-interval, -(gridSize - 2) * interval);
        column = 0;
      } else {
        applet.translate(0, interval);
      }
    }
    applet.popMatrix();
    if (drawCount == 90 || next)
      generateNextScene();
    if (animationOn) {
      rotateXAngle += PI/180;
      rotateYAngle += PI/180;
      rotateZAngle += PI/180;
      drawCount++;
    }
  }
  
  void generateNextScene() {
    primitive = (primitive + 1) % 5;
    drawCount = 0;
    next = false;
  }
}