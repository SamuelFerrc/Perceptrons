import java.io.File;

final int TOTAL_AMOSTRAS = 4096;
final int DISTANCIA_LIMITE = 250;
final int SEMENTE = 202408;

void setup() {
  size(400, 400);
  PImage imagem = loadImage("data/img.png");
  if (imagem == null) {
    println("ERRO: imagem de referência não encontrada em " + sketchPath("data/img.png"));
    exit();
    return;
  }

  File pastaSaida = new File(sketchPath("../Treinamento/data"));
  pastaSaida.mkdirs();
  PrintWriter saida = createWriter(pastaSaida.getAbsolutePath() + File.separator +
    "processingSaveData.txt");
  randomSeed(SEMENTE);

  int positivos = 0;
  int negativos = 0;
  int tentativas = 0;
  int limiteTentativas = TOTAL_AMOSTRAS * 1000;
  while (positivos + negativos < TOTAL_AMOSTRAS && tentativas < limiteTentativas) {
    tentativas++;
    int x = int(random(imagem.width));
    int y = int(random(imagem.height));
    float distancia = abs(y - (imagem.height / 2.0f - 200));
    if (distancia > DISTANCIA_LIMITE && negativos < TOTAL_AMOSTRAS / 2) {
      negativos++;
      saida.println(x + "\t" + y + "\t" + distancia + "\t-1");
    } else if (distancia <= DISTANCIA_LIMITE && positivos < TOTAL_AMOSTRAS / 2) {
      positivos++;
      saida.println(x + "\t" + y + "\t" + distancia + "\t+1");
    }
  }

  saida.flush();
  saida.close();
  if (positivos + negativos != TOTAL_AMOSTRAS) {
    println("ERRO: não foi possível obter 2048 exemplos de cada classe.");
  } else {
    println("Amostragem histórica vertical concluída: 2048 positivos e 2048 negativos.");
  }
  exit();
}
