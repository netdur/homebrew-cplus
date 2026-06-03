class Cplus < Formula
  desc "Experimental, safety-oriented systems programming language and toolchain"
  homepage "https://cplus-lang.dev"
  url "https://github.com/netdur/cplus/archive/refs/tags/v0.0.13.tar.gz"
  sha256 "f06a913f46a79006b4f6b7e04282590766233da93d3cea106c4beaa31d475e4a"
  license "MIT"
  head "https://github.com/netdur/cplus.git", branch: "main"

  depends_on "rust" => :build

  def install
    # cpc shells out to `clang` at link time; cpc-lsp/cpc-bindgen are the
    # editor + FFI tooling. Install all three from their workspace crates.
    system "cargo", "install", *std_cargo_args(path: "cpc")
    system "cargo", "install", *std_cargo_args(path: "cpc-lsp")
    system "cargo", "install", *std_cargo_args(path: "cpc-bindgen")
  end

  def caveats
    <<~EOS
      `cpc` compiles to LLVM IR and shells out to `clang` to produce a native
      binary, so building/running a program needs a C toolchain on PATH:
        - macOS: Xcode Command Line Tools  (xcode-select --install)
        - Linux: clang  (e.g. `brew install llvm` or your distro's clang)
      The front-end-only commands (cpc check / --emit-ll / lsp / graph / query /
      mcp / fmt / doc) work without clang.

      Developed and tested against Apple clang 21.0.0 on macOS / Apple Silicon
      (aarch64-apple-darwin). Other clang versions and targets may work but are
      not yet part of the tested matrix.
    EOS
  end

  test do
    (testpath/"hello.cplus").write <<~CPLUS
      fn main() -> i32 {
          return 0;
      }
    CPLUS
    # Whole front end + codegen, no clang required: prints LLVM IR to stdout.
    assert_match "define", shell_output("#{bin}/cpc --emit-ll #{testpath}/hello.cplus")
    assert_match version.to_s, shell_output("#{bin}/cpc --version")
  end
end
