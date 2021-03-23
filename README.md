# openssl-x86_x64
Native Visual Studio solution/projects to compile openssl on Windows x64 and x86, Release and Debug

# Background #
openssl supports compiling on Windows. However, it uses a
perl/makefile type solution that does not give the ability to compile
for x64/x86/Release/Debug with the same project files, needing
configuration, moving generated executables to separate folders, not
being able to recompile upon demand etc.

# Compiling #
This project provides native Visual Studio solution/project files that
can be used to compile openssl on Windows. This was heavily based on
work done by [Kelvin Lee](https://github.com/kiyolee) found at
[openssl1_1](https://github.com/kiyolee/openssl1_1-win-build).

I used Visual Studio 2019 Community Edition.

# Installation #

  * git clone [OpenSSL, tested w/ v1.1.1j-DEV](https://github.com/openssl/openssl) into a local folder. I switched the branch to the latest in the v1.1.1 branch.
  * git clone [openssl-x86_x64](https://github.com/sridharb1/openssl-x86_x64) into another folder. 
  * Copy the contents of the build folder of openssl-x86_x64 into the openssl tree.
  * This depends on the statically compiled [zlib, tested w/ v1.2.11](https://github.com/madler/zlib).
  * Use my [zlib-x86_x64](https://github.com/sridharb1/zlib-x86_x64)
    to compile on Windows. See instructions in that repository.
  * Open the openssl1_1.sln in Visual Studio. Select the platform/configuration (like
    x64/Release) and compile.
  * `openssl version -a`
    ``` shell
    OpenSSL 1.1.1j  16 Feb 2021
    built on: Mon Mar  9 13:34:30 2020 UTC
    platform: VC-WIN64A
    options:  bn(64,64) rc4(8x,int) des(long) idea(int) blowfish(ptr)
    compiler: cl /Zi /Fdossl_static.pdb /MT /Zl /Gs0 /GF /Gy /W3 /wd4090 /nologo /O2 -DL_ENDIAN -DOPENSSL_PIC -DOPENSSL_CPUID_OBJ -DOPENSSL_IA32_SSE2 -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_MONT5 -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DKECCAK1600_ASM -DRC4_ASM -DMD5_ASM -DAESNI_ASM -DVPAES_ASM -DGHASH_ASM -DECP_NISTZ256_ASM -DX25519_ASM -DPOLY1305_ASM
    OPENSSLDIR: "C:\Program Files\Common Files\SSL"
    ENGINESDIR: "C:\Program Files\OpenSSL-1_1\lib\engines-1_1"
    Seeding source: os-specific
    ```
  * Please verify that the version of openssl corresponds with the
    Platform/Configuration chosen. Specifically, ensure that the
    platform reported by openssl corresponds with that chosen in
    VS. For e.g. x64 in VS should correspond to VC-WIN64A reported by
    openssl and x86 corresponds to VC-WIN32. Sometimes, it might not
    because libcrypto-1_1.lib is not recompiled. Force it to recompile
    by doing a rebuild all or more specifically, rebuild this project.
    
## Note ##

  * As the original project evolves, there is a possibility that these
project files can get out of date, specifically when files are
added/deleted. Usually, this can be easily fixed by examining the
errors when compiling.
  * Differences from [Kelvin Lee](https://github.com/kiyolee)'s [openssl1_1](https://github.com/kiyolee/openssl1_1-win-build): 
      * My philosophy was to create a project that would deliver just the VS solution/project files and allow people to fetch from github the version of openssl that they wanted to compile (and keep that up-to-date) separately. 
      * Kelvin delivers both the openssl code and the project files as a package.
      * I use references (including to zlib) and to the internally generated libraries instead of specifying them in the input area of linking. 
      * I also simplified his project a great deal to remove what I didn't need (for e.g. supporting older versions of Visual Studio, DLL builds etc.).
      * I use static libraries compiled with CRT DLL runtime. All other targets were deleted to keep the project simple.
      * I do want to acknowledge the beautiful framework that Kelvin has created to compile openssl natively in all the formats that one can imagine.
