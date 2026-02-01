import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

String[] imagePaths;
int index = 0;

void setup() {

  imagePaths = listPaths("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\Resultados\\VER-Imagens");

  if (imagePaths.length < 2) {
    println("A pasta deve conter pelo menos 2 imagens.");
    exit();
  }

  createBorder();

  println("Processamento concluído.");
  exit();
}
void createBorder()
{
  index = 1;


  while (index < imagePaths.length - 1) {
    try {

      println(index + "/" + imagePaths.length);

      PImage img1 = loadImage("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\Resultados\\MER-Imagens\\image" + index+".png");
      img1.loadPixels();

      for (int i = 0; i < img1.pixels.length; i++) {
        if (img1.pixels[i] == color(255, 0, 0)) {
          img1.pixels[i] = color(255, 255, 255);
        }
      }

      PImage bordaImg = createImage(img1.width, img1.height, RGB);
      bordaImg.loadPixels();

      for (int y = 1; y < img1.height - 1; y++) {
        for (int x = 1; x < img1.width - 1; x++) {
          color c = img1.get(x, y);

          boolean atualBranco = isWhite(c);
          boolean vizinhoDif = false;

          // verifica 4 vizinhos
          if (isWhite(img1.get(x+1, y)) != atualBranco) vizinhoDif = true;
          if (isWhite(img1.get(x-1, y)) != atualBranco) vizinhoDif = true;
          if (isWhite(img1.get(x, y+1)) != atualBranco) vizinhoDif = true;
          if (isWhite(img1.get(x, y-1)) != atualBranco) vizinhoDif = true;

          if (vizinhoDif && !atualBranco) {
            bordaImg.set(x, y, color(red(c), green(c), blue(c))); // marca borda preta
          } else {
            bordaImg.set(x, y, color(255, 255, 255)); // fundo branco
          }
        }
      }
      bordaImg.updatePixels();
      bordaImg.save("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\Resultados\\LIN-Imagens\\a_vm" + (1000+index)+".png");
      index ++;
    }
    catch (Exception e)
    {
      index++;
    }
  }
}

boolean isWhite(color c) {
  return c == color(255, 255, 255);
}
