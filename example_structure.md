# Example Input Directory Structure

This document shows different ways you can organize your video source folders for use with this MakeMKV Docker setup.

## Standard DVD Structure

For a standard DVD, your input directory should look like this:

```
input/
└── MOVIE_NAME/
    └── VIDEO_TS/
        ├── VIDEO_TS.IFO
        ├── VIDEO_TS.VOB
        ├── VTS_01_0.IFO
        ├── VTS_01_0.VOB
        └── ... (other IFO and VOB files)
```

You would then use:
```bash
./rip-disc.sh MOVIE_NAME
```

## Direct VIDEO_TS Path

You can also place VIDEO_TS folders directly in the input directory:

```
input/
└── VIDEO_TS/
    ├── VIDEO_TS.IFO
    ├── VIDEO_TS.VOB
    └── ... (other IFO and VOB files)
```

You would then use:
```bash
./rip-disc.sh VIDEO_TS
```

## Multiple Movies

For organizing multiple movies:

```
input/
├── MOVIE_1/
│   └── VIDEO_TS/
│       └── ... (IFO and VOB files)
├── MOVIE_2/
│   └── VIDEO_TS/
│       └── ... (IFO and VOB files)
└── MOVIE_3/
    └── VIDEO_TS/
        └── ... (IFO and VOB files)
```

## Blu-ray Structure

For Blu-ray folders, the structure is slightly different:

```
input/
└── MOVIE_NAME/
    └── BDMV/
        ├── index.bdmv
        ├── MovieObject.bdmv
        ├── STREAM/
        │   └── ... (m2ts files)
        └── PLAYLIST/
            └── ... (mpls files)
```

You would then use:
```bash
./rip-disc.sh MOVIE_NAME
```

## Notes

- MakeMKV looks for specific file structures, so maintaining the original organization is important
- Folder names can be anything you prefer, but the internal structure (VIDEO_TS or BDMV) must be preserved
- If you're having issues, try using the exact path to the VIDEO_TS or BDMV folder 