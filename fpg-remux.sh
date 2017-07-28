#!/usr/bin/env bash

function show_usage () {
 echo "Usage: fpg-remux [-i file] [-s subtitle] [-t title] [-o output]"
 echo "   or: fpg-remux [-i file] [-t title] [-o output]"
 echo "   or: fpg-remux [-i file] [-s subtitle] [-o output]"
 echo "   or: fpg-remux [-i file] [-a] [-s subtitle] [-o output]"
 echo "   or: fpg-remux [-i file] [-o output]"
 echo ""
 echo "       -i, --input       File to be transcoded"
 echo "       -s, --sub Subtitle file"
 echo "       -t, --title       Media title tag"
 echo "       -a, --add         Add subtitle file only"
 echo "       -o, --output      Output file"
}

while [[ $# -gt 0 ]]
do
        KEY="$1"
        case $KEY in
                -i|--input)
                        shift
                        INPUT="$1"
                        ;;
                -s|--sub)
                        shift
                        SUBTITLE="$1"
                        ;;
                -t|--title)
                        shift
                        TITLE="$1"
                        ;;
                -o|--output)
                        shift
                        OUTPUT="$1"
                        ;;
                -a|--add)
                        shift
                        ADD=TRUE
                        ;;
                -h|--help)
                        show_usage
                        exit 0
                        ;;
                *)
                        echo "fpg-remux: Unknown option entered."
                        echo "Try 'fpg-remux -h' for more information."
                        exit 1
                        ;;
        esac
        shift # past argument or value
done

if [ -z "${INPUT}" ] || [ -z "${OUTPUT}" ]; then
        echo "fpg-remux: No input/output was specified."
        echo "Try 'fpg-remux -h' for more information."
        exit 1
fi

HEADER="-hide_banner -y -v quiet -stats "

if [ ! -z "${TITLE}" ] && [ ! -z "${SUBTITLE}" ]; then
        # Title + Subs
        ffmpeg-hi $HEADER -i "${INPUT}" -i "${SUBTITLE}" \
        -metadata title="${TITLE}" \
        -c:v copy -c:a libfdk_aac -ac 2 -b:a 256k -af "aresample=matrix_encoding=dplii" \
        -c:s mov_text -metadata:s:s:0 language=spa \
        "${OUTPUT}"
elif [ ! -z "${TITLE}" ] && [ -z "${SUBTITLE}" ]; then
        # Title, no subs
        ffmpeg-hi $HEADER -i "${INPUT}" \
        -metadata title="${TITLE}" \
        -c:v copy -c:a libfdk_aac -ac 2 -b:a 256k -af "aresample=matrix_encoding=dplii" \
        "${OUTPUT}"
elif [ -z "${TITLE}" ] && [ ! -z "${SUBTITLE}" ]; then
        # Subs, no title
        ffmpeg-hi $HEADER -i "${INPUT}" -i "${SUBTITLE}" \
        -c:v copy -c:a libfdk_aac -ac 2 -b:a 256k -af "aresample=matrix_encoding=dplii" \
        -c:s mov_text -metadata:s:s:0 language=spa \
        "${OUTPUT}"
elif [ -z "${TITLE}" ] && [ -z "${SUBTITLE}" ]; then
        # No subs, no title
        ffmpeg-hi $HEADER -i "${INPUT}" \
        -c:v copy -c:a libfdk_aac -ac 2 -b:a 256k -af "aresample=matrix_encoding=dplii" \
        "${OUTPUT}"
elif [ $ADD ] && [ ! -z "${SUBTITLE}" ]; then
        # Mux subs
        ffmpeg-hi $HEADER -i "${INPUT}" -i "${SUBTITLE}" \
        -c copy \
        -c:s mov_text -metadata:s:s:0 language=spa \
        "${OUTPUT}"
else
        echo "fpg-remux: Unknown options error."
        echo "Try 'fpg-remux -h' for more information."
        exit 1
fi
