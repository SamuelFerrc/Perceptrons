import java.io.File;

PImage img;
PImage imgP;
PImage imgN;

void setup() {
  size(1920, 620);

  String sourceFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\Imagens"; // Pasta de entrada (imagens originais)
  String destinationFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\3Heads"; // Pasta de saída

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

float w1 = 0.037136834; float w2 = 0.2519207; float w3 = -0.8409078;float bias = 210;
float c = -135;
int v = 0;
  for (File file : files) {
    v++;
    if(v > 3) break;
    if (file.isFile() && (file.getName().endsWith(".png") || file.getName().endsWith(".jpg"))) {
      String name = file.getName();
      img = loadImage(sourceFolder + "/" + name);
      imgP = loadImage(sourceFolder + "/" + name);
      imgN = loadImage(sourceFolder + "/" + name);


      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          if(v == 1) bias = 100;
          if(v == 1017) bias = 145;
          color co = img.get(i, j);
          float r = i;
          float g = j;
          float b = abs(j - img.height / 2 - c);

          if(red(co) == 255 && blue(co) == 0 && green(co) == 0)
          {
            imgP.set(i,j,color(255,255,255));
          }
          

          float newS = (w1 * r) + (w2 * g) + (w3 * b) + bias;
          if (newS < 0) {
            imgP.set(i, j, color(255, 0, 0));
          } else {
            imgN.set(i, j, color(255, 255, 255));
          }
        }
      }

      imgP.save(destinationFolder + "/" + name.replace(".png", ".png"));
      //imgN.save(destinationFolder + "/" + name.replace(".png", "_N.png"));
    }
  }
  println("Processamento concluído! Imagens salvas em: " + destinationFolder);
  exit();
}
