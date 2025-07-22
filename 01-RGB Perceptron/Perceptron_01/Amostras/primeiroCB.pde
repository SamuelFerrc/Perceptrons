import java.io.File;

PImage img;
PrintWriter output;

String folderPath = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\RGBPerceptron\\Perceptron_01\\Amostras\\VisibleData";
String outputFolder = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\RGBPerceptron\\Perceptron_01\\Amostras\\FilesTXT\\";
int blocoTamanho = 50;
int totalDadosPorBloco = 4096;

File folder;
File[] images;

float sqr(int x) {
  return x * x;
}

void setup() {
  folder = new File(folderPath);
  images = folder.listFiles((dir, name) -> name.toLowerCase().endsWith(".png"));

  if (images == null || images.length == 0) {
    println("Nenhuma imagem encontrada na pasta.");
    exit();
  }

  // Ordena as imagens por nome para garantir consistência
  java.util.Arrays.sort(images);

  int totalBlocos = (int) ceil(images.length / float(blocoTamanho));

  println("Total de blocos: " + totalBlocos);

  for (int bloco = 0; bloco < totalBlocos; bloco++) {
    String outputPath = outputFolder + "processingSaveData_" + bloco + "_.txt";
    output = createWriter(outputPath);

    println("Processando bloco: " + bloco);
    
    int contn = 0;
    int contp = 0;
    int cont = 0;
    int distPar = 16;

    for (int i = bloco * blocoTamanho; i < min((bloco + 1) * blocoTamanho, images.length); i++) {
      File imageFile = images[i];
      img = loadImage(imageFile.getAbsolutePath());

      if (img == null) {
        println("Erro ao carregar: " + imageFile.getName());
        continue;
      }

      println("  → Imagem: " + imageFile.getName());

      color c;
      float r, g, b;
      float dv;

      while (cont < totalDadosPorBloco) {
        int x = (int) random(img.width);
        int y = (int) random(img.height);

        c = img.get(x, y);
        r = red(c);
        g = green(c);
        b = blue(c);

        dv = dist(r, g, b, 0, 6, 23);

        if (dv < distPar && contn < totalDadosPorBloco / 2) {
          contn++;
          cont++;
          output.println(r + "\t" + g + "\t" + b + "\t-1");
        } else if (dv >= distPar && contp < totalDadosPorBloco / 2) {
          contp++;
          cont++;
          output.println(r + "\t" + g + "\t" + b + "\t+1");
        }

        // Para caso esgotar dados da imagem atual e precisar ir pra próxima
        if ((contn >= totalDadosPorBloco / 2) && (contp >= totalDadosPorBloco / 2)) break;
      }
    }

    output.flush();
    output.close();

    println("  ✔ Bloco " + bloco + " finalizado: " + cont + " amostras.");
  }

  println("Todos os blocos foram processados.");
  exit();
}
