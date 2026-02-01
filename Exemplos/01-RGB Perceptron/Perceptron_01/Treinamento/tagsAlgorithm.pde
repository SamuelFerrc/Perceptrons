import java.io.File;
import java.io.FilenameFilter;
PrintWriter output;


PImage[] imagens;
String[] listaImagens;

void setup() {
  Float x = 0.0;
  Float y = 0.0;
  Float z = 0.0;
  int c = 0;
  Float bias = 0.0;
  Float w1 = 127.0;
  Float w2 = 127.0;
  Float w3 = 127.0;
  Float s = 0.0;
  int epocas = 1500;
  int count = 0;
  String[] linhas;
  color co;

  float erro = 0;
  float entrada = 0;
  float saida = 0;
  float desejado = 0;
  float erroQuadraticoMedio = 0;


//46
  output = createWriter("pesos2.txt");
  
  for (int a =0; a < 56; a++)
  {
    println("Rodando "+a + "/55");

    linhas = loadStrings("C:\\Users\\lacer\\OneDrive\\Desktop\\DadosFalharam\\treinamento_"+a +".txt");

    float[] TAs = {0.0001f, 0.001f, 0.01f, 0.1f};
    float menorErro = Float.MAX_VALUE;
    float melhorW1 = 0, melhorW2 = 0, melhorW3 = 0, melhorBias = 0;


    for (float TA : TAs) {

      w1 = 127.0;
      w2 = 127.0;
      w3 = 127.0;
      bias = 0.0;

      int countInner = 0;
      while (countInner < epocas) {
        erroQuadraticoMedio = 0;

        for (int i = 0; i < linhas.length; i++) {
          String[] values = linhas[i].split("\\s+");
          x = Float.parseFloat(values[0]);
          y = Float.parseFloat(values[1]);
          z = Float.parseFloat(values[2]);
          c = int(values[3]);
          
          desejado = c;
          s = (w1 * x) + (w2 * y) + (w3 * z) + bias;
          saida = (s > 0) ? 1 : -1;

          erro = desejado - saida;

          if (erro != 0) {
            w1 += TA * erro * x;
            w2 += TA * erro * y;
            w3 += TA * erro * z;
            bias += TA * erro;
          }

          erroQuadraticoMedio += erro * erro;
          //if(erroQuadraticoMedio == 0) break;
        }

        countInner++;
      }

      erroQuadraticoMedio /= linhas.length;

     // println("Results for TA = " + TA + ":");
    //  println("float w1 = " + w1 + "; float w2 = " + w2 + "; float w3 = " + w3 + ";" + " float bias = " + bias + ";");
      println("Quadratic Mean Error == " + erroQuadraticoMedio);
     // println("---------------------------------------------------");

      if (erroQuadraticoMedio < menorErro) {
        menorErro = erroQuadraticoMedio;
        melhorW1 = w1;
        melhorW2 = w2;
        melhorW3 = w3;
        melhorBias = bias;
        melhorTA = TA;
      }
           output.flush();

    }
    output.println(melhorW1 + "\t" + melhorW2+ "\t" + melhorW3 + "\t"+melhorBias);
    //println("\n");
   // println("======== Melhor Resultado ========");
    //println("Imagem == " + a+"/"+arquivos.length);
   // println("TA = " + melhorTA);
   // println("float w1 = " + melhorW1 + "; float w2 = " + melhorW2 + "; float w3 = " + melhorW3 + "; float bias = " + melhorBias + ";");
   // println("Menor Erro Quadrático Médio: " + menorErro);
     output.flush();

  }
  output.flush();
  output.close();
  println("Done.");
  exit();
}
