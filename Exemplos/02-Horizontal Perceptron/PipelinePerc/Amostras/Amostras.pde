PImage img;
PrintWriter output;


void setup() {
  size(400, 400);
  img = loadImage("img.png");

  output = createWriter("C:/Users/lacer/OneDrive/Desktop/SecondPerceptron-main/PipelinePerc/Treinamento/processingSaveData.txt");

  color c;
  float r = 0, g = 255, b = 255;
  float n = 0;
  int contp = 0;
  int contn = 0;
  int cont = 0;
  int distPar = 800;
  while (cont < 4096)
  {

    int i = (int)random(img.width);
    int j = (int)random(img.height);
  
    float distA = abs(i - img.width/2);
    // print(dv + "\n");
    if (distA > distPar && contn < 2048)
    {
      contn++;
      output.println(i+"\t"+j+"\t"+distA+"\t-1");
      cont++;
    }

    if (distA <= distPar && contp < 2048)
    {
      contp++;
      output.println(i+"\t"+j+"\t"+distA+"\t+1");
      cont++;
    }
  }//end-for-j

  println("contn == "+contn);
  println("contp == "+ contp);

  output.flush();
  output.close();
  exit();
}



void draw() {
  image(img, 0, 0);
}
