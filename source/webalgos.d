module webalgos;

import std.math : log10, fabs, fmax;

/// Returns milliseconds per quarter-note beat for a given BPM tempo.
double beatDurationMs(double bpm) pure nothrow @safe
{
    return bpm > 0 ? 60000.0 / bpm : 0.0;
}

/// Counts differing positions between two equal-length words for word ladders.
int hammingDistance(string a, string b) pure nothrow @safe
{
    if (a.length != b.length) return -1;
    int diff = 0;
    foreach (i; 0 .. a.length)
        if (a[i] != b[i]) diff++;
    return diff;
}

/// Computes minimum Nonogram line length for a sequence of run lengths.
int nonogramMinLength(const int[] clues) pure nothrow @safe
{
    if (clues.length == 0) return 0;
    int s = 0;
    foreach (c; clues) s += c;
    return s + cast(int) clues.length - 1;
}

/// Computes logarithmic order-of-magnitude gap between two physical sizes in meters.
double scaleLog10Gap(double aMeters, double bMeters) pure nothrow @safe
{
    if (aMeters <= 0 || bMeters <= 0) return 0.0;
    return fabs(log10(aMeters / bMeters));
}
