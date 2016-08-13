# This should be used to download video or audio components from youtube style mp4 hosted video
# youtube-dl python script (exe on windows) path
$youtubedl = "C:\python27\scripts\youtube-dl.exe"
$ffmpeg = "C:\ffmpeg\bin\ffmpeg.exe"

if($args[0] -match "youtu" ) 
    { 
        $Playlisturl = $args[0]
    }
else
    {
        $Playlisturl = read-host "Please input the URL for the youtube playlist/video you'd like to download"
    }

function downloadvideo ($url)
    {
         & $youtubedl "--ffmpeg-location" $ffmpeg $url
    }
function downloadaudio ($url)
    {
         & $youtubedl "--ffmpeg-location" $ffmpeg  "-x" $url
    }
    
$mp3orno = read-host "Do you only want audio? (Y/N)"

if ($Playlisturl -match "list") 
    {

        #$Playlisturl = "http://www.youtube.com/playlist?list=PL1058E06599CCF54D" 
        $VideoUrls= (invoke-WebRequest -uri $Playlisturl).Links | ? {$_.HREF -like "/watch*"} | ` 
        ? innerText -notmatch ".[0-9]:[0-9]." | ? {$_.innerText.Length -gt 3} | Select innerText, ` 
        @{Name="URL";Expression={'http://www.youtube.com' + $_.href}} | ? innerText -notlike "*Play all*"

        #Print out each URL from the list 
        $VideoUrls
 
        ForEach ($video in $VideoUrls)
            {
                if($mp3orno -match "Y")
                    {
                        downloadaudio $video.URL.substring(0,43)
                    }
                    else
                    {
                        Write-Host ("Downloading " + $video.innerText)
                        downloadvideo  $video.URL.substring(0,43)
                    }
            }
    }
else
    {
        if($mp3orno -match "Y")
            {
                downloadaudio $Playlisturl
            }
            else
            {
                Write-Host "Downloading" + $Playlisturl
                downloadvideo $Playlisturl
            }
     }
pause

