# fpg-remux
My ffmpeg wrapper for remuxing files on bash

Since I use ffmpeg to transcode movie files constantly, I got tired of making aliases and having to type all the options I usually use for my transcodes. I made this little wrapper to make my life easier.

- Keep in mind that you must have ffmpeg installed on your system, maybe on your `/usr/local/bin` if you are using linux so that you can access the binary by just typing its name on the terminal.
- I use libfdk_aac for audio, you might need to compiled ffmpeg yourself to include that library on your binary.
- Since I mostly watch my movies on a 2.1 setup or on my bluetooth headphones, the audio streams are set to be encoded using Dolby Pro Logic II. If you have a multichannel setup you might want to change the audio encoding settings and skip DPII in favor of a 5.1 setup.
- The add subtitle function is coded for spanish, if you want another language you need to change `language=spa` to whatever language you usually use. Or maybe just remove it if you don't actually use subs with your movie files.

# Usage
```
Usage: fpg-remux [-i file] [-s subtitle] [-t title] [-o output]
   or: fpg-remux [-i file] [-t title] [-o output]
   or: fpg-remux [-i file] [-s subtitle] [-o output]
   or: fpg-remux [-i file] [-a] [-s subtitle] [-o output]
   or: fpg-remux [-i file] [-o output]

    -i, --input	File to be transcoded
    -s, --sub	Subtitle file
    -t, --title	Media title tag
    -a, --add 	Add subtitle file only
    -o, --output	Output file
```    
Have fun!
