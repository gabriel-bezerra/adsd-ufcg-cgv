
encoder = [ "vp8", "h264", "theora", "xvid" ]

resolution = [ "480p", "720p" ]

frames = [ "900", "5400" ]

motion = [ "high", "low" ]


def video_names():
    for r in resolution:
        for f in frames:
            for m in motion:
                yield r + "_" + f + "_" + m


print "Video names"
for v in video_names():
    print "\t", v
