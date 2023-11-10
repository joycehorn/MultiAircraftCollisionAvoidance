
# MultiAircraftCollisionAvoidance
Repo for the implementation of a Multi-Aircraft Collision Avoidance project in MATLAB.

In this project, we are designing and implementing a deterministic controller in MATLAB that prevents collisions between multiple aircrafts. We consider $N$ aircrafts whose goal is going from a starting to a destination position in the grid. Our goal is to design a deterministic synchronous reactive component Controller that, when composed with the models of the aircrafts, the resulting model is invariant with respect to the AircraftSafety property, which states that all the aircrafts, except at the starting and destination positions must be at least two cells away from each other. 

Here's a breakdown of the key components and requirements:

**Aircraft Model:**

 - Instances of the Aircraft model move in a 3D discrete grid.
- Each aircraft has a starting and destination position.
- Movement is parallel to the axes of coordinates with a speed limit.
- Aircraft follows only one direction in the same clock cycle.
- Vertical movements are allowed with the same speed constraints as horizontal and depth directions.

**Aircraft Interface:**

- States include the current position of the aircraft (x, y, z).
- Inputs are instructions from the controller about the coordinates of the next position to go if there is a collision risk.
- Outputs include the current position and the desired position to approach the destination.

**Controller:**

- The deterministic synchronous reactive component ensures the safety property.
- The composition of the Controller and Aircraft models results in the AircraftSystem model.
- The safety property (AircraftSafety) enforces a minimum distance between aircraft.

**Simulation:**

- Conducted on a uniform time step over the three-dimensional grid.
- Starting and destination positions are on the ground (z coordinate is 0).
- Aircraft can move up to a speed of K steps per clock cycle.
- Aircraft may stay in the same position, and there are no obstacles in the grid.

**Safety Property:**

- Ensures that, at any time step, aircrafts are at least two cells away from each other.
