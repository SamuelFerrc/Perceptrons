import java.io.File;
import java.util.Arrays;
import java.util.Comparator;

int bloco = 25;
float limiar = 0.98;
String pastaEntrada = "C:\\Users\\lacer\\OneDrive\\Desktop\\Perceptrons\\Perceptrons\\SkinGet\\Images";
String pastaSaida = "output";

void setup() {
  size(100, 100); // Tamanho do sketch (não usado)

  File[] arquivos = listarArquivosOrdenados(pastaEntrada);
  println("Total de arquivos: " + arquivos.length);

  for (File arquivo : arquivos) {
    String nome = arquivo.getName();
    if (nome.toLowerCase().endsWith(".jpg") || nome.toLowerCase().endsWith(".png")) {
      PImage img = loadImage(pastaEntrada + "/" + nome);
      if (img != null) {
        println("Processando: " + nome);
        processarImagem(img);
        salvarImagem(img, nome);
      }
    }
  }

  println("Concluído.");
  exit();
}

File[] listarArquivosOrdenados(String pasta) {
  File dir = new File(dataPath(pasta));
  File[] arquivos = dir.listFiles();

  Arrays.sort(arquivos, new Comparator<File>() {
    public int compare(File f1, File f2) {
      return Long.compare(f1.lastModified(), f2.lastModified()); // mais antigos primeiro
      // para mais recentes primeiro: troque para: Long.compare(f2.lastModified(), f1.lastModified());
    }
  });

  return arquivos;
}

void processarImagem(PImage img) {
  img.loadPixels();

  for (int y = 0; y < img.height; y += bloco) {
    for (int x = 0; x < img.width; x += bloco) {
      limparBlocoSeBranco(img, x, y);
    }
  }

  img.updatePixels();
}

void limparBlocoSeBranco(PImage img, int startX, int startY) {
  int brancoCount = 0;
  int totalPixels = bloco * bloco;

  for (int y = startY; y < startY + bloco && y < img.height; y++) {
    for (int x = startX; x < startX + bloco && x < img.width; x++) {
      color c = img.get(x, y);
      //float brilho = brightness(c);
      if(c == color(255)) {
        brancoCount++;
      }
    }
  }

  if ((float)brancoCount / totalPixels > limiar) {
    for (int y = startY; y < startY + bloco && y < img.height; y++) {
      for (int x = startX; x < startX + bloco && x < img.width; x++) {
        img.set(x, y, color(255)); // zera (preto)
      }
    }
  }
}

void salvarImagem(PImage img, String nomeOriginal) {
  img.save(pastaSaida + "/" + nomeOriginal); // salva com o mesmo nome
}
