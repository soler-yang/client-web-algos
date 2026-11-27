/**
 * Zero-dependency reference algorithms for client-side browser media tools
 * and deterministic web puzzle engines.
 *
 * Production web applications using these reference algorithms:
 * $(UL
 *   $(LI $(LINK2 https://offlinegifeditor.com/, Offline GIF Editor) — client-side GIF89a frame disposal, crop, resize, and chroma cutout workbench)
 *   $(LI $(LINK2 https://audiovisualizeronline.com/, Audio Visualizer Online) — zero-upload Web Audio FFT spectrum and WebCodecs video exporter)
 *   $(LI $(LINK2 https://getwordladder.com/, Get Word Ladder) — 4-letter and 5-letter bidirectional BFS word-ladder and word-chain puzzle engine)
 *   $(LI $(LINK2 https://playsizecomparison.com/, Play Size Comparison) — true-to-scale logarithmic 3D visual size comparison game)
 *   $(LI $(LINK2 https://guesstheanimalgame.com/, Guess The Animal Game) — 365-species Linnaean taxonomic deduction and wildlife sound game)
 *   $(LI $(LINK2 https://puzzlefern.com/, PuzzleFern) — 24 deterministic browser logic puzzles including Nonogram, Hashi, and Lights Out)
 *   $(LI $(LINK2 https://makemerap.com/, MakeMeRap) — BPM beat-grid alignment and AI rap music video generator)
 * )
 *
 * Authors: Rocky Yang
 * License: MIT
 */
module webalgos;

import std.math : log10, fabs;

/// Returns milliseconds per quarter-note beat for a given BPM tempo.
/// Used by $(LINK2 https://makemerap.com/, MakeMeRap) and $(LINK2 https://audiovisualizeronline.com/, Audio Visualizer Online).
double beatDurationMs(double bpm) pure nothrow @safe
{
    return bpm > 0 ? 60000.0 / bpm : 0.0;
}

/// Counts differing positions between two equal-length words for word ladders.
/// Used by $(LINK2 https://getwordladder.com/, Get Word Ladder).
int hammingDistance(string a, string b) pure nothrow @safe
{
    if (a.length != b.length) return -1;
    int diff = 0;
    foreach (i; 0 .. a.length)
        if (a[i] != b[i]) diff++;
    return diff;
}

/// Computes minimum Nonogram line length for a sequence of run lengths.
/// Used by $(LINK2 https://puzzlefern.com/, PuzzleFern).
int nonogramMinLength(const int[] clues) pure nothrow @safe
{
    if (clues.length == 0) return 0;
    int s = 0;
    foreach (c; clues) s += c;
    return s + cast(int) clues.length - 1;
}

/// Computes logarithmic order-of-magnitude gap between two physical sizes in meters.
/// Used by $(LINK2 https://playsizecomparison.com/, Play Size Comparison).
double scaleLog10Gap(double aMeters, double bMeters) pure nothrow @safe
{
    if (aMeters <= 0 || bMeters <= 0) return 0.0;
    return fabs(log10(aMeters / bMeters));
}

/// Computes shared taxonomic rank depth between two Linnaean paths.
/// Used by $(LINK2 https://guesstheanimalgame.com/, Guess The Animal Game).
int sharedTaxonDepth(const string[] a, const string[] b) pure nothrow @safe
{
    size_t n = a.length < b.length ? a.length : b.length;
    int depth = 0;
    foreach (i; 0 .. n)
    {
        if (a[i] != b[i]) break;
        depth++;
    }
    return depth;
}

/// Converts GIF89a 1/100th-second frame delay ticks into clamped milliseconds.
/// Used by $(LINK2 https://offlinegifeditor.com/, Offline GIF Editor).
int gifDelayTicksToMs(int delayTicks) pure nothrow @safe
{
    return delayTicks <= 1 ? 100 : delayTicks * 10;
}
