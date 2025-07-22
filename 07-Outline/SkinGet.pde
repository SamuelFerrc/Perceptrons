import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

String[] imagePaths;
int index = 0;
PrintWriter output;

void setup() {
  size(800, 600);
  
  // Carregar e ordenar corretamente as imagens
  imagePaths = listPaths("C:\\Users\\lacer\\OneDrive\\Desktop\\2Heads");
  
  if (imagePaths.length < 2) {
    println("A pasta deve conter pelo menos 2 imagens.");
    exit();
  }

  index = 0;
  
  while (index < imagePaths.length - 1) {
    //println(index);
    PImage img1 = loadImage(imagePaths[index]);
    
    for(int i =0 ; i < img1.width;i++)
    {
       for(int j = 0 ; j < img1.height;j++)
       {
         if(img1.get(i,j) == color(255,0,0))img1.set(i,j,color(255,255,255));
       }
    }
    for(int i =1 ; i < img1.width -2 ;i += 3)
    {
      for(int j = 1 ; j < img1.height - 2;j+=3)
      {
        
         color c1 = img1.get(i,j);
         color c2 = img1.get(i+1,j);
         color c3 = img1.get(i-1,j);
         color c4 = img1.get(i,j+1);
         color c5 = img1.get(i+1,j-1);
         color c6 = img1.get(i-1,j-1);
         color c7 = img1.get(i,j+1);
         color c8 = img1.get(i+1,j+1);
         color c9 = img1.get(i-1,j+1);
         
         if(isWhite(c1) || isWhite(c2  ) || isWhite(c3) || isWhite(c4) || isWhite(c5) || isWhite(c6) || isWhite(c7) || isWhite(c8) || isWhite(c9))
         {
           
           
         }
         else 
         {
           img1.set(i,j,  color(255,255,255));
           img1.set(i+1,j,color(255,255,255));
           img1.set(i-1,j,color(255,255,255));
           img1.set(i,j+1,  color(255,255,255));
           img1.set(i+1,j+1,color(255,255,255));
           img1.set(i-1,j+1,color(255,255,255));
           img1.set(i,j-1,  color(255,255,255));
           img1.set(i+1,j-1,color(255,255,255));
           img1.set(i-1,j-1,color(255,255,255));
         }
         
         
      }
    }
    img1.save("/Images/Image" + index + ".png");
    index++;
  }
}

Boolean isWhite(color c)
{
  return c == color(255,255,255) || c == color(255,0,0);
}
