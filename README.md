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

  * git clone [OpenSSL, tested w/ v1.1.1e-DEV](https://github.com/openssl/openssl) into a local folder. I switched the branch to the latest in the v1.1.1 branch.
  * git clone [openssl-x86_x64](https://github.com/sridharb1/openssl-x86_x64) into another folder. 
  * Copy the contents of the build folder of openssl-x86_x64 into the openssl tree.
  * This depends on the statically compiled [zlib, tested w/ v1.2.11](https://github.com/madler/zlib). zlib has excellent support for Visual Studio and native solution/project files can be found in the zlib\contrib\vstudio\vc14 folder. I use the zlibstat project in my compilation of openssl. I put the zlib folder at the same level as my openssl folder.
  * Open the openssl1_1.sln in Visual Studio. Select the platform/configuration (like
    x64/Release) and compile.
    
## Note ##

  * As the original project evolves, there is a possibility that these
project files can get out of date, specifically when files are
added/deleted. Usually, this can be easily fixed by examining the
errors when compiling.
  * Differences from openssl1_1: 
      * My philosophy was to create a project that would deliver just the VS solution/project files and allow people to fetch from github the version of openssl that they wanted to compile (and keep that up-to-date) separately. 
      * Kelvin delivers both the openssl code and the project files as a package.
      * I use references (including to zlib) and to the internally generated libraries instead of specifying them in the input area of linking. 
      * I also simplified his project a great deal to remove what I didn't need (for e.g. supporting older versions of Visual Studio, DLL builds etc.).
      * I use static libraries compiled with CRT DLL runtime. All other targets were deleted to keep the project simple.
      * I do want to acknowledge the beautiful framework that Kelvin has created to compile openssl natively in all the formats that one can imagine.
