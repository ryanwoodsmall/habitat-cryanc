# cryanc

**Crypto Ancienne: TLS for the Internet of Old Things**

This is a Habitat build of _cryanc_,
which includes a cURL-like client program called `carl` that can also act as a pre-`CONNECT` HTTP/HTTPS proxy.
This allows nice things like simple proxying and TLS termination for browsers with old security stacks.

Addtionally, the included `cryan.c` and `cryan.h` header files using _libtomcrypt_ can be used as a small TLS library.
The `carl` binary is static, compiled with musl libc.

## links
- https://github.com/classilla/cryanc
- https://github.com/libtom/libtomcrypt
