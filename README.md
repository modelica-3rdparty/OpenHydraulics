# OpenHydraulics

The hydraulics library is a free Modelica library that can be used to model hydraulic
components and circuits.

## Library description

 Hydraulic circuits are commonly used in modern machinery,
especially where very large power density is required.  Examples include earth-moving
equipment, farming and forestry equipment, and in manufacturing.  More recently hydraulics
is also used in automotive and transportation for energy recuperation in hydraulic
hybrid drivetrains.

The library is built up in a modular fashion, starting from basic fluid phenomena modeled
in the "Basic" package.  These basic models are then combined into models for hydraulic
components (Cylinders, Lines, MotorsPumps, Sensors, Valves, Volumes).  Finally, these
components are incorporated into example circuits, such as a pressure compensated load
sensing circuit.  To develop your own model, it is best to start from a model in the
"Circuits" package and modify it to fit your needs.

## Current release

Download [OpenHydraulics v2.0.0 (2022-10-14)](../../releases/tag/v2.0.0)

#### Release notes

* [Version 2.0.0 (2022-10-14)](../../releases/tag/v2.0.0):
  * This new version of OpenHydraulics is a non-backwards compatible release based on the Modelica Standard Library version 4.0.0 which contains a series of improvements and bug fixes. 
  * Incorporated fixed provided by: xxx
  * Fixed non-standard or illegal Modelica syntax constructs.
  * Removed outdated annotations.
  * Fixed faulty annotations.
  * Removed the Utilities package since the contained functions are available from the Modelica Standard Library.
* [Version 1.0.1 (2013-02-26)](../../releases/tag/v1.0.1):
  * Release with improved package structure
* [Version 1.0 (2013-02-19)](../../releases/tag/v1.0):
  * Initial release, tested with Dymola2013FD01

## License

### Version 2.0.0

This Source Code Form is subject to the terms of the 3-Clause BSD license.

A copy of the license is available in the [library repository](LICENSE).

Copyright &copy; 2022 Chris Paredis and contributors.

### Version 1.0 and 1.0.1

Licensed by Georgia Institute of Technology under a modified Modelica License 2.

Copyright &copy; 2008-2013, Georgia Insitute of Technology

## Development and contribution

You may report any issues with using the [Issues](https://github.com/cparedis/OpenHydraulics/issues) button.

Contributions in shape of [Pull Requests](https://github.com/cparedis/OpenHydraulics/pulls) are always welcome.
