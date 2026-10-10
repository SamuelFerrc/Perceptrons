final int EPOCAS = 1000;
final float[] TAXAS_APRENDIZADO = {0.0001f, 0.001f, 0.01f, 0.1f};

void setup() {
  String caminhoDados = sketchPath("data/processingSaveData.txt");
  String[] linhas = loadStrings(caminhoDados);
  if (linhas == null || linhas.length == 0) {
    println("ERRO: amostras não encontradas em " + caminhoDados);
    exit();
    return;
  }

  PrintWriter pesos = createWriter("pesos_treinados.tsv");
  pesos.println("taxa_aprendizado\terro_quadratico_medio\tw1\tw2\tw3\tbias");
  float menorErro = Float.MAX_VALUE;
  String melhorLinha = "";

  for (float taxa : TAXAS_APRENDIZADO) {
    float w1 = 127;
    float w2 = 127;
    float w3 = 127;
    float bias = 127;
    float erroMedio = Float.MAX_VALUE;

    for (int epoca = 0; epoca < EPOCAS; epoca++) {
      float somaErros = 0;
      int validas = 0;
      for (int i = 0; i < min(linhas.length, 4096); i++) {
        String[] valores = splitTokens(linhas[i]);
        if (valores.length < 4) continue;
        float x = Float.parseFloat(valores[0]);
        float y = Float.parseFloat(valores[1]);
        float z = Float.parseFloat(valores[2]);
        int desejado = Integer.parseInt(valores[3]);
        int previsto = w1 * x + w2 * y + w3 * z + bias > 0 ? 1 : -1;
        float erro = desejado - previsto;
        if (erro != 0) {
          w1 += taxa * erro * x;
          w2 += taxa * erro * y;
          w3 += taxa * erro * z;
          bias += taxa * erro;
        }
        somaErros += erro * erro;
        validas++;
      }
      if (validas == 0) break;
      erroMedio = somaErros / validas;
    }

    String linha = taxa + "\t" + erroMedio + "\t" + w1 + "\t" + w2 + "\t" + w3 + "\t" + bias;
    pesos.println(linha);
    if (erroMedio < menorErro) {
      menorErro = erroMedio;
      melhorLinha = linha;
    }
  }

  pesos.println("# melhor_resultado");
  pesos.println(melhorLinha);
  pesos.flush();
  pesos.close();
  println("Treinamento histórico horizontal concluído; resultados salvos em pesos_treinados.tsv.");
  exit();
}
