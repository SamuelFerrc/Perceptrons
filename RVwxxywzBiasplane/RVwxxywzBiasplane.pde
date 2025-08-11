PrintWriter output;

void setup() {
  size(32, 32);

  float x, y, z;
  float w1 = 0.46724126;
  float w2 = -0.36980715;
  float w3 = -0.019369334;
  float bias =  -3.3597324;
  //0.46724126  -0.36980715  -0.019369334  -3.3597324



  String name = "a_vm1125";
  //String name = "a_vm1300";
  
  output = createWriter(name +"-RVwxwywzPlane.ply");
  String head = "";
  head = "ply";
  head += "\nformat ascii 1.0";
  head += "\ncomment";
  head += "\nelement vertex 2461184";
  head += "\nproperty float x";
  head += "\nproperty float y";
  head += "\nproperty float z";
  head += "\nproperty uchar red";
  head += "\nproperty uchar green";
  head += "\nproperty uchar blue";
  head += "\nend_header";
  output.println(head);


  for (int i=0; i<2048; i++) {
    for (int j=0; j<1216; j++) {
      x = float(i);
      y = float(j);
      z = (w1*x + w2*y + bias)/w3;
      output.println(x + "\t" + y + "\t" + z + "\t0\t255\t255");
    }//end-for-j
  }//end-for-i

  output.flush();
  output.close();

  println("Done.");
  exit();
}
