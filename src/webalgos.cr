# Zero-dependency reference algorithms for client-side browser media utilities
# and deterministic web puzzle engines.
#
# Production browser applications backed by these reference algorithms:
#
# - [Offline GIF Editor](https://offlinegifeditor.com/) — client-side GIF89a frame disposal, timeline slicing, and chroma cutout studio
# - [Audio Visualizer Online](https://audiovisualizeronline.com/) — offline Web Audio FFT spectrum and WebCodecs video exporter
# - [Get Word Ladder](https://getwordladder.com/) — 4-letter and 5-letter bidirectional BFS word-ladder and word-chain puzzle game
# - [Play Size Comparison](https://playsizecomparison.com/) — true-to-scale logarithmic 3D visual estimation game
# - [Guess The Animal Game](https://guesstheanimalgame.com/) — 365-species Linnaean taxonomic deduction and wildlife sound game
# - [PuzzleFern](https://puzzlefern.com/) — 24 classic browser logic and number puzzles including Nonogram, Hashi, and Lights Out
# - [MakeMeRap](https://makemerap.com/) — BPM beat-grid alignment and AI rap music video generator
# - [Play Color by Number](https://playcolorbynumber.com/) — 100% browser-local dual-engine Pixel & Smooth Vector color-by-number studio, OKLab photo converter, and printable PDF generator
module WebAlgos
  VERSION = "0.1.6"

  # Returns milliseconds per quarter-note beat for a given BPM tempo.
  # Used by [MakeMeRap](https://makemerap.com/) and [Audio Visualizer Online](https://audiovisualizeronline.com/).
  def self.beat_duration_ms(bpm : Float64) : Float64
    bpm > 0 ? 60_000.0 / bpm : 0.0
  end

  # Counts differing positions between two equal-length words for word ladders.
  # Used by [Get Word Ladder](https://getwordladder.com/).
  def self.hamming_distance(a : String, b : String) : Int32
    return -1 if a.size != b.size
    a.each_char.zip(b.each_char).count { |x, y| x != y }
  end

  # Computes minimum Nonogram line length for a sequence of run lengths.
  # Used by [PuzzleFern](https://puzzlefern.com/).
  def self.nonogram_min_length(clues : Array(Int32)) : Int32
    return 0 if clues.empty?
    clues.sum + clues.size - 1
  end

  # Computes logarithmic order-of-magnitude gap between two physical sizes in meters.
  # Used by [Play Size Comparison](https://playsizecomparison.com/).
  def self.scale_log10_gap(a_meters : Float64, b_meters : Float64) : Float64
    return 0.0 if a_meters <= 0 || b_meters <= 0
    Math.log10(a_meters / b_meters).abs
  end

  # Computes shared taxonomic rank depth between two Linnaean paths.
  # Used by [Guess The Animal Game](https://guesstheanimalgame.com/).
  def self.shared_taxon_depth(a : Array(String), b : Array(String)) : Int32
    depth = 0
    a.zip?(b).each do |x, y|
      break if x != y
      depth += 1
    end
    depth
  end

  # Converts GIF89a 1/100th-second delay ticks into clamped milliseconds.
  # Used by [Offline GIF Editor](https://offlinegifeditor.com/).
  def self.gif_delay_ticks_to_ms(delay_ticks : Int32) : Int32
    delay_ticks <= 1 ? 100 : delay_ticks * 10
  end

  # Computes relative sRGB luminance (0..1) for numeral contrast inside color-by-number regions.
  # Used by [Play Color by Number](https://playcolorbynumber.com/).
  def self.srgb_luminance(r : UInt8, g : UInt8, b : UInt8) : Float64
    (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255.0
  end
end
