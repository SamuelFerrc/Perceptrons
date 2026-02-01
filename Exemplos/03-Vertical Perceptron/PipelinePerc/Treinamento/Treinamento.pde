PrintWriter output;

void setup() {
  int n = 0;
  Float x = 0.0;
  Float y = 0.0;
  Float z = 0.0;
  int c = 0;
  Float bias = 0.0;
  Float w1 = 127.0;
  Float w2 = 127.0;
  Float w3 = 127.0;
  Float s = 0.0;
  int epocas = 1000;
  int count = 0;
  String[] linhas;
  color co;

  float erro = 0;
  float entrada = 0;
  float saida = 0;
  float desejado = 0;
  float erroQuadraticoMedio = 0;

  linhas = loadStrings("processingSaveData.txt");
  n = linhas.length;

  float[] TAs = {0.0001f, 0.001f, 0.01f, 0.1f};

  for (float TA : TAs) {
    println("Testing with TA = " + TA);
    w1 = 127.0;
    w2 = 127.0;
    w3 = 127.0;
    bias = 127.0;
    int countInner = 0;
    while (countInner < epocas) {
      erroQuadraticoMedio = 0;

      for (int i = 0; i < min(linhas.length, 4096); i++) {
        String[] values = linhas[i].split("\\s+");
        x = Float.parseFloat(values[0]);
        y = Float.parseFloat(values[1]);
        z = Float.parseFloat(values[2]);
        c = int(values[3]);

        erro = 0;
        desejado = c;

        s = (w1 * x) + (w2 * y) + (w3 * z) + bias;
        saida = (s > 0) ? 1 : -1;

        erro = desejado - saida;

        if (erro != 0) {
          w1 = w1 + TA * erro * x;
          w2 = w2 + TA * erro * y;
          w3 = w3 + TA * erro * z;
          bias = bias + TA * erro;
        }


        erroQuadraticoMedio += erro * erro;
      }
      countInner++;
    }

    erroQuadraticoMedio /= min(linhas.length, 4096);

    println("Results for TA = " + TA + ":");
    println("float w1 = " + w1 + "; float w2 = " + w2 + "; float w3 = " + w3 + ";" + "float bias = " + bias+ ";");
    println("Quadratic Mean Error == " + erroQuadraticoMedio);
    println("---------------------------------------------------");
  }

  println("Done.");
  exit();
}
