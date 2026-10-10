import java.io.File;
import java.util.Arrays;

final int TAMANHO_BLOCO = 50;
final int AMOSTRAS_POR_BLOCO = 4096;
final int DISTANCIA_RGB = 16;
final int SEMENTE = 202408;

void setup() {
  String pastaEntrada = caminhoAmbiente("PERCEPTRON_INPUT_DIR", sketchPath("data/VisibleData"));
  String diretorioExecucao = System.getenv("PERCEPTRON_RUN_DIR");
  String pastaSaida = diretorioExecucao == null || trim(diretorioExecucao).length() == 0
    ? sketchPath("../Treinamento/data")
    : diretorioExecucao + File.separator + "rgb_treinamento" + File.separator + "data";

  File diretorioEntrada = new File(pastaEntrada);
  File[] imagens = diretorioEntrada.listFiles((dir, nome) -> ehImagem(nome));
  if (imagens == null || imagens.length == 0) {
    println("ERRO: nenhuma imagem encontrada em " + pastaEntrada);
    exit();
    return;
  }

  Arrays.sort(imagens, (a, b) -> a.getName().compareToIgnoreCase(b.getName()));
  new File(pastaSaida).mkdirs();
  randomSeed(SEMENTE);

  int totalBlocos = ceil(imagens.length / float(TAMANHO_BLOCO));
  for (int bloco = 0; bloco < totalBlocos; bloco++) {
    String caminhoSaida = pastaSaida + File.separator +
      "processingSaveData_" + bloco + "_.txt";
    PrintWriter saida = createWriter(caminhoSaida);
    int negativos = 0;
    int positivos = 0;

    int inicio = bloco * TAMANHO_BLOCO;
    int fim = min((bloco + 1) * TAMANHO_BLOCO, imagens.length);
    for (int indice = inicio; indice < fim && negativos + positivos < AMOSTRAS_POR_BLOCO; indice++) {
      PImage imagem = loadImage(imagens[indice].getAbsolutePath());
      if (imagem == null) {
        println("AVISO: não foi possível carregar " + imagens[indice].getName());
        continue;
      }

      int tentativas = 0;
      int limiteTentativas = AMOSTRAS_POR_BLOCO * 100;
      while (negativos + positivos < AMOSTRAS_POR_BLOCO && tentativas < limiteTentativas) {
        tentativas++;
        int x = int(random(imagem.width));
        int y = int(random(imagem.height));
        color pixel = imagem.get(x, y);
        float r = red(pixel);
        float g = green(pixel);
        float b = blue(pixel);
        float distancia = dist(r, g, b, 0, 6, 23);

        if (distancia < DISTANCIA_RGB && negativos < AMOSTRAS_POR_BLOCO / 2) {
          negativos++;
          saida.println(r + "\t" + g + "\t" + b + "\t-1");
        } else if (distancia >= DISTANCIA_RGB && positivos < AMOSTRAS_POR_BLOCO / 2) {
          positivos++;
          saida.println(r + "\t" + g + "\t" + b + "\t+1");
        }
      }
    }

    saida.flush();
    saida.close();
    int total = negativos + positivos;
    if (total != AMOSTRAS_POR_BLOCO) {
      new File(caminhoSaida).delete();
      println("ERRO: o bloco " + bloco + " não produziu uma amostra balanceada. " +
        "Foram obtidas " + negativos + " amostras negativas e " + positivos + " positivas.");
    } else {
      println("Bloco " + bloco + " concluído: " + total + " amostras balanceadas.");
    }
  }

  println("Amostragem RGB concluída.");
  exit();
}

boolean ehImagem(String nome) {
  String minusculo = nome.toLowerCase();
  return minusculo.endsWith(".png") || minusculo.endsWith(".jpg") ||
    minusculo.endsWith(".jpeg");
}

String caminhoAmbiente(String nome, String padrao) {
  String valor = System.getenv(nome);
  return valor == null || trim(valor).length() == 0 ? padrao : valor;
}
