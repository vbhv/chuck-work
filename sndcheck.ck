SndBuf s1 => dac;
SndBuf s2 => dac;

0 => s2.gain; //turn down the gain of 2 so you can hear the click

"../data/snare-chili.wav" => s1.read;

1::second => now;

"../data/kick.wav" => s2.read;

2::second => now;