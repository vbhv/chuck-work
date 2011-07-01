//starting at 200hz increment frequency of the sound by 20 every .1 second

fun void play(){
	SndBuf buf => dac;
	"../data/01.wav" => buf.read;
	0 => buf.pos;
	//.05 => buf.freq;
	//SinOsc s => dac;
	500::ms => now;
	buf =< dac;
	//s =< dac;
}

SndBuf c => dac;
"../data/01.wav" => c.read;

<<<c.length()>>>;
c.length() => dur d;
<<<now+d + 0::second>>>;

while(true){
	spork ~ play();
	<<<"hey">>>;
	now + d => now;
}