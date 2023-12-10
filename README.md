
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
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites
Ensure you have MATLAB installed on your system.

### Installation
Clone the repository:
```bash
git clone https://github.com/joycehorn/MultiAircraftCollisionAvoidance.git

