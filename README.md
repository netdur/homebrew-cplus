# homebrew-cplus

Homebrew tap for [C+](https://cplus-lang.dev) — an experimental, safety-oriented
systems programming language and toolchain.

## Install

```sh
brew install netdur/cplus/cplus
```

Or tap first, then install:

```sh
brew tap netdur/cplus
brew install cplus
```

This installs the `cpc` compiler, the `cpc-lsp` language server, and the
`cpc-bindgen` FFI generator.

### Latest from `main`

```sh
brew install --HEAD netdur/cplus/cplus
```

## Requirements

`cpc` produces LLVM IR and shells out to `clang` to link a native binary, so
compiling/running a program needs a C toolchain on PATH (Xcode Command Line
Tools on macOS, `clang` on Linux). Front-end commands (`cpc check`,
`cpc --emit-ll`, `cpc lsp`, `cpc graph`, …) work without it.

Developed and tested against **Apple clang 21.0.0** on macOS / Apple Silicon
(`aarch64-apple-darwin`). Other clang versions and targets may work but are not
yet part of the tested matrix.
