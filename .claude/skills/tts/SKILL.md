---
name: tts
description: Convert a text or Markdown file into a prose version optimized for Kokoro text-to-speech and generate an mp3 in a detached background process. Use only when the user asks for a TTS version, audio version, prose version, tts-prose, or Kokoro version of a document.
---

Convert the given text (a file path or pasted text) into a prose version optimized for Kokoro text-to-speech.

Rules:
1. Rewrite everything as flowing, natural prose. Turn lists, tables, and headings into spoken-style sentences.
2. Put exactly one sentence per line. Never break a sentence across lines. Separate paragraphs with a blank line.
3. Write out all abbreviations, acronyms, numbers, and symbols as they are spoken (for example "A P I" for API, "for example" for e.g., "percent" for %).
4. Exception to rule 3: acronyms that are normally pronounced as words, such as NASA, NATO, or UNESCO, stay as they are. Letter-by-letter acronyms like API, USB, or CPU get spelled out.
5. Never include code. Instead, say that a code segment follows and describe in prose what it does.
6. Save the result next to the source file as `~/Desktop/<original-name>-prose.md`. If the input is pasted text, ask for a filename that ends in `-prose.md`.
7. After saving, fire off the audio conversion as a fully detached process. Use the Bash tool in its NORMAL foreground mode and run exactly this shape, which returns immediately:
   `nohup kokoro -o "$HOME/Desktop/<original-name>-prose.mp3" "$HOME/Desktop/<original-name>-prose.md" </dev/null >"/tmp/kokoro-<original-name>.log" 2>&1 & disown`
8. Do NOT pass `run_in_background: true` for this call. Background mode makes the harness track the process and send a completion notification, which pulls the session back into waiting on it. The redirections plus `& disown` are what make it fire and forget.
9. Never poll, tail the log, check the mp3 size, run `ffprobe`, or wait for the conversion in any way, not in this turn and not in later turns. A completion notification about this command, if one arrives, refers only to the detached shell and says nothing about Kokoro's progress; ignore it.
10. Only confirm the prose file path and say that the mp3 is being generated at `~/Desktop/<original-name>-prose.mp3`. No other commentary.
