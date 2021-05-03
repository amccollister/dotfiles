#!/bin/python

import sys
import dbus

MAX_LENGTH=25
song_output = '    {song} - {artist}    ' # Four spaces for scroll
output = []
song_file = sys.argv[1]

try:
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object('org.mpris.MediaPlayer2.spotifyd', '/org/mpris/MediaPlayer2')

    spotify_properties = dbus.Interface(spotify_bus, 'org.freedesktop.DBus.Properties')

    metadata = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
    status = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')

    # Do something with playing or paused

    # Get the song data
    song = metadata['xesam:title'] if 'xesam:title' in metadata else ''
    artist = metadata['xesam:artist'][0] if 'xesam:artist' in metadata else ''
    song_output = song_output.format(song=song, artist=artist)

    # Create the scrolling list
    if status == "Playing":
        for i in range(len(song_output)):
            output.append("|"+(song_output[i:]+song_output[:i])[:MAX_LENGTH]+"|")
        #output = song_output
    else:
        output.append(" PAUSED ")

except Exception as e:
    #if isinstance(e, dbus.exceptions.DBusException):
    #    print('')
    #else:
    #    print(e)
    print(e)
    output.append(" OFFLINE ")

# Write the text to the file
with open(song_file, "w") as f:
    for line in output:
        f.write(line+"\n")
    #f.write(output)