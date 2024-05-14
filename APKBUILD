# Maintainer: Sasha Gerrand <alpine-pkgs@sgerrand.com>

pkgname="glibc"
pkgver=2.39
_pkgrel="0"
pkgrel=0
pkgdesc="GNU C Library compatibility layer"
arch="x86_64"
url="https://github.com/sgerrand/alpine-pkg-glibc"
license="LGPL"
source="glibc-bin.tar.gz
	ld.so.conf"
subpackages="$pkgname-bin $pkgname-dev $pkgname-i18n"
triggers="$pkgname-bin.trigger=/lib:/usr/lib:/usr/glibc-compat/lib"

package() {
  mkdir -p "$pkgdir/lib" "$pkgdir/usr/glibc-compat/lib/locale"  "$pkgdir"/usr/glibc-compat/lib64 "$pkgdir"/etc
  cp -a "$srcdir"/usr "$pkgdir"
  cp "$srcdir"/ld.so.conf "$pkgdir"/usr/glibc-compat/etc/ld.so.conf
  rm "$pkgdir"/usr/glibc-compat/etc/rpc
  rm -rf "$pkgdir"/usr/glibc-compat/bin
  rm -rf "$pkgdir"/usr/glibc-compat/sbin
  rm -rf "$pkgdir"/usr/glibc-compat/lib/gconv
  rm -rf "$pkgdir"/usr/glibc-compat/lib/getconf
  rm -rf "$pkgdir"/usr/glibc-compat/lib/audit
  rm -rf "$pkgdir"/usr/glibc-compat/share
  rm -rf "$pkgdir"/usr/glibc-compat/var
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 ${pkgdir}/lib/ld-linux-x86-64.so.2
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 ${pkgdir}/usr/glibc-compat/lib64/ld-linux-x86-64.so.2
  ln -s /usr/glibc-compat/etc/ld.so.cache ${pkgdir}/etc/ld.so.cache
}

bin() {
  depends="$pkgname bash libc6-compat libgcc"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/bin "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/sbin "$subpkgdir"/usr/glibc-compat
}

i18n() {
  depends="$pkgname-bin"
  arch="noarch"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/share "$subpkgdir"/usr/glibc-compat
}

sha512sums="
07b9d8a757c3023791371f98904a60951de0a26c7576b08fd116602de23b6b75c991a59137decc3a81c8e284f0a982eded478839543450b7e3b2d3a496e72915  glibc-bin.tar.gz
2912f254f8eceed1f384a1035ad0f42f5506c609ec08c361e2c0093506724a6114732db1c67171c8561f25893c0dd5c0c1d62e8a726712216d9b45973585c9f7  ld.so.conf
"
