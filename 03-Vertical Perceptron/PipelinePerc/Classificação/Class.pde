import java.io.File;

PImage img;
PImage imgP;
PImage imgN;

//315 - 676
void setup() {
  size(1, 1);

  String sourceFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\HOR-Imagens";
  String destinationFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\VER-Imagens";

  File destFolder = new File(destinationFolder);
  if (!destFolder.exists()) {
    destFolder.mkdirs();
  }

  File folder = new File(sourceFolder);
  File[] files = folder.listFiles();
  if (files == null) {
    println("Nenhuma imagem encontrada na pasta: " + sourceFolder);
    exit();
  }

  float w1 = -0.1978115; 
  float w2 = 0.03838694; 
  float w3 = -0.94511974; 
  float bias = 916.2192;
  float c = 155;
  //316 - 676
  int v = 0;
  for (File file : files) {
    v++;

    println(v);
    if (file.isFile() && (file.getName().endsWith(".png") || file.getName().endsWith(".jpg"))) {
      String name = file.getName();
      img = loadImage(sourceFolder + "/" + name);
      imgP = loadImage(sourceFolder + "/" + name);
      imgN = loadImage(sourceFolder + "/" + name);

      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          
          float r = i;
          float g = j;
          float b = abs(i - img.width / 2 );

         // float newS = (w1 * r) + (w2 * g) + (w3 * b) + bias;
          if (b > 850) {
            imgP.set(i, j, color(255, 0, 0));
          } else {
            imgN.set(i, j, color(0, 0, 255));
          }
        }
      }

      imgP.save(destinationFolder + "/" + name.replace(".png", "_P.png"));
      //imgN.save(destinationFolder + "/" + name.replace(".png", "_N.png"));
    }
  }
  println("Processamento concluído! Imagens salvas em: " + destinationFolder);
  exit();
}

float defRange(int x, int min, int max, float result)
{
   if(x >= min && x <= max)
   {
     return result;
   }
   else
   {
     return 0;
   }
   
}
