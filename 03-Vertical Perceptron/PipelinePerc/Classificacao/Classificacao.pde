import java.io.File;
import java.util.Arrays;

void setup() {
  size(1, 1);
  String raizResultados = caminhoAmbiente("PERCEPTRON_RESULTADOS_DIR", sketchPath("../../../Resultados"));
  String pastaEntrada = raizResultados + File.separator + "HOR-Imagens";
  String pastaSaida = raizResultados + File.separator + "VER-Imagens";
  String[] linhas = loadStrings("configuracao.txt");
  if (linhas == null || linhas.length == 0) {
    println("ERRO: configuração do filtro vertical não encontrada.");
    exit();
    return;
  }
  float limiar = Float.parseFloat(trim(linhas[0]));

  File[] imagens = new File(pastaEntrada).listFiles((dir, nome) -> ehImagem(nome));
  if (imagens == null || imagens.length == 0) {
    println("ERRO: nenhuma imagem encontrada em " + pastaEntrada);
    exit();
    return;
  }

  Arrays.sort(imagens, (a, b) -> a.getName().compareToIgnoreCase(b.getName()));
  new File(pastaSaida).mkdirs();
  int totalProcessar = imagens.length;
  String limiteAmbiente = System.getenv("PERCEPTRON_LIMITE_IMAGENS");
  if (limiteAmbiente != null && trim(limiteAmbiente).length() > 0) {
    totalProcessar = min(imagens.length, max(1, Integer.parseInt(trim(limiteAmbiente))));
  }
  for (int indice = 0; indice < totalProcessar; indice++) {
    PImage imagem = loadImage(imagens[indice].getAbsolutePath());
    if (imagem == null) continue;
    imagem.loadPixels();
    for (int y = 0; y < imagem.height; y++) {
      for (int x = 0; x < imagem.width; x++) {
        float distanciaHorizontal = abs(x - imagem.width / 2.0f);
        if (distanciaHorizontal > limiar) {
          imagem.pixels[y * imagem.width + x] = color(255, 0, 0);
        }
      }
    }
    imagem.updatePixels();
    imagem.save(pastaSaida + File.separator + semExtensao(imagens[indice].getName()) + "_P.png");
    println((indice + 1) + "/" + totalProcessar + ": " + imagens[indice].getName());
  }

  println("Filtro vertical heurístico concluído. Saída: " + pastaSaida);
  exit();
}

boolean ehImagem(String nome) {
  String n = nome.toLowerCase();
  return n.endsWith(".png") || n.endsWith(".jpg") || n.endsWith(".jpeg");
}

String semExtensao(String nome) {
  int ponto = nome.lastIndexOf('.');
  return ponto > 0 ? nome.substring(0, ponto) : nome;
}

String caminhoAmbiente(String nome, String padrao) {
  String valor = System.getenv(nome);
  return valor == null || trim(valor).length() == 0 ? padrao : valor;
}
