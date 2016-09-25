# powershell-cheaptricks
A simple collection of Powershell cheap tricks that I've hacked together.  Some are written from scratch, some are based off code examples elsewhere.

## youtubevampire.ps1
Youtube Vampire is a quick and dirty implementation to download full playlists or individual videos, it will also download the video, rip out the audio in the raw format it's been uploaded only if you so choose
It relies on the youtube-dl (https://rg3.github.io/utube-dl/) python script available if you already have python 2.7:

    pip install youtube-dl

There are also binary builds available here: https://rg3.github.io/youtube-dl/download.html
