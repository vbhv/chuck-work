// this shows how to dynamically spork shreds...

fun void foo( int a )
{
	SinOsc s => dac;
	while( true )
    {
		Std.rand2f(200.0,300.0) => s.freq;
        500::ms => now;
    }
}

spork ~ foo( 1 );
250::ms => now;
spork ~ foo( 2 );

// infinite time loop - children shreds leave with parent shred
while( true )
    1::second => now;
