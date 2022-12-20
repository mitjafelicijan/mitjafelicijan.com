---
title: Handling big worlds in Godot by splitting and lazy loading chunks of it
url: handling-big-worlds-in-godot.html
date: 2022-10-11
draft: true
---

**Table of contents**

1. [Handling lazy loading in 2D world](#handling-lazy-loading-in-2d-world)
   1. [Player movement](#player-movement)

Because these examples are exported from **Godot to WebAssembly** and the packaging produces **large files**, you will need to **click to lazy load them**

I have seen a couple of examples on the net, but never really a comprehensive guide how this would be achieved. My solution is nowhere perfect, but it will get you started. This code is also not optimized, so buyer beware.

For the sake of simplicity, I will keep the terrain plain. I have been working on a terrain generation tool in my spare time, but due to the other obligations, that project was put on the back burner. If you however interested in it you can check it out on my personal Git repository [https://git.mitjafelicijan.com/village-creator.git/](https://git.mitjafelicijan.com/village-creator.git/).

![Village Creator](/assets/godot-dynamic-tile-loading/village-creator.png)

It's using a node system to generate a terrain mesh, and it's utilizing cellular automata for special effects like sand erosion and wind erosion, etc. Example of using cellular automata rule in an image below.

![Cellular automata](/assets/godot-dynamic-tile-loading/cellular-automata.png)

As I mentioned previously, still far away from being useful. Always, enough about that. Let’s move on to the topic of this post.

## Handling lazy loading in 2D world

To simplify things, we will try doing in 2D world first. It makes for a simpler exercise and eliminates a lot of complexity that comes with additional axis.

### Player movement

First, we need to take care of player movement. I will not go into many details here, since there are plenty of good tutorials on this topic on the interwebs. Suffice it to say, I created a [KinematicBody2D](https://docs.godotengine.org/en/stable/classes/class_kinematicbody2d.html) node that gives us goodies like `move_and_slide` and added input maps for [move_up, move_down, move_right, move_left] movement.

```gdscript
# Player2D.gd

extends KinematicBody2D

# Exported variables.
export var speed = 300

# Utility variables for later use.
# Can be ignored for now.
export var player_scale = 1
export var camera_zoom = 1

# Internal variables.
var velocity = Vector2.ZERO

func _ready():
	# Can be ignored for now.
	$Model.scale = Vector2(player_scale, player_scale)
	$Camera.zoom = Vector2(camera_zoom, camera_zoom)

# Executes on every physics frame (60, 144, etc).
# This game has vsync enabled.
func _physics_process(delta):
	handle_player_movement()

# Handles player movement.
func handle_player_movement():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1

	# Make sure diagonal movement isn't faster.
	# Therefore vector needs to be normalized.
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
```

[Read more about vector normalization.](https://www.fundza.com/vectors/normalize/)

`$Model` is just a sprite loaded and positioned into the scene. For the background, I again loaded just a normal sprite and positioned it to center. This makes it easier to test if the movement is working properly. Background will be removed when we will start dynamically loading the world.

<video src="/assets/godot-dynamic-tile-loading/2d-player-movement.webm" controls></video>

Code for player movement can be [downloaded from my Git server](https://git.mitjafelicijan.com/big-worlds-godot.git/snapshot/big-worlds-godot-55bcad79c11bd67e8268925d7edbf571aa31e3bf.zip).

<!--<div class="ll-iframe w-full h-80" data-src="/assets/godot-dynamic-tile-loading/example1/"></div>-->
