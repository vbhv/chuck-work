Gain g => dac;
.5 => g.gain;

110 => int f;
SinOsc fundamental => g;
f => fundamental.freq;

SinOsc harmonic1 => g;
f*2 => harmonic1.freq;

SinOsc harmonic2 => g;
f*4 => harmonic2.freq;

while(true){
	1000::ms=>now;
}