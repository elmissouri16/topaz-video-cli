# Topaz Video CLI for macOS

A small headless wrapper around the FFmpeg bundled with Topaz Video. It reproduces a verified Topaz Video 1.7.0 GUI export on Apple Silicon while providing terminal progress, ETA, safe output handling, and GUI-equivalent metadata finalization.

This repository contains no Topaz binaries, AI models, authentication data, or generated media.

## Verified GUI-matched workflow

- Output: 1080x1920 progressive H.264 MP4
- Frame rate: 60 FPS
- Frame interpolation: Chronos v2 (`chr-2`)
- Duplicate-frame replacement: enabled
- Duplicate sensitivity: 10 (`rdt=0.01`)
- Enhancement: Proteus v4 (`prob-4`)
- Proteus tuning: automatic (`estimate=8`)
- Recover original detail: 20 (`blend=0.2`)
- Encoding: Apple VideoToolbox, H.264 High, YUV420P
- Processing: Apple GPU device 0
- Audio: copied unchanged when present
- Metadata: the same `videoai` processing tag and two-pass finalization used by the GUI

The CLI and GUI comparison matched resolution, frame rate, duration, frame count, codec profile, time base, pixel format, color metadata, container brands, and Topaz processing tag. Small bitrate and byte-level differences are expected from GPU inference and hardware encoding.

## Requirements

- macOS on Apple Silicon
- Topaz Video installed at `/Applications/Topaz Video.app`
- Topaz Video opened and activated at least once
- Chronos v2 and Proteus v4 models installed
- A Topaz licence or agreement that authorizes CLI use
- `~/.local/bin` on your shell `PATH`

Topaz Video and its models are proprietary and are not distributed by this project. You are responsible for ensuring that your Topaz licence permits CLI access.

## Install

```bash
git clone git@github.com:elmissouri16/topaz-video-cli.git
cd topaz-video-cli
./install.sh
```

The installer places the command at `~/.local/bin/topaz-video`.

## Usage

Default output name:

```bash
topaz-video input.mp4
```

This writes:

```text
input_topaz_1080x1920_60fps.mp4
```

Choose an output path:

```bash
topaz-video input.mp4 output.mp4
```

Inspect the generated FFmpeg commands without processing:

```bash
topaz-video --dry-run input.mp4 output.mp4
```

During processing, the command displays:

```text
Progress: 42.7% | frame 768 | 3.21 fps | 0.053x | ETA 05:24
```

Existing output files are never overwritten automatically.

## How it works

The wrapper performs two passes, matching the Topaz GUI:

1. Run Chronos v2 and Proteus v4 through Topaz's bundled FFmpeg and encode an intermediate H.264 stream with VideoToolbox.
2. Stream-copy the result into the final MP4, restore source audio when present, and add the GUI-equivalent Topaz processing metadata.

Temporary files are removed automatically. Topaz authentication diagnostics are suppressed so credentials are not printed in normal terminal output.

## Updating

Topaz can change internal model identifiers, filter options, paths, and licensing between releases. Revalidate the generated GUI command and output metadata after upgrading Topaz Video.

## Licence

No licence is granted for Topaz software, models, or services. This repository only contains the independently authored shell wrapper and documentation.
