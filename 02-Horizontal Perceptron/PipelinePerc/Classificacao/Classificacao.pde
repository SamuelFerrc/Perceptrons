import java.io.File;
import java.util.Arrays;

void setup() {
  size(1, 1);
  String raizResultados = caminhoAmbiente("PERCEPTRON_RESULTADOS_DIR", sketchPath("../../../Resultados"));
  String pastaEntrada = raizResultados + File.separator + "RGB-Imagens";
  String pastaSaida = raizResultados + File.separator + "HOR-Imagens";
  String[] configuracao = primeiraLinhaValida(loadStrings("configuracao.tsv"));
  if (configuracao == null || configuracao.length < 5) {
    println("ERRO: configuração inválida em " + sketchPath("configuracao.tsv"));
    exit();
    return;
  }

  float w1 = Float.parseFloat(configuracao[0]);
  float w2 = Float.parseFloat(configuracao[1]);
  float w3 = Float.parseFloat(configuracao[2]);
  float bias = Float.parseFloat(configuracao[3]);
  float deslocamento = Float.parseFloat(configuracao[4]);
  File[] imagens = new File(pastaEntrada).listFiles((dir, nome) -> ehImagem(nome));
  if (imagens == null || imagens.length == 0) {
    println("ERRO: nenhuma imagem encontrada em " + pastaEntrada);
    exit();
    return;
  }

  Arrays.sort(imagens, (a, b) -> a.getName().compareToIgnoreCase(b.getName()));
  new File(pastaSaida).mkdirs();
  for (int indice = 0; indice < imagens.length; indice++) {
    PImage imagem = loadImage(imagens[indice].getAbsolutePath());
    if (imagem == null) continue;
    imagem.loadPixels();
    for (int y = 0; y < imagem.height; y++) {
      for (int x = 0; x < imagem.width; x++) {
        int p = y * imagem.width + x;
        color pixel = imagem.pixels[p];
        if (red(pixel) == 255 && green(pixel) == 0 && blue(pixel) == 0) {
          imagem.pixels[p] = color(255);
        }
        float distancia = abs(y - imagem.height / 2.0f - deslocamento);
        float soma = w1 * x + w2 * y + w3 * distancia + bias;
        if (soma < 0) imagem.pixels[p] = color(255, 0, 0);
      }
    }
    imagem.updatePixels();
    imagem.save(pastaSaida + File.separator + semExtensao(imagens[indice].getName()) + ".png");
    println((indice + 1) + "/" + imagens.length + ": " + imagens[indice].getName());
  }

  println("Filtro horizontal concluído. Saída: " + pastaSaida);
  exit();
}

String[] primeiraLinhaValida(String[] linhas) {
  if (linhas == null) return null;
  for (String linha : linhas) {
    String limpa = trim(linha);
    if (limpa.length() > 0 && !limpa.startsWith("#")) return splitTokens(limpa);
  }
  return null;
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
