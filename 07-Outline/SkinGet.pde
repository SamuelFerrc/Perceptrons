import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

String[] imagePaths;
int index = 0;

void setup() {
  
  imagePaths = listPaths("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\VER-Imagens");
  
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
  index = 0;

  while (index < imagePaths.length - 1) {
    println(index + "/" + imagePaths.length);
    PImage img1 = loadImage(imagePaths[index]);
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

        if (!isWhite(c)) {
          if (isWhite(img1.get(x+1, y)) ||
              isWhite(img1.get(x-1, y)) ||
              isWhite(img1.get(x, y+1)) ||
              isWhite(img1.get(x, y-1))) {
            
            bordaImg.set(x, y, color(red(c), green(c), blue(c)));
          } else {
            bordaImg.set(x, y, color(255, 255, 255));
          }
        } else {
          bordaImg.set(x, y, color(255, 255, 255));
        }
      }
    }

    bordaImg.updatePixels();
    bordaImg.save("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\LIN-Imagens\\a_vm" + index + ".png");
    index++;
  }
}

boolean isWhite(color c) {
  return c == color(255, 255, 255);
}
