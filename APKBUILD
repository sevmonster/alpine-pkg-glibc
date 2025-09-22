# Maintainer: sev <alpine@sev.monster>

pkgname="glibc"
pkgver=2.42
pkgrel=0
pkgdesc="GNU C Library compatibility layer"
arch="x86_64"
url="https://github.com/sgerrand/alpine-pkg-glibc"
license="LGPL"
source="glibc-bin-$pkgver-r$pkgrel.tar.gz
	ld.so.conf"
replaces=gcompat
subpackages="$pkgname-bin $pkgname-dev $pkgname-i18n"
triggers="$pkgname-bin.trigger=/lib:/usr/lib:/usr/glibc-compat/lib"
# TODO: tests
# TODO: provides=so:ld-linux-x86-64.so.2=2 breaks install with gcompat, is
#       there a way to announce this lib while also using replaces?
options="!check !tracedeps"
ldpath=/usr/glibc-compat/lib

package() {
  mkdir -p "$pkgdir/lib" "$pkgdir/usr/glibc-compat/lib/locale" \
           "$pkgdir"/usr/glibc-compat/lib64 "$pkgdir"/etc
  cp -a "$srcdir"/usr "$pkgdir"
  cp "$srcdir"/ld.so.conf "$pkgdir"/usr/glibc-compat/etc/ld.so.conf
  rm -rf "$pkgdir"/usr/glibc-compat/etc/rpc \
         "$pkgdir"/usr/glibc-compat/bin \
         "$pkgdir"/usr/glibc-compat/sbin \
         "$pkgdir"/usr/glibc-compat/lib/gconv \
         "$pkgdir"/usr/glibc-compat/lib/getconf \
         "$pkgdir"/usr/glibc-compat/lib/audit \
         "$pkgdir"/usr/glibc-compat/share \
         "$pkgdir"/usr/glibc-compat/var
  # XXX: abuild doesn't like this but most glibc binaries link to /lib
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so.2 "$pkgdir"/lib
  ln -s /usr/glibc-compat/lib "$pkgdir"/usr/glibc-compat/lib64
  ln -s /usr/glibc-compat/etc/ld.so.cache "$pkgdir"/etc
}

bin() {
  depends="$pkgname bash gcompat libgcc"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/bin \
        "$srcdir"/usr/glibc-compat/sbin \
        "$subpkgdir"/usr/glibc-compat
}

i18n() {
  depends="$pkgname-bin"
  arch="noarch"
  mkdir -p "$subpkgdir"/usr/glibc-compat
  cp -a "$srcdir"/usr/glibc-compat/share "$subpkgdir"/usr/glibc-compat
}

sha512sums="
9edb28574e7296efb681ac2787cfe76c9949072cc0eabd3efbbcc6f7799f5df64422b75c4685a9b2a0115505116fd963772daac458d121c547a5cb520d626bd8  glibc-bin-2.41-r0.tar.gz
2912f254f8eceed1f384a1035ad0f42f5506c609ec08c361e2c0093506724a6114732db1c67171c8561f25893c0dd5c0c1d62e8a726712216d9b45973585c9f7  ld.so.conf
"
