# Hello Debian Package
This is an example repository for automatically building a Debian package file.
## Build Process
In this example, the source code is *main.c*. The build process uses CMake, producing an
executable file named *Hello_Debian_package* and a corresponding Debian package file
*Hello_Debian_package_0.0.1.deb*.
Below is the command to initiate the build process:
```
$ ./scripts/build.sh
```
This script configures and compiles the source code, producing key outputs including a
compiled C++ binary file and a Debian package file. The generated Debian package file will be
*Hello_Debian_package_0.0.1.deb*, located under the *./build/deb* directory. You can locate
the package file with the following command:
```
$ find . -name *.deb
```
## Installation
To install the generated Debian package, you can use the `apt` package manager as follows:
```
$ sudo apt install ./build/deb/Hello_Debian_package_0.0.1.deb
```
## Execution
Finally, you can execute the installed program with this command:
```
$ /opt/Hello_Debian_package/bin/Hello_Debian_package
```
This command should print `Hello, World!` to the console, demonstrating that the package
has been successfully built, installed, and run.

**Contributor**:
- cory <corkang913@gmail.com>