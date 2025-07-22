import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Comparator;

void setup() {
  File folder = new File(dataPath("C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\Cleaner\\output"));
  File[] files = folder.listFiles();

  if (files == null) {
    println("Nenhum arquivo encontrado.");
    exit();
  }

  // Ordena os arquivos numericamente com base no número no nome do arquivo
  Arrays.sort(files, new Comparator<File>() {
    public int compare(File f1, File f2) {
      String name1 = f1.getName().replaceAll("\\D+", ""); // remove não números
      String name2 = f2.getName().replaceAll("\\D+", "");
      try {
        return Integer.compare(Integer.parseInt(name1), Integer.parseInt(name2));
      } catch (NumberFormatException e) {
        return f1.getName().compareTo(f2.getName()); // fallback alfabético
      }
    }
  });

  int i = 0;
  for (File file : files) {
    if (file.isFile() && file.getName().toLowerCase().endsWith(".png")) {
      println("Convertendo: " + file.getName());
      convertImageToPLY(file.getAbsolutePath(), file.getName() + ".ply", i);
      i++;
    }
  }

  println("Conversão concluída.");
  exit();
}



void convertImageToPLY(String imagePath, String outputPLYName,int i) {
  PImage img = loadImage(imagePath);
  img.loadPixels();

  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> rgb = new ArrayList<PVector>();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.pixels[y * img.width + x];
      if(c == color(255,255,255))continue;
      float brightness = brightness(c); // 0-255
      points.add(new PVector(x, y, i));
      rgb.add(new PVector(red(c), green(c), blue(c)));
    }
  }

  savePLY(points,rgb, outputPLYName);
}

void savePLY(ArrayList<PVector> points, ArrayList<PVector> rgb, String filename) {
  PrintWriter output = createWriter("PLYS/"+filename);
  
  output.println("ply");
  output.println("format ascii 1.0");
  output.println("element vertex " + points.size());
  output.println("property float x");
  output.println("property float y");
  output.println("property float z");
  output.println("property uchar red");
  output.println("property uchar green");
  output.println("property uchar blue");
  output.println("end_header");
  
  for(int i = 0 ; i < points.size(); i++)
  {
        output.println(points.get(i).x + "\t" +points.get(i).y + "\t" + points.get(i).z + "\t" + (int)rgb.get(i).x+"\t" + (int)rgb.get(i).y+"\t"+(int)rgb.get(i).z);

  }
  

  output.flush();
  output.close();
}
