# Kepler 55
  
### An endless space adventure
#### &nbsp;&nbsp;&nbsp;&nbsp;Made by [@dguido1](https://github.com/dguido1), [@ecorona9](https://github.com/ecorona9) & [@quyen-tsai](https://github.com/quyen-tsai)
<br/>&nbsp;&nbsp;&nbsp;&nbsp;Built with [GoDot](https://godotengine.org), an open source game engine
#### &nbsp;&nbsp;&nbsp;&nbsp;For CPSC 254 (Software Development with Open Source Systems) at [***California State University Fullerton***](http://www.fullerton.edu/)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Spring 21'

---

## Table of contents
* [Kepler 55](#kepler-55)
  * [Play](#play)
  * [Features](#features)
  * [Development](#development)
    * [Player](#player)
    * [Enemies](#enemies)
    * [Meteors and Enemies](#meteors-and-enemies)
    * [Main Menu](#main-menu)
  * [Demo](#demo)
  * [Credits](#credits)
***

## Play 

#### &nbsp;&nbsp;&nbsp; 1. &nbsp; Download [`kepler-55.exe`](https://github.com/dguido1/kepler-55/blob/main/kepler-55/Exports/kepler-55.exe), the latest version of the game
#### &nbsp;&nbsp;&nbsp; 2. &nbsp; Locate & open the file
<br>

![ezgif com-optimize](https://github.com/dguido1/kepler-55/blob/main/kepler-55/demos/kepler-55-demo.gif)

---

## Features
* Dynamically generated enemies & environment via randomization
* Intuitive A.I. that responds appropriately to player actions
* Range of projectile speed provides a continuous challenge
* Immersive parallax background

---

## Development

### Player
![5](https://user-images.githubusercontent.com/47490318/136456145-9aab6a74-7345-4b5c-9807-2dac45612ed2.gif)
* Four different sprites are used for simple animation: turn left, right, gas on and idle
* Two particle systems are used for exhaust effect: one smoke, one flame
     * Particle systems size now scales with user input when gas is pressed / released

* Player bullets collide with: enemies, meteors and enemy bullets <br> <br>
![ezgif com-gif-maker(5)](https://user-images.githubusercontent.com/47490318/136456326-ffe1a672-353a-4ff9-b08e-a59f509529a5.gif)
     * ***Explosions:** Player now explodes on death. 4 pieces were matched to our ship's hex colors: white, green, blue. These four pngs now spawn, each with a random size when the ship explodes*

### Enemies
* Enemies move and rotate toward player
* Enemies shoot their own bullets in same direction as current global direction at a very slow rate <br> <br>
![ezgif com-gif-maker(6)](https://user-images.githubusercontent.com/47490318/136458291-47e2239c-c6e4-400e-8fe0-9393033b4624.gif)
     * ***Bullets:** Bullet sizes are now dynamic, scaling with each respective enemies random initialization size. A bigger random size during initialization causes bullet scale to also have a larger range during initialization*

### Meteors and Enemies

- Meteors now spawn with a random direction: left-up, left and left-down and a random rotation and keep these values for the full duration of their lifetime

**Randomization:**
* Random speed 
* Enemies and meteors now spawn from 5 different random initial initialization positions. Spawn time or amount aloud at one time is controlled by each of their respective timers in the game scene
* Four enemy colors: green, blue, red, orange 

**Explosions:**
* Enemies and meteors now explode on death ○ Explosion sizes (enemy and meteor) are now dynamic Scales with enemy or meteor random initialization size. A bigger random size during initialization causes a greater chance of the explosion containing larger scaled pieces
* Enemy explosion colors are now dynamic, matching their parent’s random initialization color index: 1, 2, 3 or 4
<br><br>
![ezgif com-gif-maker(8)](https://user-images.githubusercontent.com/47490318/136461152-c3008db2-cb7d-42b7-aee8-9976f025e5d9.gif)
     * *Monster & meteor creation is dynamic, meaning speed and size is random. Explosions and enemy projectiles scale with the corresponding parent object they spawn from*<br><br>

### Main Menu 
![main-menu](https://user-images.githubusercontent.com/47490318/136454300-77004cd4-301b-491a-9b10-d44a87960c2e.gif)

***
<br>

## Demo

![ezgif com-optimize](https://github.com/dguido1/kepler-55/blob/main/kepler-55/demos/kepler-55-demo.gif)
### &nbsp;&nbsp;&nbsp; Can you conquer space!?
##### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Monster & meteor creation is dynamic, meaning speed and size is random<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Explosions and enemy projectiles scale with the corresponding parent object they spawn from

### &nbsp;&nbsp;&nbsp; Game over, try again!
![ezgif com-optimize](https://github.com/dguido1/kepler-55/blob/main/kepler-55/demos/game_over.png)

---
<br>


## Credits
<br>

| Author | Email | GitHub Profile |
| --------------- | --------------- | --------------- |
| David Guido | dguido1@csu.fullerton.edu | [@dguido1](https://github.com/dguido1) |
| Eric Corona | @csu.fullerton.edu | [@ecorona9](https://github.com/ecorona9) |
| Qyen Tsai | paultsai1999@csu.fullerton.edu | [@quyen-tsai](https://github.com/quyen-tsai) |


<br><br>


***

<br/>
Thanks for reading!<br/><br/>
 
If you like what you see give this repo  
a star and share it with your friends.

Your support is greatly appreciated!<br/><br/>

<br/><br/>

