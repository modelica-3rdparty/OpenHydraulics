OpenHydraulics
==============

The hydraulics library is a free Modelica library that can be used to model hydraulic
components and circuits.  Hydraulic circuits are commonly used in modern machinery,
especially where very large power density is required.  Examples include earth-moving
equipment, farming and forestry equipment, and manufacturing.  More recently hydraulics
is also used in automotive and transportation for energy recuperation in hydraulic
hybrid drivetrains.

The library built up in a modular fashion, starting from basic fluid phenomena modeled
in the "Basic" package.  These basic models are then combined into models for hydraulic
components (Cylinders, Lines, MotorsPumps, Sensors, Valves, Volumes).  Finally, these
components are incorporated into example circuits, such as a pressure compensated load
sensing circuit.  To develop your own model, it is best to start from a model in the
"Circuits" package and modify it to fit your needs.
