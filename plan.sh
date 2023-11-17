pkg_name="cryanc"
pkg_origin="ryanwoodsmall"
pkg_version="2.2"
pkg_license=("BSD")
pkg_maintainer="ryanwoodsmall <rwoodsmall@gmail.com>"
pkg_description="Crypto Ancienne: TLS for the Internet of Old Things"
pkg_upstream_url="https://github.com/classilla/cryanc"
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_filename="${pkg_version}.tar.gz"
pkg_source="https://github.com/classilla/cryanc/archive/refs/tags/${pkg_filename}"
pkg_shasum="2fa267ab96305d04b6144251f3a0fd7008aecae00aef43be0fb9bc2a75db0a7f"
pkg_build_deps=("core/gcc" "core/musl" "core/file")
pkg_bin_dirs=("bin")

DO_CHECK=1

do_build() {
  cd "${SRC_PATH}" || exit 1
  local CC="$(pkg_path_for core/musl)/bin/musl-gcc"
  export CC
  "${CC}" -Os -g0 -Wl,-s -Wl,-static carl.c -o carl -static -s
  unset CC
}

do_install() {
  cd "${SRC_PATH}" || exit 1
  mkdir -p "${pkg_prefix}/bin"
  mkdir -p "${pkg_prefix}/src"
  mkdir -p "${pkg_prefix}/share/man/man1"
  install -m 0755 carl "${pkg_prefix}/bin/carl"
  ln -sf carl "${pkg_prefix}/bin/${pkg_name}"
  install -m 0644 *.c *.h *.md "${pkg_prefix}/src"
  install -m 0644 carl.1 "${pkg_prefix}/share/man/man1/carl.1"
}

do_check() {
  cd "${SRC_PATH}" || exit 1
  build_line "checking that carl is static"
  file carl | grep 'ELF.*static'
  build_line "checking carl version"
  ./carl -v 2>&1 | grep " v${pkg_version}"
}
