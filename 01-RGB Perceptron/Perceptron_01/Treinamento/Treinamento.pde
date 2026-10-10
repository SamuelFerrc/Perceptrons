import java.io.File;
import java.util.Arrays;

final int EPOCAS = 1500;
final float[] TAXAS_APRENDIZADO = {0.0001f, 0.001f, 0.01f, 0.1f};

void setup() {
  String diretorioExecucao = System.getenv("PERCEPTRON_RUN_DIR");
  String pastaExecucao = diretorioExecucao == null || trim(diretorioExecucao).length() == 0
    ? sketchPath("")
    : diretorioExecucao + File.separator + "rgb_treinamento";
  File pastaDados = new File(pastaExecucao + File.separator + "data");
  File[] arquivos = pastaDados.listFiles((dir, nome) ->
    nome.startsWith("processingSaveData_") && nome.endsWith("_.txt"));

  if (arquivos == null || arquivos.length == 0) {
    println("ERRO: nenhum arquivo de amostras foi encontrado em " + pastaDados.getAbsolutePath());
    exit();
    return;
  }

  Arrays.sort(arquivos, (a, b) -> numeroBloco(a.getName()) - numeroBloco(b.getName()));
  new File(pastaExecucao).mkdirs();
  PrintWriter pesos = createWriter(pastaExecucao + File.separator + "pesos.txt");
  PrintWriter metricas = createWriter(pastaExecucao + File.separator + "metricas.tsv");
  metricas.println("bloco\tarquivo\ttaxa_aprendizado\terro_quadratico_medio\tw1\tw2\tw3\tbias");

  for (int bloco = 0; bloco < arquivos.length; bloco++) {
    String[] linhas = loadStrings(arquivos[bloco].getAbsolutePath());
    if (linhas == null || linhas.length == 0) {
      println("AVISO: arquivo vazio ignorado: " + arquivos[bloco].getName());
      continue;
    }

    float menorErro = Float.MAX_VALUE;
    float melhorW1 = 0;
    float melhorW2 = 0;
    float melhorW3 = 0;
    float melhorBias = 0;
    float melhorTaxa = 0;

    for (float taxa : TAXAS_APRENDIZADO) {
      float w1 = 127;
      float w2 = 127;
      float w3 = 127;
      float bias = 0;
      float erroMedio = Float.MAX_VALUE;

      for (int epoca = 0; epoca < EPOCAS; epoca++) {
        float somaErros = 0;
        int validas = 0;
        for (String linha : linhas) {
          String[] valores = splitTokens(linha);
          if (valores.length < 4) continue;
          float x = Float.parseFloat(valores[0]);
          float y = Float.parseFloat(valores[1]);
          float z = Float.parseFloat(valores[2]);
          int desejado = Integer.parseInt(valores[3]);
          float soma = w1 * x + w2 * y + w3 * z + bias;
          int previsto = soma > 0 ? 1 : -1;
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

      if (erroMedio < menorErro) {
        menorErro = erroMedio;
        melhorW1 = w1;
        melhorW2 = w2;
        melhorW3 = w3;
        melhorBias = bias;
        melhorTaxa = taxa;
      }
    }

    pesos.println(melhorW1 + "\t" + melhorW2 + "\t" + melhorW3 + "\t" + melhorBias);
    metricas.println(bloco + "\t" + arquivos[bloco].getName() + "\t" + melhorTaxa + "\t" +
      menorErro + "\t" + melhorW1 + "\t" + melhorW2 + "\t" + melhorW3 + "\t" + melhorBias);
    println("Bloco " + (bloco + 1) + "/" + arquivos.length + " treinado; EQM=" + menorErro);
  }

  pesos.flush();
  pesos.close();
  metricas.flush();
  metricas.close();
  println("Treinamento RGB concluído. Pesos e métricas foram salvos no diretório do sketch.");
  exit();
}

int numeroBloco(String nome) {
  String[] partes = match(nome, "processingSaveData_([0-9]+)_\\.txt");
  return partes == null ? Integer.MAX_VALUE : Integer.parseInt(partes[1]);
}
