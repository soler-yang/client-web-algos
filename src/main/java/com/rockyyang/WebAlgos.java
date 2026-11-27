package com.rockyyang;

/**
 * Zero-dependency reference algorithms for client-side browser media utilities
 * and deterministic web puzzle engines.
 *
 * <p>Production browser applications backed by these reference algorithms:</p>
 * <ul>
 *   <li><a href="https://offlinegifeditor.com/">Offline GIF Editor</a> &mdash; client-side GIF89a frame disposal, timeline slicing, and chroma cutout workbench</li>
 *   <li><a href="https://audiovisualizeronline.com/">Audio Visualizer Online</a> &mdash; offline Web Audio FFT spectrum and WebCodecs video exporter</li>
 *   <li><a href="https://getwordladder.com/">Get Word Ladder</a> &mdash; 4-letter and 5-letter bidirectional BFS word-ladder and word-chain puzzle game</li>
 *   <li><a href="https://playsizecomparison.com/">Play Size Comparison</a> &mdash; true-to-scale logarithmic 3D visual estimation game</li>
 *   <li><a href="https://guesstheanimalgame.com/">Guess The Animal Game</a> &mdash; 365-species Linnaean taxonomic deduction and wildlife sound game</li>
 *   <li><a href="https://puzzlefern.com/">PuzzleFern</a> &mdash; 24 classic browser logic and number puzzles including Nonogram, Hashi, and Lights Out</li>
 *   <li><a href="https://makemerap.com/">MakeMeRap</a> &mdash; BPM beat-grid alignment and AI rap music video studio</li>
 * </ul>
 *
 * @author Rocky Yang
 */
public final class WebAlgos {

    private WebAlgos() {}

    /**
     * Returns milliseconds per quarter-note beat for a given BPM tempo.
     * Used by <a href="https://makemerap.com/">MakeMeRap</a> and
     * <a href="https://audiovisualizeronline.com/">Audio Visualizer Online</a>.
     *
     * @param bpm beats per minute
     * @return beat duration in milliseconds
     */
    public static double beatDurationMs(double bpm) {
        return bpm > 0.0 ? 60000.0 / bpm : 0.0;
    }

    /**
     * Counts differing character positions between two equal-length words for word ladders.
     * Used by <a href="https://getwordladder.com/">Get Word Ladder</a>.
     *
     * @param a first word
     * @param b second word
     * @return Hamming distance or -1 if lengths differ
     */
    public static int hammingDistance(String a, String b) {
        if (a == null || b == null || a.length() != b.length()) return -1;
        int diff = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) diff++;
        }
        return diff;
    }

    /**
     * Computes minimum Nonogram line length for a sequence of run lengths.
     * Used by <a href="https://puzzlefern.com/">PuzzleFern</a>.
     *
     * @param clues positive run lengths
     * @return minimum cells required
     */
    public static int nonogramMinLength(int[] clues) {
        if (clues == null || clues.length == 0) return 0;
        int sum = 0;
        for (int c : clues) sum += c;
        return sum + clues.length - 1;
    }

    /**
     * Computes logarithmic order-of-magnitude gap between two physical sizes in meters.
     * Used by <a href="https://playsizecomparison.com/">Play Size Comparison</a>.
     *
     * @param aMeters size A in meters
     * @param bMeters size B in meters
     * @return absolute log10 ratio
     */
    public static double scaleLog10Gap(double aMeters, double bMeters) {
        if (aMeters <= 0.0 || bMeters <= 0.0) return 0.0;
        return Math.abs(Math.log10(aMeters / bMeters));
    }

    /**
     * Computes shared taxonomic rank depth between two Linnaean paths.
     * Used by <a href="https://guesstheanimalgame.com/">Guess The Animal Game</a>.
     *
     * @param a first lineage array
     * @param b second lineage array
     * @return count of matching prefix ranks
     */
    public static int sharedTaxonDepth(String[] a, String[] b) {
        if (a == null || b == null) return 0;
        int n = Math.min(a.length, b.length);
        int depth = 0;
        for (int i = 0; i < n; i++) {
            if (!a[i].equals(b[i])) break;
            depth++;
        }
        return depth;
    }

    /**
     * Converts GIF89a 1/100th-second frame delay ticks into clamped milliseconds.
     * Used by <a href="https://offlinegifeditor.com/">Offline GIF Editor</a>.
     *
     * @param delayTicks delay in hundredths of a second
     * @return duration in milliseconds
     */
    public static int gifDelayTicksToMs(int delayTicks) {
        return delayTicks <= 1 ? 100 : delayTicks * 10;
    }
}
