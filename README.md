# sDNA+: Spatial Design Network Analysis plus

This is the open source fork of the formerly proprietary sDNA+ software - all the sDNA features plus hybrid metrics. 

sDNA+ was created by Crispin Cooper on behalf of [Cardiff University](https://www.cardiff.ac.uk).  Alain Chiaradia was responsible for the initial idea, and Chris Webster for the initial funding and project mentoring. We are grateful to various parties for financial contributions towards  development: in no particular order, Hong Kong University, Tongji University, the UK Economic and Social Research Council, BRE, Wedderburn Transport Planning. Also research contributions in kind from Arup Ltd, WSP Global Engineering, BuroHappold and Sustrans. 

If you are interested in sponsoring changes to sDNA, please get in touch with Crispin cooperch@cardiff.ac.uk.

Copyright rests with Cardiff University and the code is released under GPL version 3.

## For Users

### Installation

Builds under VS 2015 not available:



In the interim you can download the old sDNA software from the [sDNA website](https://sdna.cardiff.ac.uk/sdna/). This requires a free serial number, also available on the website. Note that free serial numbers now unlock ALL features including the previously proprietary sDNA+ features.


### Use

Use the software via any of the following means:

* QGIS 2.14 (not 3 just yet)
  * as well as installing sDNA, you will need to install the sDNA QGIS plugin from the QGIS plugins dialog.
* ArcGIS 10.2 onwards
* Most products in the Autocad family 
  * Autocad interface can process shapes only, no attached data. 
  * For processing attached data, export/import to shapefiles from Autocad Map3d
* Add the `bin` folder to your path and use sDNA command line scripts
* Use the Python interface `sdnapy.py`; look at `runcalculation.py` for the reference example of how to do this

### Documentation

At the present time the best source of documentation is the manual hosted on the [sDNA/sDNA+ website](https://www.cardiff.ac.uk/sdna). If you build the project yourself, a copy of the docs will also be built from source in the repository.

### Support

Please see the original project [support page](https://www.cardiff.ac.uk/sdna/support/).

If filing a bug, please file to the database here on github. 

## For Developers

### Building the software

#### Buidling James' fork on github.  
 - Fork the repo
 - Click the actions tab in your fork
 - Clcik the compile action on the left
 - Click run action (selecting the chosen branch - main is tested) on the right
 - The action attempts to cache geos and boost.

#### Building James' fork locally

 - Install (the) Visual Studio 2022 (installer).  Community edition is fine.
 - In the VS 2022 installer, ensure there is a desktop C++ development, with vcpkg and both the Windows 11 and Windows 10 sdks.
 - Clone the repo locally.
 - Run vcpkg integrate install (in the repo root dir?), to let VS 2022 both launch vcpkg, and put the locations vcpkg installs the deps in vcpkg.json on to the include paths.  vcpkg might install boost twice, but shouldn't have to download it again thereafter.
 - Open /sDNA/sdna_vs2008/sdna_vs2008.vcxproj
 - Click build.




Build requirements:

* [Microsoft Visual C++ professional 2015](https://my.visualstudio.com/Downloads?q=%22Visual%20Studio%20Professional%202015%22)  
* Boost C++ libraries [version 1.83 (MSVC 14.0)](https://sourceforge.net/projects/boost/files/boost-binaries/1.83.0/boost_1_83_0-msvc-14.0-64.exe/download)

First download [geos 3.11.2](https://download.osgeo.org/osgeo4w/v2/x86_64/release/geos/geos-3.11.2-1.tar.bz2) ([source code](https://download.osgeo.org/geos/geos-3.11.2.tar.bz2) ).  

Run .\build_release.bat

Extract or open the geos archive, copy geos_c.dll, and (as professionally as possible) paste it  in `\output\release\x64` (next to `sdna_vs2008.dll`)

Cd into the `\bin` folder and run the python entry scripts to run.

To package for release: add everything in `\output\release` to a .zip archive.

### Project Structure

Some key folders:

* `sDNA` - C++ projects
  * `sdna_vs2008` - the core sDNA dll
  	* `tests` - tests of the above
  * `geos`, `muparser` - dependencies of `sdna_vs2008`
  * `sdnacomwrapper`, `sdnaprogressbar`, `registersdna` - respectively wrap the core sdna dll, provide a progress indicator and register the COM components on installation, all for Autocad
* `arcscripts` - originally just for ArcGIS, now also comprises the QGIS, Python and command line interface
  * `bin` - command line tools
  * `sdnapy.py` - python interface
  * `sDNAUISpec.py` - defines user interface for both ArcGIS and QGIS
    * ArcGIS interprets this via `sDNA.pyt`
    * QGIS code to interpret this is found in the [QGIS sDNA Plugin](https://plugins.qgis.org/plugins/sdna/)
* `autocadscripts` - visual lisp interface for Autocad
* `installerbits` - extras needed to create install package
* `docs` - documentation

### Tests

For testing the core network processing and numerical routines, fire up the `sdna_vs2008.sln` solution in `sDNA\sDNA_vs2008`. 
You will need the correct debug settings; unfortunately Visual Studio stores these with user information. Copy `sdna\sdna_vs2008\sdna_vs2008.vcproj.octopi.Crispin.user.sample` on top of your own `sdna_vs2008.vcproj.yourmachine.yourusername.user` file.
Set build configuration to `Debug Win32`, and run. This calls scripts in `sDNA\sDNA_vs2008\tests` and diffs the output with correct outputs (the core of which are originally hand computed) in that directory. Any call to `diff` that shows differences is a test fail.

For `test_parallel_results.py` to work, you also need to build the `parallel_debug Win32` configuration. When `Debug Win32` is run as described above, serial and parallel results are compared to check they are identical.

Interfaces are not automatically tested, though `arcscripts\sdna_environment.py` can be tested by `environment_test.py`.

## License

The bulk of sDNA Open is licensed under GNU GPL v3, with various other Free licenses for various modules. For full details see [licensing](LICENSE.md).
    

