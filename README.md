![Preview](Preview/demo.gif)

# Introduction
This is a game prepared by a team of four individuals for a hackathon in 24 hours. We did not have any prior knowledge of game development but we somehow pulled it off within three days of rigorous learning.

## Implementation Details
A lot of design considerations were made while making this. We used pushdown automaton, an advanced version of FSM (Finite State Machines) to control the character state. Our main character can only hold one state at a time at any given time. The action and animation for the key presees are determined by the state the character is currently in. 

Tilemaps were used for 2D level design and our artist personally drew some of the tiles himself with no prior knowledge of game development.

We chose godot as our game engine for its simplicity and performance. The node based system boosted our development time by a mile.

# Installation
## Requirements
[Godot 4.x Game Engine](https://godotengine.org/download/macos/)

## Steps
- `git clone https://github.com/Its-NEO/CARV/`
- Open this folder in GODOT
- For windows/linux machines press `Ctrl-B` and for Mac OS press `Cmd-B`

**Note: This is not the final version for this game. Many bug fixes and features were lost by accident.**

