import java.io.File;
import java.util.Arrays;

final int IMAGENS_POR_BLOCO = 50;

void setup() {
  size(1, 1);

  String pastaEntrada = caminhoAmbiente("PERCEPTRON_INPUT_DIR", sketchPath("../Amostras/data/VisibleData"));
  String raizResultados = caminhoAmbiente("PERCEPTRON_RESULTADOS_DIR", sketchPath("../../../Resultados"));
  String diretorioExecucao = System.getenv("PERCEPTRON_RUN_DIR");
  String pastaSaida = raizResultados + File.separator + "RGB-Imagens";
  String arquivoPesos = diretorioExecucao == null || trim(diretorioExecucao).length() == 0
    ? sketchPath("../Treinamento/pesos.txt")
    : diretorioExecucao + File.separator + "rgb_treinamento" + File.separator + "pesos.txt";
  File[] imagens = new File(pastaEntrada).listFiles((dir, nome) -> ehImagem(nome));
  String[] linhasPesos = loadStrings(arquivoPesos);

  if (imagens == null || imagens.length == 0) {
    println("ERRO: nenhuma imagem encontrada em " + pastaEntrada);
    exit();
    return;
  }
  if (linhasPesos == null || linhasPesos.length == 0) {
    println("ERRO: pesos não encontrados em " + arquivoPesos);
    exit();
    return;
  }

  Arrays.sort(imagens, (a, b) -> a.getName().compareToIgnoreCase(b.getName()));
  new File(pastaSaida).mkdirs();

  for (int indice = 0; indice < imagens.length; indice++) {
    int bloco = min(indice / IMAGENS_POR_BLOCO, linhasPesos.length - 1);
    String[] valores = splitTokens(linhasPesos[bloco]);
    if (valores.length < 4) {
      println("ERRO: linha de pesos inválida para o bloco " + bloco);
      exit();
      return;
    }
    float w1 = Float.parseFloat(valores[0]);
    float w2 = Float.parseFloat(valores[1]);
    float w3 = Float.parseFloat(valores[2]);
    float bias = Float.parseFloat(valores[3]);

    PImage original = loadImage(imagens[indice].getAbsolutePath());
    PImage positiva = loadImage(imagens[indice].getAbsolutePath());
    if (original == null || positiva == null) {
      println("AVISO: não foi possível carregar " + imagens[indice].getName());
      continue;
    }

    original.loadPixels();
    positiva.loadPixels();
    for (int p = 0; p < original.pixels.length; p++) {
      color pixel = original.pixels[p];
      float soma = w1 * red(pixel) + w2 * green(pixel) + w3 * blue(pixel) + bias;
      if (soma <= 0) positiva.pixels[p] = color(255);
    }
    positiva.updatePixels();

    String base = semExtensao(imagens[indice].getName());
    positiva.save(pastaSaida + File.separator + base + "_P.png");
    println((indice + 1) + "/" + imagens.length + ": " + imagens[indice].getName());
  }

  println("Classificação RGB concluída. Saída: " + pastaSaida);
  exit();
}

boolean ehImagem(String nome) {
  String minusculo = nome.toLowerCase();
  return minusculo.endsWith(".png") || minusculo.endsWith(".jpg") ||
    minusculo.endsWith(".jpeg");
}

String semExtensao(String nome) {
  int ponto = nome.lastIndexOf('.');
  return ponto > 0 ? nome.substring(0, ponto) : nome;
}

String caminhoAmbiente(String nome, String padrao) {
  String valor = System.getenv(nome);
  return valor == null || trim(valor).length() == 0 ? padrao : valor;
}
