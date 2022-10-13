
This is a PoC for how to make client-side rhythmic stuff. This mod adds a spinning
wheel (or not actually a spinning wheel, idk how this thing is named) that you can
punch to get a message on whether you landed in the red, yellow or green area.

Use the entity spawner in devtest to spawn the spinning wheel ("ent1").


How it works:

The spinning wheel has an animation with 4 bones. One bone just rotates the needle.
The other 3 bones are for the red, yellow and green areas. Each of these 3 bones
is always in the back of the spinning wheel, except when the needle is in the
respective area, in which case the bone is half a node nearer to the front.
In minetest, we attach an object to each of these 3 bones. The player will punch
the one in the front, which depends on the client-side animation timer.


Issues:

The selection box is blinking whenever the needle crosses area boarders. I've already
set the animation interpolation to constant. I guess this is an engine limitation.


License:

CC0 (by DS)
