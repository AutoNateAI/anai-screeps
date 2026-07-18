# Offline Video Study

Use this workflow only for videos you own, videos you have permission to archive, or other content whose license allows offline copies. For ordinary YouTube viewing without those rights, use YouTube Premium offline downloads.

## Existing Tapes Audit

The local folder `/Users/autonate/tapes/Less Brown playlist/` was created with `yt-dlp`.

Evidence:

- Files are named with playlist index, title, and video ID: `01 - ... [video_id].mp4`.
- Each video has subtitle sidecars: `.en.vtt` and `.en-orig.vtt`.
- `downloaded.txt` contains yt-dlp archive entries such as `youtube ulCsBqBHq1c`.
- The videos were written sequentially on June 15, 2026.

No exact command was found in shell history, but the artifacts match this command shape:

```sh
yt-dlp \
  --paths "/Users/autonate/tapes/Playlist Name" \
  --output "%(playlist_index)02d - %(title)s [%(id)s].%(ext)s" \
  --format "bv*[height<=720]+ba/b[height<=720]/b" \
  --merge-output-format mp4 \
  --write-subs \
  --write-auto-subs \
  --sub-langs "en.*" \
  --convert-subs vtt \
  --download-archive "/Users/autonate/tapes/Playlist Name/downloaded.txt" \
  "PLAYLIST_OR_VIDEO_URL"
```

## Refresh Or Resume

Re-run the same command to resume a partially completed playlist. `downloaded.txt` prevents duplicate downloads.

For a fresh playlist, create a new destination folder under `/Users/autonate/tapes/` and use a separate `downloaded.txt` inside that folder.

## Notes

- Keep video archives outside this repository.
- Do not commit downloaded videos, subtitles, cookies, or account credentials.
- Avoid cookies unless you are working with your own account-authorized content and understand that cookies are credentials.
