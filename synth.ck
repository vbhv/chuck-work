SinOsc s => Gain g => Delay echo => dac;
//Gain g => echo;
400::ms => echo.delay;
echo => Gain g2 => echo;
.1 => g.gain;
.6 => g2.gain;
[2,3,5,7,9,11] @=> int scale[];

while (true) {
	
	for(0=>int i; i < scale.cap(); i++) {
		scale[i] * 330 => s.freq;
		500::ms => now;
	}
	
}