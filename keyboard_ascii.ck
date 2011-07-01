/*----------------------------------------------------------------------------
    S.M.E.L.T. : Small Musically Expressive Laptop Toolkit

    Copyright (c) 2007 Rebecca Fiebrink and Ge Wang.  All rights reserved.
      http://smelt.cs.princeton.edu/
      http://soundlab.cs.princeton.edu/

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
    U.S.A.
-----------------------------------------------------------------------------*/

//-----------------------------------------------------------------------------
// name: kb-ascii.ck
// desc: typing-based thing, quantized
//
// author: Rebecca Fiebrink and Ge Wang
//
// to run (in command line chuck):
//     %> chuck kb-ascii.ck
//     (make sure terminal has focus in order to receive keyboard events)
//
// to run (in miniAudicle):
//     (you can't, as of yet due to KBHit incompatibility)
//-----------------------------------------------------------------------------

// computer keyboard input via terminal
KBHit kb;

// minimum duration between clicks
4096::samp => dur T;

// patch
Impulse i => BiQuad f => Envelope e => JCRev r => dac;

// set the filter's pole radius
.99 => f.prad;
// set equal gain zeros
1 => f.eqzs;
// envelope rise/fall time
1::ms => e.duration;
// reverb mix
.02 => r.mix;

// time-loop
while( true )
{
    // wait on event
    kb => now;

    // loop through 1 or more keys
    while( kb.more() )
    {
        // get key...
        kb.getchar() => int c;

        // set filtre freq
        c => Std.mtof => f.pfreq;
        // print int value
        <<< "ascii:", c >>>;

        // fire an impulse
        1.0 => i.next;
        // open
        e.keyOn();
        // advance time
        T-2::ms => now;
        // close
        e.keyOff();
    }
}