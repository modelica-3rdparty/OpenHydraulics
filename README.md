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

Download [OpenHydraulics v1.0.1 (2013-01-19)](https://github.com/cparedis/OpenHydraulics/archive/v1.0.1.zip)

#### Release notes

* [Version 1.0.1 (2013-02-26)](https://github.com/cparedis/OpenHydraulics/archive/v1.0.1.zip):
 * Release with improved package structure

* [Version 1.0 (2013-01-15)](https://github.com/cparedis/OpenHydraulics/archive/v1.0.zip):
 * Initial release, tested with Dymola2013FD01

## License

Licensed by Georgia Institute of Technology under the Modelica License 2.

Copyright (C) 2008-2013, Georgia Insitute of Technology

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the customised *Modelica License 2*.

For license conditions (including the disclaimer of warranty) see `OpenHydraulics.UsersGuide.ModelicaLicense2`.

## Development and contribution

You may report any issues with using the [Issues](https://github.com/cparedis/OpenHydraulics/issues) button.

Contributions in shape of [Pull Requests](https://github.com/cparedis/OpenHydraulics/pulls) are always welcome.
