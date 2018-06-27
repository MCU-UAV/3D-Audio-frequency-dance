import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioInput in;
FFT         fft;


float[] pos = new float[513];
void setup()
{
  colorMode(HSB, 360, 255, 100);
  size(520, 320, P3D);
  
  minim = new Minim(this);

  in = minim.getLineIn();

  fft = new FFT( in.bufferSize(), in.sampleRate() );
}
final int step = 60;
final float temp = 513/step;

void draw()
{
  background(0,0,12);
  changeCamera();
  
  stroke(125,0,100);
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 0, 20+ in.right.get(i)*50 + in.left.get(i)*50, i+1, 0, 20 + in.right.get(i+1)*50 + in.left.get(i+1)*50);
  }
  noStroke();
  fft.forward( in.mix );
  for (int i = 0; i < 513; i+=temp)
  {
    
    fill(map(i, 0, 450, 0, 280), 150, 100);
    translate(0, i+temp, fft.getBand(i)*8);
    stroke(0, 0, 100);
    box(temp, temp, fft.getBand(i)*16);         
    noStroke();
    translate(0, 0, -fft.getBand(i)*8);
    // rect(i,height,width/step,-fft.getBand(i)*16 );
    float[] v = new float[513];
    float[] x=new float[513];
    if (pos[i] <  fft.getBand(i)*16 +temp/6)
    {
      v[i]=2;
       x[i]=0.0;
      pos[i] =  fft.getBand(i)*16;
    } else
    {
      v[i]+=fft.getBand(i)*16 - pos[i];
      x[i]+=v[i];
      //pos[i] = pos[i] + (fft.getBand(i)*16 - pos[i])*0.1;
      pos[i]=pos[i]+(x[i] - pos[i])*0.1;
    }
    stroke(190, 255, 100);
    noFill();//190,255,100
    translate(0, 0, pos[i]+temp/6);
    box(temp, temp, temp/3);
    translate(0, -i-temp, -pos[i]-temp/6);
    float omega=TWO_PI/10000;
    for(int j = 0; j < in.bufferSize() - 1; j++)
    {
      if (i==0){
       line(j, temp, 20 , j+500, temp, 20 );
     
   }
       else
      line(j, i+temp, 20 + fft.getBand(i)*sin(i*j/(omega)), j+1, i+temp, 20 + fft.getBand(i)*sin(i*(j+1)/(omega)));
    }
  }
}
