PImage img;
PImage out;

void setup()
{
  size(0,0);

  for (float r = 2.0; r <= 2.0; r += 0.1)
  {
    for (float s = 1.9; s <= 1.9; s += 0.1)
    {
      for (float h = 0.0; h <= 0; h += 5)
      {
        img = loadImage("a_vm1391_P.png");

        // Remove pixels vermelhos
        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            if (img.get(i, j) == color(255, 0, 0))
            {
              img.set(i, j, color(255, 255, 255));
            }
          }
        }

        // ------------------------------------------------------
        // CÁLCULO DA MÉDIA
        // ------------------------------------------------------
        float sumX = 0;
        float sumY = 0;
        int count = 0;

        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            color c = img.get(i, j);
            if ((red(c) == 255 && green(c) == 0 && blue(c) == 0) ||
                (red(c) == 255 && green(c) == 255 && blue(c) == 255))
              continue;

            sumX += i;
            sumY += j;
            count++;
          }
        }

        float mX = sumX / count;
        float mY = sumY / count;

        // ------------------------------------------------------
        // CÁLCULO DA VARIÂNCIA
        // ------------------------------------------------------
        float sumVarX = 0;
        float sumVarY = 0;

        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            color c = img.get(i, j);
            if ((red(c) == 255 && green(c) == 0 && blue(c) == 0) ||
                (red(c) == 255 && green(c) == 255 && blue(c) == 255))
              continue;

            sumVarX += pow(i - mX, 2);
            sumVarY += pow(j - mY, 2);
          }
        }

        float varX = sqrt(sumVarX / count);
        float varY = sqrt(sumVarY / count);

        // ------------------------------------------------------
        // NOVA MÉDIA DENTRO DA ELIPSE
        // ------------------------------------------------------
        float sumNX = 0;
        float sumNY = 0;
        int countN = 0;

        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            float el = pow((i - mX) / (r * varX), 2) +
                       pow((j - (mY - h)) / (s * varY), 2);

            if (el <= 1)
            {
              sumNX += i;
              sumNY += j;
              countN++;
            }
          }
        }

        float nMX = sumNX / countN;
        float nMY = sumNY / countN;

        // ------------------------------------------------------
        // NOVA VARIÂNCIA DENTRO DA ELIPSE
        // ------------------------------------------------------
        float sumNVarX = 0;
        float sumNVarY = 0;

        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            float el = pow((i - mX) / (r * varX), 2) +
                       pow((j - (mY - h)) / (s * varY), 2);

            if (el <= 1)
            {
              sumNVarX += pow(i - nMX, 2);
              sumNVarY += pow(j - nMY, 2);
            }
          }
        }

        float nvarX = sqrt(sumNVarX / countN);
        float nvarY = sqrt(sumNVarY / countN);

        // ------------------------------------------------------
        // DESENHAR A NOVA ELIPSE
        // ------------------------------------------------------
        println(nMX, nMY);
        for (int i = 0; i < img.width; i++)
        {
          for (int j = 0; j < img.height; j++)
          {
            float el = pow((i - nMX) / (r * nvarX), 2) +
                       pow((j - (nMY + h)) / (s * nvarY), 2);

            if (el <= 1)
            {
               
            }
            else
            {
              img.set(i, j, color(255, 255, 255));
            }

            if (el >= 0.95 && el <= 1.0)
            {
              img.set(i, j, color(255, 0, 0));
            }
          }
        }

        img.updatePixels();

        img.save("Torax/ElipseHeightCentro/a_vm_elipse_centro" + (1391) +
                 "_r==" + r + "_s==" + s + "_h==" + h + ".png");

        image(img, 0, 0);
      }
    }
  }

  exit();
}
