# MultiAircraftCollisionAvoidance
Repo for the implementation of a Multi-Aircraft Collision Avoidance project in MATLAB.

In this project, we will design and implement a deterministic controller in MATLAB that prevents collisions between multiple aircrafts in a 3D discrete grid. We consider N aircrafts, each of them is an instance of the Aircraft model whose goal is going from a starting to a destination position in the grid. Each aircraft has the starting and destination positions as distinguish properties. 
Our goal is to design a deterministic synchronous reactive component Controller that, when composed with the models of the aircrafts:

AircraftSystem = Controller∣∣Aircraft1∣∣Aircraft2∣∣⋯∣∣AircraftN
