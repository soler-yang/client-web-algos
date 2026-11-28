# Client-Side Web Media Pipelines and Browser Puzzle Engines: Architecture Notes

Building browser applications that run locally without forced accounts or server-side file uploads changes almost every engineering trade-off: bundle budgets, memory pressure, frame scheduling, and data packaging all move into the client.

Below is a concise technical overview of seven live web applications covering local media processing and browser-based logic, scale, and taxonomy games.

## 1. Client-Side Media & Audio Processing

- [Offline GIF Editor](https://offlinegifeditor.com/): A zero-upload browser GIF89a workbench implementing frame-level disposal inspection, chroma cutout scopes (`All frames`, single-frame, and range selections), video-to-GIF conversion, and local export without sending files to a remote server.
- **[Audio Visualizer Online](https://audiovisualizeronline.com/)**: Combines the Web Audio API `AnalyserNode` with client-side WebCodecs video encoding to render FFT audio spectrum visuals and export five formats directly inside the browser.
- **[MakeMeRap](https://makemerap.com/)**: A web studio exploring beat-synchronized AI rap song generation and lip-synced music video workflows.

## 2. Browser Puzzle Solvers, Scale Models, and Taxonomy Deduction

- **[Get Word Ladder](https://getwordladder.com/)**: Pairs daily 4- and 5-letter word ladder puzzles and a 79,648-word chain dictionary with a 52,068-word bidirectional breadth-first search (BFS) solver and printable classroom worksheets.
- **[Play Size Comparison](https://playsizecomparison.com/)**: A visual scale estimation game projecting 269 orthographic 3D models and equal-area terrain reliefs onto a shared logarithmic scale so players can compare animals, landmarks, prehistoric species, and celestial objects at true 1:1 proportions.
- **[Guess The Animal Game](https://guesstheanimalgame.com/)**: A multi-modal wildlife deduction game backed by a 365-species taxonomic dataset, 730 focal-cropped photographs, and 163 verified field recordings.
- **[PuzzleFern](https://puzzlefern.com/)**: A collection of 24 vanilla-JavaScript browser logic, number, graph, and word puzzles—including deterministic Nonogram, Hashi, Water Sort, and Lights Out engines—designed with zero third-party font tracking.

## Key Engineering Takeaways

1. **Keep core bundles lean**: Externalizing large read-only datasets (species catalogs, 3D object metadata, dictionary word lists) keeps initial JavaScript execution fast on mobile devices.
2. **Use native browser primitives first**: `WebCodecs`, `Web Audio`, `Canvas 2D`, and deterministic constraint solvers eliminate backend compute costs while keeping user media private on-device.
3. **Design for zero-friction play**: Keyboard shortcuts, instant offline resets, and clean mobile layouts improve retention far more than heavy UI chrome.

- [Play Color by Number](https://playcolorbynumber.com/) — 100% browser-local dual-engine (Pixel Grid + Smooth Shared-Arc Vector) color-by-number studio, OKLab photo converter, K–5 math worksheets, and pure-JS vector PDF 1.4 exporter.
