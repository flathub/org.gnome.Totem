#!/bin/bash

mkdir -p /app/lib/codecs/lib/gstreamer-1.0

SYSTEM_MODULES_DIR=$(PKG_CONFIG_PATH='' pkg-config --variable=pluginsdir gstreamer-1.0)
export GST_PLUGIN_SYSTEM_PATH=/app/lib/gstreamer-1.0
export LD_LIBRARY_PATH=/app/lib/codecs/lib/:/app/lib/

for i in /app/lib/gstreamer-1.0/*.so; do
  while read -r line
  do
    case "$line" in
      "Source module"*)
        SUITE="$(echo "$line" | sed 's,Source module,,' | tr -d '[:blank:]')"
        ;;
      Name*)
        PLUGIN="$(echo "$line" | sed 's,Name,,' | tr -d '[:blank:]')"
        ;;
    esac
  done < <(gst-inspect-1.0 "$i")


  case "$SUITE" in
    gst-plugins-ugly|gst-libav)
      echo "Exiling $PLUGIN from $SUITE to codecs runtime" >&2
      mv "$i" /app/lib/codecs/lib/gstreamer-1.0
      ;;

    gst-plugins-bad)
      if [ -e "$SYSTEM_MODULES_DIR/$(basename "$i")" ]
      then
        echo "Keeping $PLUGIN from $SUITE (present in runtime) in app" >&2
      else
        echo "Exiling $PLUGIN from $SUITE to codecs runtime" >&2
        mv "$i" /app/lib/codecs/lib/gstreamer-1.0
      fi
      ;;
  esac
done
