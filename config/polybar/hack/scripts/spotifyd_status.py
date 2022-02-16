#!/bin/python

import sys
import dbus

song_output = '{song} - {artist}'

try:
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object('org.mpris.MediaPlayer2.spotifyd', '/org/mpris/MediaPlayer2')
    spotify_properties = dbus.Interface(spotify_bus, 'org.freedesktop.DBus.Properties')
    metadata = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
    status = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')

    # Get the song data
    song = metadata['xesam:title'] if 'xesam:title' in metadata else ''
    artist = metadata['xesam:artist'][0] if 'xesam:artist' in metadata else ''
    song_output = song_output.format(song=song, artist=artist)

    if status == "Playing":
        print(song_output)
    else:
        print("PAUSED")
except Exception as e:
    print("OFFLINE")
