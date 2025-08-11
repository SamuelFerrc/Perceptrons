import java.io.File;

//PrintWriter output;

PImage img;
PImage imgP;
PImage imgN;

void setup() {
  size(1920, 620);

  String folderPath = "C:\\Users\\lacer\\OneDrive\\Desktop\\VisibleData";
  String exitPath = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\01-RGB Perceptron\\Perceptron_01\\Classificação\\Imagens";
  File folder = new File(folderPath);

  if (!folder.exists() || !folder.isDirectory()) {
    println("Pasta não encontrada ou inválida: " + folderPath);
    exit();
  }

  File[] files = folder.listFiles((dir, name) -> name.toLowerCase().endsWith(".png"));

  if (files == null || files.length == 0) {
    println("Nenhuma imagem PNG encontrada na pasta.");
    exit();
  }
  String[] linhas = loadStrings("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\01-RGB Perceptron\\Perceptron_01\\Treinamento\\pesos.txt");

  int a = 0;
  while (a < linhas.length) {

    int v = 0;  // Zera o contador de imagens para esta linha de pesos

    if(files == null) return; 
    for (File file : files) {
      if ((v % (files.length/linhas.length) == 0 && v != 0)) {
        a++;
        println(linhas[a]);
      }

      String[] ws = linhas[a].split("\t");
      float w1 = Float.parseFloat(ws[0]), w2 = Float.parseFloat(ws[1]), w3 = Float.parseFloat(ws[2]), bias = Float.parseFloat(ws[3]);
      println(v + "/" + files.length);


      String fileName = file.getName();

      img = loadImage(folderPath + File.separator + fileName);
      imgP = loadImage(folderPath + File.separator + fileName);
      imgN = loadImage(folderPath + File.separator + fileName);

      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          color co = img.get(i, j);
          float r = red(co);
          float g = green(co);
          float b = blue(co);

          float newS = (w1 * r) + (w2 * g) + (w3 * b) + bias;
          if (newS > 0) {
            imgN.set(i, j, color(255, 255, 255));
          } else {
            imgP.set(i, j, color(255, 255, 255));
          }
        }
      }

      imgP.save(exitPath + File.separator + fileName.replace(".png", "_P.png"));
      //imgN.save(exitPath + File.separator + fileName.replace(".png", "_N.png"));

      v++;
    }

    a++;
  }

  println("Processamento concluído.");
  exit();
}

void draw() {
  noLoop();
}
