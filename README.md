# fpg-remux
My ffmpeg wrapper for remuxing files on bash

Since I use ffmpeg to transcode movie files constantly, I got tired of making aliases and having to type all the options I usually use for my transcodes. I made this little wrapper to make my life easier.

- Keep in mind that you must have ffmpeg installed on your system, maybe on your /usr/local/bin if you are using linux so that you can access the binary by just typing its name on the terminal.
- I use libfdk_aac for audio, you might need to compiled ffmpeg yourself to include that library on your binary.
- The add subtitle function is coded for spanish, if you want another language you need to change "language=spa" to whatever language you usually use. Or maybe just remove it if you don't actually use subs with your movie files.

Have fun!
