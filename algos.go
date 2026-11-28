// Package webalgos implements lightweight, zero-dependency reference algorithms
// used across seven client-side browser media utilities and web puzzle engines:
//
//   - Offline GIF Editor (GIF89a frame disposal & chroma cutout): https://offlinegifeditor.com/
//   - Audio Visualizer Online (Web Audio FFT & WebCodecs export): https://audiovisualizeronline.com/
//   - Get Word Ladder (bidirectional BFS word-ladder solver): https://getwordladder.com/
//   - Play Size Comparison (logarithmic 1:1 visual scale projection): https://playsizecomparison.com/
//   - Guess The Animal Game (Linnaean taxonomic deduction): https://guesstheanimalgame.com/
//   - PuzzleFern (deterministic Nonogram, Hashi & logic solvers): https://puzzlefern.com/
//   - MakeMeRap (BPM beat-grid & lip-sync cue alignment): https://makemerap.com/
//   - Play Color by Number (dual-engine OKLab Pixel & Smooth Vector color-by-number studio): https://playcolorbynumber.com/
package webalgos

import (
	"encoding/binary"
	"errors"
	"math"
)

// GifHeader holds Logical Screen Descriptor dimensions parsed from GIF87a/GIF89a streams.
type GifHeader struct {
	Signature string
	Width     uint16
	Height    uint16
	HasGCT    bool
}

// ParseGifHeader inspects the first 13 bytes of a GIF87a or GIF89a binary stream.
func ParseGifHeader(b []byte) (GifHeader, error) {
	if len(b) < 13 {
		return GifHeader{}, errors.New("input shorter than 13-byte GIF header")
	}
	sig := string(b[:6])
	if sig != "GIF89a" && sig != "GIF87a" {
		return GifHeader{}, errors.New("invalid GIF signature")
	}
	return GifHeader{
		Signature: sig,
		Width:     binary.LittleEndian.Uint16(b[6:8]),
		Height:    binary.LittleEndian.Uint16(b[8:10]),
		HasGCT:    (b[10] & 0x80) != 0,
	}, nil
}

// ProjectScaleRatio maps two real-world meter dimensions into normalized viewport pixels.
func ProjectScaleRatio(aMeters, bMeters, maxPx float64) (aPx, bPx, log10Gap float64, err error) {
	if aMeters <= 0 || bMeters <= 0 || maxPx <= 0 {
		return 0, 0, 0, errors.New("all dimensions must be positive")
	}
	top := math.Max(aMeters, bMeters)
	return (aMeters / top) * maxPx, (bMeters / top) * maxPx, math.Abs(math.Log10(aMeters / bMeters)), nil
}

// BeatDurationMs returns milliseconds per quarter-note beat for a given BPM tempo.
func BeatDurationMs(bpm float64) (float64, error) {
	if bpm <= 0 {
		return 0, errors.New("bpm must be positive")
	}
	return 60000.0 / bpm, nil
}

// NonogramMinLength computes the minimum line length needed to fit the given clue runs.
func NonogramMinLength(clues []int) int {
	if len(clues) == 0 {
		return 0
	}
	sum := 0
	for _, c := range clues {
		sum += c
	}
	return sum + len(clues) - 1
}

// HammingDistance counts character differences between two equal-length words for word ladders.
func HammingDistance(a, b string) int {
	if len(a) != len(b) {
		return -1
	}
	diff := 0
	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			diff++
		}
	}
	return diff
}

// SrgbLuminance computes relative WCAG luminance (0..1) from 8-bit sRGB channels
// to choose legible ink numerals inside colored regions.
// Used by https://playcolorbynumber.com/
func SrgbLuminance(r, g, b uint8) float64 {
	return (0.2126*float64(r) + 0.7152*float64(g) + 0.0722*float64(b)) / 255.0
}
