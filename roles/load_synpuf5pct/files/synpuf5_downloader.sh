#!/usr/bin/env bash
# can't curl file b/c of pop-up, so have to find confirm code in html.
# from SO post below:
# https://stackoverflow.com/questions/25010369/wget-curl-large-file-from-google-drive
ggID='18EjMxyA6NsqBo9eed_Gab1ESHWPxJygz'
ggURL='https://drive.google.com/uc?export=download'
curl -sc /tmp/gcokie "${ggURL}&id=${ggID}" >/dev/null
getcode="$(awk '/_warning_/ {print $NF}' /tmp/gcokie)"
curl -LOJb /tmp/gcokie "${ggURL}&confirm=${getcode}&id=${ggID}"