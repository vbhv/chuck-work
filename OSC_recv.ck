// (launch with OSC_send.ck)

// create our OSC receiver
OscRecv recv;
// use port 6449
6449 => recv.port;
// start listening (launch thread)
recv.listen();
// create an address in the receiver, store in new variable
recv.event( "/sndbuf/buf/rate, f" ) @=> OscEvent oe;

Chorus ch => JCRev rev => Gain g => dac;
0.5 => g.gain;
0.04 => rev.mix;


fun void play(float msg) 
{

	SndBuf buf => ch;
	"../data/02.wav" => buf.read;
	
	//pos is selected random between 0 and max samples
	buf.samples() => int maxsamples;
	Std.rand2(0,maxsamples) => buf.pos;	
	msg::ms => now;
	30::ms => now;
	
	//advance time to whatever the length of the sample is
	//0 => buf.pos;
	//buf.length() => now;
	
	//disconnect sample after playing
	buf =< ch;

}

// infinite event loop
while ( true )
{
    // wait for event to arrive
    oe => now;

    // grab the next message from the queue. 
    while ( oe.nextMsg() != 0 )
    { 
        // getFloat fetches the expected float (as indicated by "f")
		// dt is the time between the current tweet and the previous tweet in milliseconds
		oe.getFloat() => float dt;
		
		//<<<"hey",dt>>>;
		//spork new samples. do something with msg?
		spork ~ play(dt);
    }
}
