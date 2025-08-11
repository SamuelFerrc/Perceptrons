import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

String[] imagePaths;
int index = 0;
PrintWriter output;

void setup() {
  size(800, 600);
  
  // Carregar e ordenar corretamente as imagens
  imagePaths = listPaths("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\LIN-Imagens");
  
  if (imagePaths.length < 2) {
    println("A pasta deve conter pelo menos 2 imagens.");
    exit();
  }

  index = 0;
  while (index < imagePaths.length - 1) {
    PImage img1 = loadImage("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\LIN-Imagens\\a_vm" + index + ".png");
    PImage img2 = loadImage("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\LIN-Imagens\\a_vm" + (index+1) + ".png");
    int allPixels = 0;

    for (int i = 0; i < img1.width; i++) {
      for (int j = 0; j < img1.height; j++) {
        color c1 = img1.get(i, j);
        color c2 = img2.get(i, j);
        
        if (dist(red(c1), green(c1), blue(c1), red(c2), green(c2), blue(c2)) > 355 ) {
          img1.set(i, j, color(255, 255, 255));
          img2.set(i, j, color(255, 255, 255));
          allPixels++;
        }
      }
    }

    img1.save("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\MER-Imagens\\image" + index + ".png");
    img2.save("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\08-Resultados\\MER-Imagens\\image" + (index + 1) + ".png");
    //println(allPixels);
    println(index + "/" + imagePaths.length);
    index += 2;
  }

 
}

void draw() {}

// Função para listar os arquivos de uma pasta e ordená-los corretamente
String[] listPaths(String folder) {
  File dir = new File(dataPath(folder));
  if (dir.isDirectory()) {
    String[] files = dir.list();
    if (files != null) {
      return filterAndSortImages(files, folder);
    }
  }
  return new String[0];
}

// Função para filtrar e ordenar os arquivos corretamente
String[] filterAndSortImages(String[] files, String folder) {
  ArrayList<String> validImages = new ArrayList<>();
  Pattern pattern = Pattern.compile("image(\\d+)\\.png");  // Regex para capturar números dos arquivos
  
  for (String file : files) {
    String ext = file.substring(file.lastIndexOf('.') + 1).toLowerCase();
    if (ext.equals("jpg") || ext.equals("png") || ext.equals("jpeg")) {
      validImages.add(folder + "/" + file);
    }
  }

  // Ordenar considerando os números corretamente
  validImages.sort((a, b) -> {
    Matcher m1 = pattern.matcher(a);  
    Matcher m2 = pattern.matcher(b);
    
    if (m1.find() && m2.find()) {
      int num1 = Integer.parseInt(m1.group(1));
      int num2 = Integer.parseInt(m2.group(1));
      return Integer.compare(num1, num2);
    }
    
    return a.compareTo(b);
  });

  return validImages.toArray(new String[0]);
}
