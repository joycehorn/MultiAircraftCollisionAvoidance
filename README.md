
# MultiAircraftCollisionAvoidance
Repo for the implementation of a Multi-Aircraft Collision Avoidance project in MATLAB.

In this project, we are designing and implementing a deterministic controller in MATLAB that prevents collisions between multiple aircrafts. We consider $N$ aircrafts whose goal is going from a starting to a destination position in the grid. Our goal is to design a deterministic synchronous reactive component Controller that, when composed with the models of the aircrafts, the resulting model is invariant with respect to the AircraftSafety property, which states that all the aircrafts, except at the starting and destination positions must be at least two cells away from each other. 

The project has two versions: Version 1 (version1 folder) and an improved Version 2 (vversion2 folder).

## Table of Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Version 1 (v1)](#version-1-v1)
  - [Version 2 (v2)](#version-2-v2)

## Getting Started

### Prerequisites
Ensure you have MATLAB installed on your system.

### Installation
Clone the repository:
```bash
git clone https://github.com/joycehorn/MultiAircraftCollisionAvoidance.git
```

## Usage

### Version 1 (v1)

To run the simulation for Version 1, use the run_v1(source, target) function specifying sources and targets (arrays of x,y,z coordinates for the initial and final positions of all aircrafts):

```
run_v1([0, 0, 0; 0, 1, 0; 1, 0, 0], [10, 10, 0; 5, 5, 0; 2, 2, 0]);
```

Here three aircrafts will be instantiated:
- aircraft1 has source (0,0,0) and target (10,10,0)
- aircraft2 has source (0,1,0) and target (5,5,0)
- aircraft3 has source (1,0,0) and target (2,2,0)

To add more aircrafts, include additional 3d points for source and destination, making sure to set the z coordinate to 0 (the code asserts that):

```
run_v1([0, 0, 0; 0, 1, 0; 0, 2, 0; 0, 0, 0; 2, 2, 0; 4, 4, 0], [5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0; 5, 5, 0]);
```

To let the simulation choose random source and target positions for a specified number of aircrafts, run the following commands in sequence, defining numebr of aircrafts (N) and grid size (grid_size) wanted:

```
N=12
grid_size=15
run_v1([round(grid_size * rand(N, 2)), zeros(N, 1)], [round(grid_size * rand(N, 2)), zeros(N, 1)])
```

### Version 2 (v2)

To run the simulation for Version 2, use the run_v2(source, target) function specifying sources and targets, similarly to how you run the v1 code.
