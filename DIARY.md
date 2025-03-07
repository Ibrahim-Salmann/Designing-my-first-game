My Project diary

---Mohammad Ibrahim Salman---

created: 30/10/2024


Entry: 05/11/2024

For my initial stage of development, I will create a Game Design Document (GDD),
That will serve as a blueprint for the development team and helps ensure everyone involved has a clear understanding of the project.
My GDD will include: Game Overview, Story and Setting, Gameplay Machanics, Level Design, Characters and Enemies, and User Interface (UI).

I will be writting my GDD while simultaneously woring on the inital phase of the game, that is importing the assets.
And more importantly start preparing right away. 
Having a idea of what the game will look like, I will proceed with creating nodes as this engine accommodates developere if there were a change in vision, like moving from a 2-D game to a 3-D one.
For this projet, I will be developing 2-D game for the sake of a first time developer.

As for the GDD, I will make a word documnet and store it in the Documnets Folder with the Project Plan.
, while importhing the gaming assets from open source websites.
I will make notes on new information I read, tasks I preformed, and where I will be needing to go.


Imprted the assets.

I may seen like I have imported too much, though there are two reasons for that:
	1) Some pacakes include a varity of textures, characters, and objects to use, thus there'll be more options for decorating the levels when constructing the Nodes and the Scenes{I'll explain later}.
	2) If there are assets that I end up not using, I'll probaly remove them.
	
The assets are from open source websites whare are as follows:
	1) https://itch.io/game-assets/free/tag-top-down
	2) https://opengameart.org/

In Godot, a node is a fundamental building block with a specific function (e.g., Sprite, Audio, Script) that represents an element of game logic or behavior.
A scene is a collection of nodes arranged in a tree hierarchy, allowing complex objects or environments to be created and reused throughout the game.
This structure promotes modularity and simplifies the development process


I resolved an issue with sound asset imports in Godot that were causing errors on Windows.
The problem stemmed from macOS-specific metadata files (__MACOSX folders and ._ files) embedded in the sound pack, which Windows couldn’t interpret correctly.
These extra files were purely metadata that macOS adds, and they aren’t actually needed for the game. 
I deleted the unnecessary files and re-imported the sound assets directly, clearing up the import errors.
It’s a good reminder of the platform differences that can sneak into asset management!


Entry: 12/11/2024

Today, I delved into what a Game Design Document (GDD) truly is and the essential role it plays in game development.
Essentially, a GDD is a comprehensive blueprint for a game, detailing everything from the big-picture vision to the smallest mechanics, ensuring that all team members are aligned and that ideas are consistently documented.

The GDD’s outline usually includes several sections: 
1. Introduction, which sets the tone and goals of the project;
2. Game Overview, where the game concept and target audience are outlined;
3. Gameplay, explaining the core mechanics and controls;
4. Story and Narrative, describing the storyline and key themes;
5. Characters, detailing the main protagonists, antagonists, and any supporting NPCs;
6. Levels and Environments, breaking down each game location and its unique features;
7. User Interface (UI), outlining the menus and HUD elements;
8. Art and Visuals, discussing the style, colors, and overall aesthetic;
9. Audio, which covers the music, sound effects, and ambient sounds;
10. Technical Details, specifying the game engine, platform requirements, and technical constraints;
11. Marketing and Promotion, where target audiences and marketing strategies are planned;
12. Budget and Schedule, estimating costs and setting deadlines.

So far, I’ve drafted sections on the Introduction, Game Overview, Gameplay, Story and Narrative, Levels and Environments, and User Interface (UI).
Each of these sections is shaping up well, helping to solidify the core design and establish the game’s atmosphere.
Yet, there’s still more to cover, like Characters—which will bring depth to our protagonist and NPCs—and Art and Visuals, where I’ll outline the game’s stylistic direction.
The Audio section also needs fleshing out to set the right ambiance. Lastly, the Technical Details, Marketing and Promotion, and Budget and Schedule will round out the GDD, giving it the structure needed to take Wimbledon’s Lot from concept to reality.

Entry: 13/11/2024

Today marks a milestone: I finally completed the remaining sections of the Game Design Document for Wimbledon’s Lot.
Adding depth to the Characters section brought our protagonist and NPCs to life, giving each a unique story and purpose in the game world.
The Art and Visuals section now clearly defines the game’s stylistic direction, inspired by vibrant, retro 32-bit graphics, ensuring a consistent visual atmosphere.
Audio is carefully outlined to set the perfect ambiance, from sound effects to atmospheric music.
I finished with the Technical Details, Marketing and Promotion, and Budget and Schedule sections, giving the GDD a robust, well-rounded structure.
Now, it’s a complete document, ready for others to read and envision Wimbledon’s Lot as a reality.

Entry: 17/11/2024

Created a new branch called player1.0 to focus on developing the main playable character.
Began by designing the protagonist that the player will control. First, I imported the character's idle animation, which consists of 7 frames, and increased its resolution for better visual quality.
Then, I set up a scene named Player (Idle) using a Node, where I incorporated the idle animation.
Additionally, I added an oval-shaped Collision Node to the scene to enable the character to interact with and collide with objects in the game world.

In the Game node, which includes player(idel), and the newly created camera in which is how the player will see the character they will be controlling.
Ran a successful animation. 

Gnerating the script for the movement of the player, the engine generated the basic movement for the player as this:
	
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	However, I changed the script to accomodated for the vertial movement of the player as for my intentions of the game I invisioned.
	My code:

extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction for both horizontal and vertical movement
	var input_vector = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# Normalize the direction to avoid diagonal speed being faster
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
	
	# Set the velocity based on the input
	velocity.x = input_vector.x * SPEED
	velocity.y += input_vector.y * SPEED  # If adding vertical movement directly

	# Move and slide with the updated velocity
	move_and_slide()
	

My first bug: When I run the program the character should move and jump, yet it would not respond to any keyboard input.

Fixed the bug:
	Realized the issue was caused by mistakenly adding another CharacterBody2D node inside the existing Player node.
	This redundancy confused the script as it couldn't determine which node to control.
	After removing the extra CharacterBody2D node and ensuring the script was properly attached to the correct Player node, the character movement now works as expected. A good reminder to double-check the node structure before troubleshooting!
	

Updated the character image to a new set that includes animation frames for both horizontal and vertical movements, replacing the previous set that only supported horizontal motion.
This change allows for smoother and more dynamic animations, making the character's movement feel more natural and responsive in all directions. 

Reorganized my assets into clearly labeled and easily identifiable folders to improve efficiency.
This new structure eliminates the need to shuffle through multiple folders to locate the required assets, streamlining the workflow and saving time during development.

I need to work on the following:
	- Create animations for player movement in all directions.
	- Determine if additional assets are needed for weapon usage and death scenes.
	- Evaluate whether these assets are freely available or behind a paywall due to complexity.
	- Address any bugs encountered during the process.
	- Focus branch player1.0 on idle and run animations for player movement only.
	
Entry: 26/11/2024

I worked extensively on fixing and improving the player movement in my game.
Initially, I encountered several issues where the player character wouldn't move despite no errors or warnings in the script.
After detailed debugging, I realized the importance of properly setting up the node hierarchy and physics properties.
Specifically, I adjusted the CollisionShape2D and StaticBody2D nodes, ensuring they had the correct configurations and physics layers/masks to interact correctly.

I also rewrote the player.gd script to handle Zelda-style movement, adding logic to normalize input vectors for smooth diagonal movement and ensuring the move_and_slide() function worked as intended.
I clarified my understanding of input mapping in the project settings and confirmed the use of ui_left, ui_right, ui_up, and ui_down for movement.

Through this process, I learned to integrate animations properly by adding AnimationPlayer nodes and connecting them to player movement, ensuring seamless transitions between states like idle and running.
Lastly, I organized the code in the existing player.gd script rather than creating a new one, maintaining clarity and avoiding duplication.

Still trying to figure out the movement of the player and being able to controll the character.
All animations of idle, run, and attack are made facing all directions (death animantion will be implimented when creating enemies).
As off now, I'm getting the controlls working.

Got the controlls working. However I was able to perfom the basic movement of the idle animation.
The run animation and the attack (which I will soon impliment wll come about later), is yet to be implimented.
Also, need to get rid of a bug where the collision shape 2D sprite is still on the character while moving.

Fixed the bug  where the collision shape 2D sprite is still on the character, by turning off the visibility under the Inspector tab.

Entry: 03/12/2024

Going to finish the character movement controlls.

Successfully implemented animation switching for my character in Godot!
Here’s a summary of how I achieved it:
	
	To make the character play "Run" animations when moving (using WASD inputs) and transition to "Idle" animations when no input is provided,
	while retaining the last movement direction.
	
	Node Setup:
		Added an AnimatedSprite2D node as a child of my Player node.
		Loaded the necessary animations into the AnimatedSprite2D, including:
			Idle animations: Idle_left, Idle_right, Idle_up, Idle_down.
			Running animations: Run_left, Run_right, Run_up, Run_down.
		
	Script Setup:
		Attached a script to the Player node.
		Declared constants and variables:
			SPEED to control movement speed.
			animated_sprite to reference the AnimatedSprite2D.
			last_direction to track the last direction of movement for idle animations.
			
	Movement Logic:
		Used Input.get_action_strength to detect WASD inputs and calculate the movement vector.
		Normalized the vector to ensure consistent speed in all directions.
		Used move_and_slide() to move the character.
		
	Animation Switching:
		Created a get_direction function to determine the character’s direction (left, right, up, or down) based on input.
		Implemented a handle_animation function:
			Played the "Run" animation when the character was moving.
			Played the appropriate "Idle" animation when the character stopped, using last_direction to determine which idle animation to show.
			
	Debugging and Fixing Indentation Issues:
		Encountered a mixed tab/space indentation error.
		Resolved it by converting all indentation to tabs for consistency.
		
	Outcome:
		The character now:
			Transitions smoothly between "Run" animations while moving in any direction.
			Remains in the correct "Idle" animation when no input is detected.
			Retains the last movement direction for idle animations

Now to start creating the world.
There are many places and levels to create, but for now I'm going to start with the mai hub, where you first interact with the game.

I will be adding more assets for the world building and level design.

As of now, I am setting up the terrain.

16/02/2025

Today was a big day for my game development project!
I finally managed to wrap my head around creating tile sets and paths in Godot Engine.
It was a bit of a journey, but I'm thrilled with the progress.

First things first, I created a new scene and added a `TileMap` node, which is the foundation for building the game world. 
The magic really happens in the Inspector tab.  I started by selecting a `TileSet`.
This is where I define all the individual tiles that make up my terrain.

Creating the `TileSet` involved a few key steps.
I added "matching corners and edges," which is crucial for smooth transitions between different terrain types. 
This prevents jarring visual glitches and makes the world look much more polished. I then added a new terrain type, which I cleverly named "Grass."
This is where I'll define how grass tiles behave and look.

The real fun began when I imported my "overworld" file.
This file contains a huge collection of tiles – not just grass, but also buildings, water, and all sorts of decorative elements that will bring my game world to life.
It’s like a treasure trove of artistic assets!

Next, I selected the "Grass" terrain type within my `TileSet`.
I then switched to the "Paint" tool and, under the "Terrains" section, I could actually *paint* the terrain onto my `TileMap`.
I chose my desired grass color and started laying down the foundations of my world. 
It felt incredibly satisfying to see the landscape taking shape.

Now, for the tricky part: creating paths. 
I'm still figuring out the most elegant way to handle this, but for now, I'm manually drawing the paths using the tile painting tools. 
I’m thinking about using a separate tile layer for the path so that I can easily edit it later without affecting the surrounding terrain.  I might even explore using Godot's navigation system for more dynamic pathfinding, but that's a challenge for another day.

The process of creating the path was quite manual. 
I selected the appropriate path tiles from my overworld file and carefully painted them onto the tile map, trying to create smooth curves and natural-looking transitions. 
It took some time and patience, but the result is starting to look pretty good.

The beauty of Godot's tile system is its flexibility. 
I can easily add more terrain types, customize their properties, and paint them onto the map.
I can also create different layers for things like foreground elements, background details, and even interactive objects.  This layering system is essential for creating complex and visually rich game worlds.

I’m excited to continue experimenting with tile sets and paths.
I want to explore different techniques for creating more dynamic and interesting level designs.
Perhaps I'll even look into procedural generation to create vast and varied landscapes automatically.
The possibilities seem endless!

23/02/2025

Today, I focused on populating my overworld with the basic building blocks of its environment: 
the regular grass tiles. After setting up the `TileSet` and terrain types yesterday, 
it was time to put those tools to practical use.

I opened my `TileMap` scene and made sure I had the "Grass" terrain selected in the Inspector. 
Then, with the "Paint" tool active, I began laying down the foundation of the landscape. 
It was a simple process, but it felt incredibly satisfying to see the world start to fill out.

I paid attention to creating a natural-looking distribution of grass, avoiding overly uniform patterns. 
I varied the density and placement of the tiles to give the terrain a more organic feel. 
I also made sure to leave space for other elements like paths, buildings, and water features, 
which I'll be adding later.

The process was quite therapeutic, almost like digital gardening. I could see the overworld 
taking shape, and it gave me a better sense of the scale and layout of the game. 
I also realized the importance of planning the terrain layout early on, as it will 
influence the placement of other game elements.

I'm getting more comfortable with Godot's tile system, and I'm looking forward to adding 
more variety to the landscape. I'm thinking about incorporating different shades of grass, 
as well as some subtle variations in tile placement to create a more visually 
interesting environment.

I also ventured into adding water tiles to my overworld, bringing a new dimension to the landscape. 
It was exciting to see how the water features transformed the overall look and feel of the map.

First, I imported the water tiles into my `TileSet` and defined a new terrain type for them. 
I experimented with different water tile variations to find the right aesthetic, 
settling on a combination of deep water and shallow water tiles.

Then, I carefully painted the water tiles onto the `TileMap`, creating lakes, rivers, and ponds. 
I tried to create natural-looking shorelines and varied the depth of the water to give it a sense of realism. 
I made sure to leave enough space for bridges and other decorations that I plan to add later.

Adding the water tiles made the overworld feel much more dynamic and interesting. 
The reflections and subtle animations of the water added a layer of visual depth that was previously missing.

I also started planning the placement of bridges and other decorations. 
I want to create a world that feels both natural and functional, 
with clear paths and points of interest. I'm thinking about adding things like:

* Wooden bridges spanning rivers and lakes.
* Small docks and piers along the shorelines.
* Rocks and vegetation along the water's edge.
* Maybe even some floating objects or creatures in the water itself.

I'm excited to see how these decorations will further enhance the overworld. 
I'm also thinking about adding interactive elements to the water, 
such as fishing spots or hidden underwater areas.

The process of adding water tiles and planning decorations has been a lot of fun. 
It's rewarding to see the overworld come to life, tile by tile. 
I'm looking forward to continuing to build and refine the world, 
adding more details and interactive elements as I go.

25/02/2025

Improved the water tiles to create rivers, by adding more tiles to the already created water with grass tileset.

26/02/2025

Today was all about expanding the overworld and laying the groundwork for key locations.
I spent a good chunk of time painting tiles to create a much larger landscape.
This included adding cliffs along certain edges, which instantly added verticality and visual interest.

I also mapped out areas where bridges would connect different sections of the map, ensuring smooth player traversal.
I'm visualizing wooden bridges spanning narrow ravines and stone bridges crossing wider rivers.

Most importantly, I began to define the area where the player's house will be located.
It'll serve as a central hub, potentially offering save points, a merchant, or even the starting point of the adventure.
I'm focusing on making this area visually distinct, perhaps with a small clearing or a unique terrain feature.

The sheer scale of the landscape is becoming apparent, and it's exciting to imagine the player exploring every corner.
I'm carefully considering the placement of each tile, ensuring the world feels both natural and purposeful.

Today,I tackled the challenge of creating bridge tiles that seamlessly integrate with the overworld, without clashing with the existing grassland tiles.
It was a meticulous process, but the results are definitely worth the effort.

The key was to create a separate `TileMap` node specifically for decorations, which I named "TileMap_Decorations."
This allowed me to paint bridge tiles (and other decorative elements) on top of the base grassland layer without causing any overlap or visual glitches.
It's like having two separate canvases stacked on top of each other, where I can paint on the top layer without affecting the bottom one.

In Godot, this is achieved by using multiple `TileMap` nodes and managing their Z-index (their stacking order).
By placing the "TileMap_Decorations" node above the main grassland `TileMap` node, I ensured that the bridge tiles would always appear on top.

Painting the bridge tiles was a delicate process.
I had to carefully align them with the edges of the grassland tiles, ensuring a smooth and natural transition.
It was like painting on a real canvas, where every stroke mattered. My mouse became my paintbrush, and the `TileMap` was my canvas, and I meticulously placed each tile.

It was a bit tedious, I'll admit.
But I know this attention to detail is crucial for creating a polished and immersive game world.
I'm willing to put in the grind to make sure everything looks just right.

The ability to layer `TileMap` nodes in Godot is incredibly powerful.
It allows for a great deal of flexibility and control over the level design.
I can now add all sorts of decorations, from bridges and fences to rocks and trees, without worrying about them interfering with the base terrain.

I'm starting to see the overworld come to life, and it's incredibly rewarding.
Each tile I place brings me one step closer to creating a playable game.
I'm excited to see how it all comes together in the end.

01/03/2025

Today, I embarked on the challenging task of adding cliff tiles to my overworld,
transforming the landscape with dramatic elevation changes.
The vision was to have the main hub situated atop a cliff, with multiple cliff mountings allowing the player to ascend and descend.
It was a grand idea, but the execution proved to be quite the undertaking.

Constructing the cliffs was far more complex than I anticipated.
The overlapping of tile sets caused numerous headaches.
I found myself constantly deleting and erasing tiles, trying to achieve a clean and seamless look.
Managing the different layers of cliff tiles was particularly difficult.
There were instances where the grass tiles wouldn't align properly with the cliff edges, requiring me to painstakingly erase and redraw them. It felt like I was constantly battling the tiles, trying to force them into place.

At one point, I had to completely start over with the cliff construction.
The tiles were simply refusing to cooperate, and the result was a messy and disjointed landscape.
It was frustrating, but I knew I couldn't compromise on the quality of the terrain.
So, I took a deep breath and began again, carefully placing each tile and meticulously adjusting the layers.

After hours of painstaking work, I finally managed to create the cliffs I envisioned.
The main hub now sits proudly atop a towering cliff, with multiple pathways leading up and down.
It's a significant improvement, and I'm proud of the effort I put in.

Now, I'm moving on to the next stage: adding waterfalls, more cliff variations, and, most importantly, collision.
The collision is crucial for defining the boundaries of the world and preventing the player from walking through solid objects.
I'll need to create invisible walls along the cliff edges and around other obstacles.

I also plan to add more decorations to the main hub, making it feel more lived-in and inviting.
And, of course, I need to ensure that the character's movement is smooth and responsive.
The collision and movement mechanics are fundamental to the gameplay experience, and I want to get them right.

Today's work was a testament to the challenges of game development.
It's not always glamorous, and there are times when you have to grind through tedious tasks.
But the satisfaction of seeing your vision come to life makes it all worthwhile.

Following the work on the cliff terrain and hub area,
I decided to test the scene in-game.
That's when I encountered a rather glaring issue: the player was completely invisible! 
After a bit of digging, I realized the problem stemmed from the scene hierarchy.
The player node, created early in development, was hidden behind the tilemap layers, effectively rendering it invisible.

To rectify this, I opted for a cleaner approach.
I removed the old player node and instantiated the player scene as a direct child of the main scene.
This simple change brought the player into view, correctly positioned above the tilemap. Finally, I could see my character moving within the hub!

However, this fix introduced a new challenge.
While the player was now visible and responsive, the camera remained stubbornly static. This was a critical oversight.
A static camera would break the player's immersion and make exploration cumbersome.
My next task was clear: implement a camera follow script.

The goal is to create a smooth, responsive camera that tracks the player's movements seamlessly.
Furthermore, the camera must respect the collision boundaries I've established.
It should stop moving when the player encounters an invisible wall, preventing the player from seeing beyond the playable area. Revealing the unfinished edges of the world would ruin the illusion of a complete and immersive environment.

This transition from terrain construction to camera implementation highlights the iterative nature of game development.
Each step forward reveals new challenges, requiring constant problem-solving and refinement. Now, I'm diving into scripting the camera follow, aiming for a smooth and polished player experience.

06/03/2025

Dear Diary,

I continued to refine the overworld, focusing on adding waterfalls and further sculpting the cliff terrain.
The core concept driving my design is creating a cohesive and contained hub world.
I want to establish clear boundaries, preventing the player from venturing beyond the intended playable area. 
This is a common practice in 2D game design, especially in games that emphasize exploration within a defined space.

Think of it like creating a diorama or a miniature world.
You carefully construct the scenery within a box, and you want t empty space beyond. In my case,
the cliffshe viewer to appreciate the details within that box, not the and invisible walls serve as the "box," defining the limits of the player's exploration.

I'm being meticulous in placing each tile, ensuring that the water flows naturally, the cliffs rise convincingly,
and the transitions between different terrain types are seamless. It's akin to painting on a canvas, where every brushstroke contributes to the overall composition.
I'm focusing on the minute details, making sure that each water tile fits perfectly, and that the cliff edges are sharp and defined.

The idea is to create a sense of immersion, where the player feels like they're exploring a real, tangible place.
The boundaries, though invisible, are meant to be felt. The player should intuitively understand where they can and cannot go,
without encountering jarring transitions or empty spaces.

I've also been considering the placement of future decorative elements. Rocks, lily pads, and other details will add depth and visual interest to the water features.
These elements will further enhance the sense of realism and create a more engaging environment.

Collision is another crucial aspect of this process. I need to define the physical boundaries of the world,
preventing the player from walking through walls or falling off cliffs.
This will ensure that the player's movement feels grounded and responsive.

Finally, I'm looking forward to adding the houses and NPCs that will populate the hub world. These elements will bring the world to life,
adding narrative and gameplay depth.
I'm almost finished with the terrain itself, and I'm excited to move on to these more interactive and narrative-driven aspects of the game.

I'm pushing my skills to the limit, striving to create a polished and immersive game world.
The process is demanding, but the satisfaction of seeing the world take shape is incredibly rewarding.

A significant milestone today! I've finally completed the base terrain of the main hub world. 
Every cliff, every waterfall, and every stretch of grassland is now in place. 
All that remains is to breathe life into the scene through decorations. 

I'm starting with the water features, adding rocks and lily pads to break up the monotony 
and create a more natural look. After that, I'll scatter rocks across the land, adding 
further visual interest. These simple decorations will go a long way in making the world 
feel more lived-in. 

With the terrain complete, I can now focus on the crucial task of implementing collision, 
ensuring the player interacts with the world as intended.

I then embarked on the exciting task of decorating the hub world, bringing it to life with trees, rocks, and various foliage.
The goal is to create a visually rich and immersive environment, filled with natural details.

For smaller, repeating elements like bushes and fences, I'm continuing to use the tile painting method.
This allows for precise placement and seamless integration with the existing terrain.
I've created dedicated tile sets for these decorations, ensuring they blend harmoniously with the overall aesthetic.

However, for larger, more distinct objects like trees, rocks, and logs, I'm taking a different approach.
I'm utilizing the drag-and-drop functionality of the tile panel.
This allows me to place these objects directly into the overworld, arranging them in natural patterns and clusters.
It's like sculpting the environment, placing each object with care and consideration.

The key to this process is understanding the layering system within Godot.
I'm placing these decorations on the "TileMap_Decorations" layer, which sits above the base terrain layer.
This ensures that the objects appear on top of the ground tiles, preventing any visual overlap or glitches.
If I were to place these objects on the same layer as the terrain, they would be subject to the tile grid's limitations,
resulting in unnatural and potentially overlapping arrangements.

This layering technique provides a great deal of flexibility and control.
I can easily rearrange or remove decorations without affecting the underlying terrain.
It also allows me to create depth and visual variety, adding a sense of realism to the environment.

In the future, I plan to add even more decorative elements, further enhancing the overworld's visual appeal.
I'm excited to see how these details contribute to the overall atmosphere and immersion of the game.
