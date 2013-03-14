#!/usr/bin/env python2

# Factors

encoders = { "vp8": "libvpx",
            "h264": "libx264",
            "theora": "libtheora",
            "xvid": "mpeg4" }

resolutions = [ "240p", "480p" ]

frames = [ "500", "2000" ]

motions = [ "high", "low" ]


# Experiments

import subprocess

run_experiment_script = "./run-experiment.sh"
input_video_directory = "../../input_videos/"

class Experiment:
    def __init__(self, encoder, resolution, frames, motion, repetition_number):
        self.encoder = encoder
        self.resolution = resolution
        self.frames = frames
        self.motion = motion
        self.repetition_number = repetition_number

    def input_file_name(self):
        input_video_name = \
            "_".join([self.resolution, self.frames, self.motion])

        return input_video_directory + input_video_name + ".flv"

    def conversion_command(self):
        command = "avconv"
        input_part = "-i " + self.input_file_name()
        output_encoder = "-c:v " + encoders[self.encoder]
        force_overwrite = "-y"
        output_file = "output.mkv"

        return " ".join([command, input_part, output_encoder, force_overwrite, output_file])

    def name(self):
        return "_".join([self.encoder, self.resolution, self.frames, self.motion, str(self.repetition_number)])

    def factors(self):
        return " ".join([self.encoder, self.resolution, self.frames, self.motion, str(self.repetition_number)])

    def run(self):
        name_part = self.name()
        factors_part = self.factors()
        command_part = self.conversion_command()

        subprocess.call([run_experiment_script, name_part, factors_part, command_part])


# Run experiments

repetitions = range(5, 15)

def experiments():
    for i in repetitions:
        for r in resolutions:
            for f in frames:
                for e in encoders.keys():
                    for m in motions:
                        yield Experiment(e, r, f, m, i)

for exp in experiments():
    exp.run()

