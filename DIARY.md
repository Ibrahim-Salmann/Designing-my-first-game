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

11/03/2025

A quick but important fix today.
I noticed some of the tile map patterns, especially when viewed up close, appeared blurry.
It's a small detail, but it significantly impacts the overall visual quality.
I'll need to revisit the tile set textures and ensure they're optimized for the intended resolution.
Sharp, crisp tiles are essential for a polished look.

Seems like altering the Rendering Quandrant Size under the inspection tab fixed this issue.

The hub world is slowly transforming into a vibrant tapestry of nature.
Trees stand tall, huts nestled amongst the foliage, and flowers bloom in colorful clusters. Stones dot the landscape, and lily pads float serenely on the water's surface.
Each element, carefully placed, adds another layer of depth and charm. I could lose myself in this decorative dance, endlessly arranging and refining.
But the time has come to shift gears, to delve into the core mechanics that will breathe true life into this world.

The collision system now beckons, a crucial step towards a playable game.
The decorative phase, while fulfilling, is merely a prelude.
I must now build the invisible walls, the tangible boundaries that will define the player's experience.
It's a daunting task, but one I must embrace.

There's a nagging thought, though, a whisper of unfinished business. The waterfalls, fountains, and even the humble puddles of water – they yearn for movement, for animation.
Flags should flutter in the breeze, fountains should dance with water, and puddles should ripple with life.
This is a challenge for another time, a layer of polish that will add a touch of magic to the world. But for now, collision takes precedence.

The pressure is mounting. The final report looms, a testament to my dedication and progress.
I must pull myself together, channel my focus, and transform this beautiful canvas into a functional, engaging game.
It's a race against time, a test of my abilities, but I'm determined to see this through. The hub world, my creation, will come to life.

A wave of pure, unadulterated frustration washed over me today, threatening to drown my entire project.
I swear, sometimes this game development process feels like a cruel, twisted joke.
I was on the verge of progress, finally diving into the collision implementation on a fresh, clean branch. But fate, it seems, had other plans.

As soon as I switched to the new branch, a horrifying sight met my eyes: devastation.
My meticulously crafted decorations, the trees, the bushes, the houses – all reduced to gaping, maddening question marks.
It was as if a digital vandal had swept through my world, erasing everything I'd painstakingly placed. A pit of dread opened in my stomach. How? How could this have happened? I combed through the Git history, searching for clues, but found nothing. Just a gaping void where my decorations once stood.

I felt a surge of anger, a burning resentment towards the fickle nature of technology. Hours of work, vanished in an instant.
The meticulous placement, the careful consideration of each element – all for naught. It was a gut punch, a brutal reminder of the fragility of digital creations.

Now, I'm forced to backtrack, to return to the main branch and salvage what I can. I'll painstakingly recreate the decorations, ensuring every tree and bush is in its rightful place.
I'll commit and push, securing my work against the digital gremlins that seem determined to sabotage my efforts. And then, only then, will I dare to venture back into the collision branch.

It's a tedious, infuriating setback. But I refuse to be defeated. I'll rebuild, I'll persevere, and I'll emerge from this ordeal stronger.
The collision implementation will be done, the game will be built, and I'll prove that even the most frustrating glitches can't extinguish my determination.
The decorations are going back, I will get this right. One. Tile. At. A. Time.

"IMPORTNAT NOTE"

A cold dread settled over me today, a chilling mix of terror and frustration that I wouldn't wish on my worst enemy.
I attempted the seemingly simple task of merging my beautifully decorated world-building-1.0 branch into main. A task that should have been a triumphant step forward, instead spiraled into a nightmare.
The decorations, the carefully placed trees, rocks, and huts, simply refused to transfer. It was as if they were ghosts, fading into the digital ether.

I tried again, and again, tweaking, re-merging, but the results were the same. A sense of panic began to rise.
Then, the unthinkable happened. I opened Godot, and my game scene was gone.
Not just the decorations, but the entire scene, replaced by a stark, terrifying error message. It was a digital death knell. My heart pounded in my chest. Had I lost everything? Was my game, my creation, truly gone?

The error messages were a cryptic language of corrupted files and syntax errors, a chaotic jumble of technical jargon that seemed to mock my efforts.
I felt a wave of despair, a sense of utter helplessness. I turned to the digital oracle, ChatGPT, seeking answers, seeking salvation. It suggested I delve into the raw text of the game.tscn file, a daunting task for a weary developer.

But before I plunged into the abyss of code, I remembered the output debugger.
I opened it, my eyes scanning the lines, searching for the source of the catastrophe. It was a tedious process, a hunt for a needle in a digital haystack. And then, I found it. A series of misplaced equal signs, a missing bracket, tiny errors that had brought my world to its knees.

I opened the game.tscn file in Visual Studio Code, the raw, unedited heart of my scene.
The file, a complex structure of nodes and properties, was a testament to the intricate workings of Godot.
Each node, each property, carefully defined, held the key to my game. I painstakingly corrected the errors, carefully placing each bracket, each symbol, hoping against hope that I was restoring order to the chaos.

And then, miraculously, the scene loaded. But the victory was bittersweet. The decorations, the fruits of my labor, were gone.
Only the bare bones of the terrain remained. The TileMap_Decorations layer, the canvas upon which I had painted my world, was empty.
I felt a wave of exhaustion, a sense of having climbed a mountain only to find myself at the bottom again.

Collision implementation, the task that had seemed so daunting before, now felt like a distant dream.
I'm creating a new branch, decorate-world-building-decorations, and I will re-decorate.
I will add every tree, every rock, every hut, every single detail that was lost. I will rebuild my world, tile by painstaking tile.

The report deadline looms, a constant reminder of the pressure I'm under. But I will not be deterred.
I will not give up. I will rebuild, I will persevere, and I will create a game that I can be proud of.
This setback, though devastating, will not define me. I will rise from the ashes, stronger and more determined than ever.

As I began the painstaking process of redecorating, I noticed something peculiar.
When I went to the TileMap_Decorations node and examined its TileSet in the Inspector, the tileset.tres file was indeed present.
However, the tiles representing the trees and huts, sourced from separate tile sets, were still displaying those infuriating question marks.
It was a cruel twist, a reminder that the gremlins were still lurking.
After some thought, I decided against creating yet another branch for decorations.
The constant branch switching was clearly contributing to the chaos.
Instead, I'll commit to the main branch for all decoration-related work.
This simplifies the workflow and hopefully minimizes the risk of further mishaps.
Once the decorations are fully restored, I'll create a dedicated branch for collision implementation, keeping those critical mechanics isolated and secure.

19/03/2025

Today was a bit of a wrestle, but I think I've finally got the camera sorted (mostly).
I spent a good chunk of time trying to get it to follow the player smoothly in my top-down overworld.
Initially, it was just… stuck. Turns out, a simple zoom issue was throwing me off completely.
Who knew such a small thing could cause so much frustration?

After fiddling with the Camera2D node's properties, and a lot of double-checking my player's movement script, I managed to get it working.
The player moves, and the camera follows, which is exactly what I wanted. It's a relief to have that hurdle cleared.
Though, I'm still not entirely convinced it's perfect. I might need to tweak the smoothness and maybe add some subtle camera shake later on, just to give it a bit more life.
But for now, it's functional, and that's a win.

With the camera sorted, I'm finally moving on to fleshing out the rest of the overworld.
It's starting to feel more like a real game now. I've got a basic layout, but it's still pretty bare.
I need to add some more detailed scenery, maybe some NPCs wandering around, and definitely some points of interest.
This is where things are going to get more complex, and probably more time-consuming.

I'm also starting to think about the next steps beyond the basic layout.
Adding collision detection is going to be crucial, so players can't just walk through walls and objects.
And then there's the whole system for picking up items, managing an inventory, and interacting with the environment.
That's going to be a big undertaking, but I'm excited to dive into it.
I'm already brainstorming ideas for how to structure the inventory and how to make the item interactions feel intuitive.

I can feel the scope of this project expanding, and it's both exciting and a little daunting.
There's so much to do, but I'm determined to see it through. Each step, even the frustrating ones, feels like progress.
I'm learning so much, and I can't wait to see how this overworld evolves.

Alright, so things got a lot more… tangible today.
I spent a good portion of the afternoon tackling collision detection, and I've made some significant progress, but not without a few hiccups.

The main goal was to prevent the player from walking through the water and to keep them within the bounds of the main hub. 
I'm happy to report that the water collision is working! I added collision shapes to the water tiles, and now the player is properly blocked. 
It's a huge step towards making the overworld feel more solid and interactive.

However, I immediately ran into a rather annoying issue with the bridges.
It seems that the border tiles of the bridges are overlapping with the water collision shapes.
So, even though the bridges are visually above the water, the player is still being blocked as if they were trying to walk through the water itself.
I’ve temporarily disabled the collision on the bridge border tiles so I can cross them, but that's obviously not a permanent solution.
I need to figure out how to properly layer the collision shapes so that the bridges function correctly.
I suspect this might involve adjusting the Z-indices or possibly restructuring the collision shapes themselves.

Another thing I noticed is that the decorative elements, like trees, bushes, and houses, are lacking collision.
As a result, the player can walk right through them, which breaks the immersion.
I've got a "Decoration" node in my scene where all these elements reside, and I need to add collision shapes to each of them.
This is going to be a bit tedious, but it's essential for making the overworld feel believable.

I also need to address the out-of-bounds issue.
The player is currently confined to the main hub area, which is good, but I need to make sure they can't accidentally wander off into the void.
I'll need to add collision shapes along the perimeter of the hub to create a solid boundary.

So, to summarize, my immediate to-do list looks like this:
	Fix the bridge collision issue: Investigate and resolve the overlap between the bridge border tiles and the water collision shapes.
	Add collision shapes to the decoration nodes: Ensure that trees, bushes, houses, and other decorative elements have proper collision.
	Create out-of-bounds boundaries: Add collision shapes around the hub perimeter to prevent the player from leaving the playable area.
	
Despite the challenges, I'm feeling good about the progress.
The overworld is starting to take shape, and the collision detection is a major step forward.
I'm learning a lot about how collision shapes work in Godot, and I'm confident that I'll be able to resolve the remaining issues.
I'm excited to see how the overworld evolves as I continue to add more details and functionality.

Finally! The bridge issue is resolved.
I spent a good chunk of time wrestling with those collision shapes, and I'm relieved to have found a solution.
It was simpler than I initially thought, though. Instead of trying to fine-tune the existing collision shapes, I opted for a more straightforward approach.

I created alternative tiles specifically for the bridge sections. These tiles are visually identical to the original bridge border tiles,
but they don't have any collision shapes attached. I then went through the scene and replaced the original bridge border tiles with these new, collision-free versions.
Now, the player can smoothly cross the bridges without getting stuck or blocked by invisible collision.
It's a bit of a workaround, but it works perfectly for now.

With the bridge issue out of the way, I'm turning my attention to the decorative elements and the cliffs.
The overworld is starting to feel more populated, but it still lacks a sense of depth and solidity.
Adding collision to the trees, bushes, houses, and other decorations is the next priority.
I've already started adding CollisionShape2D nodes to these elements, and it's making a noticeable difference.
The player can no longer walk through them, which adds a much-needed layer of realism.

The cliffs are another area that needs attention.
They're currently just flat textures, but I want them to feel like solid, impassable barriers.
I'll need to add collision shapes to the cliffs as well, and I'm also considering adding some visual depth by using parallax scrolling or layering techniques.

I'm making steady progress, and the overworld is starting to feel more like a cohesive and interactive space.
There's still a lot to do, but I'm feeling good about the direction the project is heading.
Adding the collision and refining the boundaries has been a significant step forward, and I'm excited to see how the overworld evolves as I continue to add more details and functionality.

Okay, so I've reached a point where I need to make some strategic decisions.
While the basic overworld layout and collision detection are mostly complete, there are still some lingering details, like adding collision to all the decorations.
I've got houses and market stalls covered, but things like trees and smaller decorative elements are still lacking collision.

However, time is becoming a significant factor.
The end of term is looming, and I need to prioritize completing the core gameplay mechanics.
Therefore, I've decided to shift my focus to implementing the item pickup and inventory system.
The decorations, though important for immersion, can be addressed later.
Right now, I need to get the fundamental gameplay loop working.

I'm diving straight into programming the item pickup logic and the inventory system.
I've already started sketching out the data structures and UI elements I'll need.
My goal is to create a simple yet functional inventory system with slots for storing items.
I'm also planning to implement a basic pickup mechanism that allows the player to interact with items in the environment and add them to their inventory.

My primary objective is to get the main overworld level fully functional, even if it means sacrificing some of the decorative polish for now.
If I can achieve that, I'll then move on to creating a single dungeon level, applying the same gameplay mechanics and learning experiences from the overworld.
I believe that having at least one complete level will demonstrate my understanding of the concepts and be a sufficient deliverable for the project, especially given the time constraints.

I need to communicate this plan to my lecturer, explaining that while I aimed for a multi-level experience, I've prioritized completing a single, fully functional level to meet the core requirements of the project.
I hope they'll understand the time constraints and appreciate the effort I've put into creating a solid foundation for the game.

I'm feeling a bit pressured by the deadline, but I'm determined to make the most of the remaining time.
I'm confident that I can deliver a compelling gameplay experience, even if it's within a single level.
Let's get this inventory system working!

21/03/2025

Today, I took a deep breath and plunged into the next major phase of this project:
	implementing the item pickup and inventory system.
	To keep things organized, I created a new branch called items-inventory-implementation.
	It feels good to start fresh, knowing this is a critical step towards a functional game.

First, I created a scene called pickup-item.
Inside, I added a Node2D as the root, along with a Sprite2D and a CollisionShape2D as its children.
This scene will represent any item the player can pick up in the world.
I also created a new script called inventory_item.gd.
This script is where the magic happens, where I'll define the properties and behaviors of each item.
It's a bit technical, diving into the nitty-gritty of how Godot handles resources and scripts, but it's essential for a robust system.

To start, I created a new folder in my Product directory called resources.
Inside, I made a resource called gold_coin.tres.
This resource will hold the data for gold coins, including their sprite, name, and any other relevant information.
I connected this resource to the inventory_item.gd script, essentially linking the visual representation to its in-game logic.

Now, I'm starting to work on the inventory slots.
It's a bit of a slog, honestly. I'm definitely feeling the pressure of the crunch.
Time is slipping away, and there's still so much to do. It's frustrating when things don't come together as quickly as I'd like, but I'm trying to stay focused.

More than the technical challenges, I'm battling the mental ones. I'm trying to keep the demotivation at bay.
I don’t want to be shackled by the fear of disappointing others, or the pressure of feeling like this is my last chance to make things right.
I’m trying to focus on the process, on learning and building something I can be proud of, regardless of the outcome.
I need to keep reminding myself that progress, even slow progress, is still progress. I hope that even when things seem difficult, I can make something that will be impactful.

24/03/2025

Alright, diving deeper into the technical details of the pickup item system.
I want to make sure I'm documenting this thoroughly, both for my own understanding and in case I need to backtrack or troubleshoot later.
If I'm making any glaring technical blunders, I hope this log will help me catch them.

In the pickup-item.tscn scene, I started by adding two child nodes: a Sprite2D and a CollisionShape2D.
The Sprite2D is where I've created the visual representation of the gold coin pickup item.
I pulled the gold coin sprite from my assets folder and assigned it as the texture for the Sprite2D.
For the CollisionShape2D, I opted for a simple rectangle shape, as it seemed fitting for a small coin.

I then created a new resource called gold_coin.tres in the Product/Resources folder.
This resource essentially holds the data associated with the gold coin, such as the sprite texture.
I connected this resource to the inventory_item.gd script, which I mentioned earlier.
This script is responsible for managing the properties and behaviors of the coin once it's in the player's inventory.

Now, here's where things got a bit tricky. I noticed that the player wasn't consistently picking up the coin.
I suspect the issue lies with the CollisionShape2D and how it's interacting with the player's collision.
To address this, I'm planning to add another layer of collision detection.

My idea is to create a child Area2D node within the pickup-item scene, and then add another CollisionShape2D as a child of that Area2D.
The Area2D will allow me to detect when the player's collision area overlaps with the coin's pickup area.
I'll then connect a signal from the Area2D to the pickup-item node, triggering the pickup logic when the player enters the area.

Essentially, I'm creating a "pickup zone" around the coin, separate from the coin's physical collision shape.
This should give me more precise control over the pickup interaction.

I'm aware that this might seem a bit convoluted, but I'm hoping it will resolve the issue.
If anything goes wrong, I'm prepared to use git reset to revert to a previous state.
I'm documenting this process here so that I can easily retrace my steps and understand what went wrong if I need to.
I'm hoping that by creating this "pickup zone" using an Area2D that the player will be able to pick up the coin. I'm going to implement this now.

With the deadline looming, I'm bracing for an intense push.
My aim is to dedicate the next five days to finalizing the core gameplay elements.
This includes setting up essential features like equipment management, the user interface, weapon attacks, item dropping, configuring spell systems, enemy encounters, and seamless scene transitions between the main hub and the shop.
I'm planning regular progress check-ins to ensure I'm on the right track and to address any potential issues.

My hope is that this concentrated effort will result in a project that exceeds expectations, potentially earning above-average marks.
I must admit, I'm also experiencing some nervousness regarding the report and the overall evaluation.

However, I'm determined to maintain a positive and optimistic mindset.
This is my first significant project, and I'm aware that I'll likely face some criticism.
I'm hoping to learn from it, even if it's difficult, and use it to improve in the future.


Success! I've finally managed to get the player to successfully pick up the gold coin.
After a bit more debugging and tweaking, I pinpointed the issue and implemented a solution.
The key was in the player's Area2D node.
I connected the area_entered signal from the Area2D to the player's script.
Then, I wrote a function that would trigger the pickup logic when the player's Area2D overlapped with the coin's Area2D.
To ensure the player could interact with the coin, I also adjusted the collision layers and masks.
In the player's CollisionShape2D, I set the layer to "Player" and the mask to "PickupItem".
This effectively tells the game that the player should only interact with objects on the "PickupItem" layer.
The coin, of course, is on that layer.

This now means that the player can walk up to the gold coin, and the pickup logic is triggered.
This is a significant milestone, as it lays the foundation for all future pickup interactions.
I'm treating the gold coin as a standard template, which I can adapt for other items.
With the pickup functionality now working, I'm eager to move on to the inventory slot and other inventory-related mechanics.
Hopefully, I can make significant progress on that front in the coming days.

I am feeling a bit relieved that the pick up item works, and I am going to try to do the inventory slot and inventory items soon.
Hopefully it goes well.

Furthermore,  I focused heavily on building the inventory slot system.
I created a new scene called inventory_slot.tscn, which will serve as the visual representation of a single inventory slot.
The root node is a Panel, which will act as the background for the slot.
I then added four child nodes: NinePatchRect, MenuButton, CenterContainer, and TextureRect.

The NinePatchRect is used to display the background texture of the inventory slot, which I imported as a "fast box" texture.
This will give each slot a distinct visual appearance.
The TextureRect is used to display the item that is currently occupying the slot.
I adjusted the aspect ratio of the TextureRect to ensure that the items are displayed correctly within the slot.
The MenuButton and CenterContainer are placeholders for future functionality, such as item interaction and quantity display.

I've also imported a large number of assets for various UI elements, including dialogue boxes, inventory screens, and other visual components.
While I'm aware that some of these assets may not be needed in the final version of the game, I'm keeping them for now as a resource library.
I'll likely delete the unused assets later to keep the project organized.
I'm feeling more confident with the development pace now that I've made progress on the inventory system.
My primary goal remains to complete the first level of the game.
If time permits, I'll consider adding additional content or features, depending on the deadline and the flexibility I have.

06/04/2025

Today marked a significant step forward in the development of my project.
I spent a good portion of the day fleshing out the fundamental structure of the inventory system.
My primary focus was on visually representing individual inventory slots, and I opted for a hierarchical approach within the scene tree.

I began by creating a base structure for each slot.
This involved adding several child nodes, each serving a specific visual and potentially functional purpose.
I incorporated nodes that will clearly display the price of an item, ensuring this crucial information is readily available to the player.
Alongside this, I added nodes dedicated to displaying the name of the item occupying the slot, providing immediate identification.

To handle situations where multiple identical items might be present, I also implemented a stack label.
This will dynamically update to reflect the quantity of the item within that particular slot.
Finally, I included a button label within the slot structure.
While its immediate purpose might be visual feedback or a placeholder, it suggests future interactivity, perhaps for selecting, using, or examining the item.

Beyond the visual elements, I also started laying the groundwork for the underlying logic.
I created a script named inventory_slot.gd.
Within this script, I declared several onready variables.
These will serve as direct references to the child nodes I previously added in the scene.
This approach, leveraging Godot's signal/slot system, ensures efficient access to these visual elements from the script.

Furthermore, I utilized the @export keyword (or potentially export depending on the Godot version) to expose certain properties of the inventory_slot script within the editor's Inspector panel.
This will likely include a Vorte texture, which I envision as the visual representation of an empty slot or a background element.
I also anticipate using nine-patch textures (likely configured through a NinePatchRect node, though not explicitly mentioned) for the background of the slot, allowing for flexible resizing without distortion.

Following the creation of this foundational inventory_slot scene and script, I proceeded to instantiate and add several instances of these slots as child nodes to a higher-level inventory container (though the exact parent node wasn't specified).
Crucially, I then imported (likely using get_node() within the parent's script) references to these newly added inventory_slot nodes into the parent script.
This establishes the necessary connection, allowing the parent script to manage and interact with the individual inventory slots.

This feels like a solid initial step in building out the inventory system.
By focusing on creating reusable and well-structured slot elements, I've laid a foundation that should be relatively easy to expand upon.
The use of onready variables and potentially exported properties in the inventory_slot script will streamline the process of populating and updating the visual information within each slot.
This initial setup facilitates the next stage, where I can begin implementing the core logic for adding, removing, and managing items within these slots.
I'm optimistic about moving forward and implementing the actual item management in the near future.

While working on the visual representation of the inventory slots within the 2D editor, I noticed an issue.
Specifically, the initial setup resulted in the creation of twelve individual inventory slots directly within the inventory_slot.tscn scene itself.
This was not the intended approach, as inventory_slot.tscn should serve as a template for individual slots, not the container for multiple instances.
This oversight needs correction to ensure proper modularity and efficient management of inventory space.

Furthermore, I encountered an error related to the absence of a "Popper menu".
This suggests a planned UI element for potential contextual actions or information display related to inventory items.
However, this component hasn't been implemented yet, and I've decided to address it in a later stage to maintain focus on the core slot functionality.

Despite these minor hurdles, I moved forward by creating a new scene called inventory_ui.tscn.
This scene will serve as the primary container for the entire inventory UI.
As the root node of this scene, I added a CanvasLayer node.
CanvasLayer is a crucial node in Godot for UI elements, as it allows them to be rendered on a separate canvas, independent of the game world's camera and scaling.
This ensures that the inventory UI remains consistently sized and positioned on the screen, regardless of the viewport or camera settings.
This CanvasLayer will act as the drawing surface upon which all inventory-related UI elements, including the individual inventory slots, will be placed and managed.
This establishes a dedicated space for the UI, separating it cleanly from the game world and paving the way for further UI development.
More updates to come as I refine the slot instantiation and begin populating the inventory UI.

07/04/2025

Continued work on the inventory_ui.tscn scene today, focusing on its initial structure and basic visibility toggling.

The root CanvasLayer in the inventory_ui now has a ColorRect as a direct child.
This ColorRect, likely set to a red color, serves as a simple background or visual indicator for the inventory screen at this early stage of development.
Nested under the ColorRect is a MarginContainer.
MarginContainer nodes are essential for UI layout in Godot, providing consistent spacing and padding around their child elements.
This ensures that the content within the inventory screen isn't directly touching the edges, improving visual appeal and readability.

Within the MarginContainer, I've established a further nested structure.
This includes a NinePatchRect, which will likely be used to create a resizable background for the main inventory area without pixelation.
The use of a nine-patch texture allows for flexible scaling to accommodate different amounts of content or screen sizes.
Also within the MarginContainer is a VBoxContainer.
VBoxContainer nodes arrange their children vertically, making them ideal for stacking elements like the individual inventory slots.

To implement the basic functionality of showing and hiding the inventory screen, I created a script named inventory.gd
(referred to as "red scripts" in the original note, likely a temporary naming convention).
This script is attached to the root CanvasLayer of the inventory_ui scene.
Within this script, I've connected an input action – specifically, pressing the "Tab" key – to toggle the visibility of the inventory_ui.
This is a common and intuitive control scheme for accessing inventory in many top-down 2D games.

Interestingly, the previous implementation with 30 pre-existing inventory slots, which were toggled with a button pop-up, is still present in the project.
This suggests a potential transition or refactoring process where the new inventory_ui is gradually replacing the older system.
The inventory.gd script likely contains a function, perhaps named toggle_visibility, which is called when the Tab key is pressed.
This function would then manipulate the visible property of the CanvasLayer (or a relevant child node) to show or hide the entire inventory UI.

Looking ahead, the next steps involve populating this basic UI structure with the actual inventory items.
This will likely involve instantiating and adding the individual inventory_slot scenes as children of the VBoxContainer.
I also need to implement the logic for adding items to the inventory, handling item stacking to efficiently represent multiple identical items,
and visually presenting these items within the UI slots.

Beyond the core inventory, the project roadmap includes the development of weapon and resource management systems.
Finally, the goal is to integrate these systems into the action scene, allowing the player to equip weapons and utilize resources within the game world.
The current focus on establishing a clean and functional inventory UI is a crucial stepping stone towards these more complex gameplay mechanics in this top-down 2D game.

To provide a clearer picture, I've included snippets of the core scripts I've been working on.

First, the InventoryUI.gd script, attached to the root CanvasLayer of the inventory UI scene:
	
	extends CanvasLayer
	
	class_name InventoryUI
	
	func toggle():
		visible = !visible
		
This script is straightforward but crucial.
It defines the InventoryUI class and implements the toggle() function.
This function simply inverts the visible property of the CanvasLayer, effectively showing or hiding the entire inventory UI on the screen.


Next, the InventorySlot.gd script, which governs the behavior of each individual inventory slot (likely instantiated within the VBoxContainer of the inventory_ui):
	
	extends VBoxContainer
	
	class_name InventorySlot
	
	var is_empty = true
	
	var is_selected = false
	
	@export var single_button_press = false
	@export var starting_texture: Texture
	@export var start_label: String
	@onready var texture_rect: TextureRect = $NinePatchRect/MenuButton/CenterContainer/TextureRect
	@onready var name_label: Label = $NameLabel
	@onready var stack_label: Label = $NinePatchRect/StacksLabel
	@onready var on_click_button: Button = $NinePatchRect/OnClickbutton
	@onready var price_label: Label = $PriceLabel
	@onready var menu_button: MenuButton = $NinePatchRect/MenuButton
	
	var slot_to_equip = "NotEquipable"
	
	func _ready() -> void:
		if starting_texture != null:
		texture_rect.texture = starting_texture
		
		if start_label != null:
			name_label.text = start_label
			
		menu_button.disable = single_button_press
		on_click_button.disabled = !single_button_press
		on_click_button.visible = single_button_press
		
		var popup_menu = menu_button.get_popup()
		popup_menu.id_pressed.connect(on_popup_menu_item_pressed)
	
	func on_popup_menu_item_pressed(id: int):
		print_debug(id)
	

This script manages the visual elements within each slot.
It declares variables to track if the slot is empty or selected, and exports properties like single_button_press to control the UI interaction style (either a direct button or a menu).
@onready variables efficiently retrieve references to the various child nodes within the InventorySlot scene (TextureRect for the item icon, Labels for name, stack, and price, and Buttons for interaction).
The _ready() function initializes the slot's visual appearance based on the exported starting_texture and start_label.
It also configures the visibility and enabled state of the on_click_button and sets up the PopupMenu associated with the MenuButton, connecting the id_pressed signal to the on_popup_menu_item_pressed function for handling menu item selections.

The InventoryItem.gd script defines the data structure for individual inventory items:
	extends Resource
	class_name InventoryItem
	var stacks = 1
	
	@export_enum("Right_Hand", "Left_Hand", "Potions", "NotEquipable") var slot_type: String = "NotEquipable"
	@export var ground_collision_shape: RectangleShape2D
	@export var name: String = ""
	@export var texture: Texture2D
	@export var side_texture: Texture2D
	@export var max_stack: int
	@export var price: int

y extending Resource, InventoryItem instances can be easily created and stored, either within the game world or within the inventory data structure itself.
It includes properties such as stacks to manage item quantity, an @export_enum for slot_type to define where the item can be equipped (a common design pattern for equipment slots in RPGs), a ground_collision_shape for when the item is dropped in the world, a descriptive name, primary and potentially secondary textures (texture and side_texture), max_stack to limit the number of identical items in a single slot, and the item's price.

Finally, the Inventory.gd script (likely attached to a persistent game manager or the player node) handles the overall inventory logic and UI interaction:
	extends Node
	class_name Inventory
	@onready var inventory_ui: InventoryUI = $"../InventoryUI"
	func _input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("toggle_inventory"):
			inventory_ui.toggle()

This script retrieves a reference to the InventoryUI node using @onready.
The _input() function listens for specific input events.
In this case, it checks if the "toggle_inventory" action (configured in the Godot project settings) has just been pressed.
If so, it calls the toggle() function on the inventory_ui instance, making the inventory screen appear or disappear. This is a standard approach for handling player input and triggering UI changes in response to specific actions in a top-down 2D game.

And the PickUpItem.gd script, attached to interactable items in the game world:
	extends Area2D
	class_name PickUpItem
	
	@export var inventory_item: InventoryItem
	@onready var sprite_2d: Sprite2D = $Sprite2D
	@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
	# Called when the node enters the scene tree for the first time.
	func _ready() -> void:
		sprite_2d.texture = inventory_item.texture
		collision_shape_2d.shape = inventory_item.ground_collision_shape
	
This script defines how items in the game world can be picked up.
It exports an InventoryItem resource, allowing each pick-up item instance in the scene to be associated with specific item data.
In the _ready() function, it sets the Sprite2D's texture and the CollisionShape2D's shape based on the properties of the assigned inventory_item,
visually representing the item in the game world and defining its interaction area.

These scripts collectively form the basic framework for the inventory system, handling UI presentation, individual slot behavior,
item data, and player interaction for toggling the inventory screen and defining pick-up items.
The next steps will involve connecting these pieces to enable adding items to the inventory, managing stacks, and displaying the items within the UI slots.


I implemented the code responsible for dynamically generating the individual inventory slots within the inventory_ui.tscn scene.

This involved adding the following code block to the InventoryUI.gd script:
	
	@onready var grid_container: GridContainer = %GridContainer
	const INVENTORY_SLOT_SCENE = preload("res://Product/Scenes/UI/inventory_slot.tscn")
	@export var size = 8
	@export var colums = 4
	
	func _ready():
		grid_container.columns = colums
		
		for i in size:
			var inventory_slot = INVENTORY_SLOT_SCENE.instantiate()
			grid_container.add_child(inventory_slot)

Here's a breakdown of what this code achieves:

First, it uses @onready to get a reference to the GridContainer node within the inventory_ui scene, which I've named "GridContainer" (indicated by the % symbol).
GridContainer is an excellent choice for arranging inventory slots in a structured grid layout, common in many top-down 2D games.

Next, it uses preload() to efficiently load the inventory_slot.tscn scene into a constant named INVENTORY_SLOT_SCENE.
Preloading optimizes performance by loading the scene into memory when the InventoryUI script is loaded, rather than instantiating it multiple times on the fly.

I've also added two @export variables: size and colums.
size determines the total number of inventory slots to be created, and colums dictates how many slots will be arranged in each row of the grid. Exposing these variables in the Inspector allows for easy adjustment of the inventory grid dimensions without modifying the code directly, a good practice for game design iteration.

The _ready() function is called once when the InventoryUI node enters the scene tree.
Inside this function, I first set the columns property of the grid_container to the value of the exported colums variable, establishing the desired grid width.

Then, a for loop iterates size number of times.
In each iteration, it instantiates a new instance of the inventory_slot.tscn scene using INVENTORY_SLOT_SCENE.instantiate().
This creates a unique copy of the inventory slot template.
Immediately after instantiation, grid_container.add_child(inventory_slot) adds this newly created slot as a child of the GridContainer. This automatically arranges the slots in the defined grid layout.

The immediate result of adding this code is that when I run the game and press the Tab button to toggle the inventory UI,
it now appears populated with the specified number of individual inventory slots arranged in a grid. This is a significant step towards a functional inventory display.

Regarding previous issues, I recalled an error that occurred during initial testing related to the menu_button within the inventory_slot scene.
To resolve this for the time being and allow the game to run without crashing, I commented out the line menu_button.disable = single_button_press in the InventorySlot.gd script.
While this might temporarily disable the intended behavior of the menu button, it allows me to continue focusing on other core inventory functionalities.
I will revisit and properly address this commented-out line later.

With the inventory UI now visually populating with slots, my next priority is to implement the logic for adding items to these slots and handling stackable items.
This will involve connecting the item pick-up system with the inventory data and updating the UI accordingly.

10/04/2025

Today's focus was on a crucial aspect of inventory management: handling stackable items, like our ubiquitous gold coins.

The goal was to allow players to collect multiple instances of the same item and have them occupy a single inventory slot, displaying a quantity.

To achieve this, I revisited the Inventory.gd script and expanded its functionality.

First, I looked at the _on_area_2d_area_entered function (presumably within a player or inventory controller script), specifically the condition for picking up items:
	if area is PickUpItem:

	inventory.add_item(area.inventory_item, area.stacks)
	area.queue_free()

This snippet demonstrates the initial interaction with a PickUpItem in the game world.
When the player's pickup area overlaps with a PickUpItem, it calls the add_item function in the Inventory script, passing the inventory_item resource associated with the pickup and the number of stacks it represents.
Crucially, after the item is added to the inventory, the PickUpItem node is freed from the scene using queue_free(), removing it from the game world.

Now, let's delve into the Inventory.gd script and the logic for handling stackable items:
	extends Node
	class_name Inventory
	@onready var inventory_ui: InventoryUI = $"../InventoryUI"
	@export var items: Array[InventoryItem] = []
	
	func _input(event: InputEvent) -> void:
	 if Input.is_action_just_pressed("toggle_inventory"):
		inventory_ui.toggle()
		
	func add_item(item: InventoryItem, stacks: int):
	  if stacks && item.max_stack > 1:
		add_stackable_item_to_inventory(item, stacks)
	  else:
		items.append(item)
		# TODO: update ui
		
	func add_stackable_item_to_inventory(item: InventoryItem, stacks: int):
	  var item_index = -1
	  for i in items.size():
		  if items[i] != null and items[i].name == item.name:
			  item_index = i
			
	 if item_index != -1:
		var inventory_item = items[item_index]

		if inventory_item.stacks + stacks <= item.max_stack:
			inventory_item.stacks += stacks
			# TODO: update player_ui
		else:
			var stacks_diff = inventory_item.stacks + stacks - item.max_stack
			var additional_inventory_item = inventory_item.duplicate(true)
			inventory_item.stacks = item.max_stack
			# TODO: update player_ui
			additional_inventory_item.stacks = stacks_diff
			items.append(additional_inventory_item)
			# TODO: update player_ui
			
	else:
		item.stacks = stacks
		items.append(item)
		# TODO: update player_ui
		

The add_item function is the entry point for adding items to the inventory.
It first checks if the stacks count is greater than zero and if the item's max_stack property (defined in the InventoryItem resource) is greater than 1.
This condition identifies stackable items.
If an item is stackable, it calls the add_stackable_item_to_inventory function; otherwise, it simply appends the item to the items array (for non-stackable items).
A crucial # TODO: update ui comment highlights the need to refresh the inventory UI whenever the items array is modified.

The add_stackable_item_to_inventory function handles the core stacking logic.
It iterates through the existing items in the inventory to find if an item with the same name already exists.
If a matching item is found (indicated by a non-negative item_index):
It retrieves the existing inventory_item.
It then checks if adding the new stacks to the existing item's stacks would exceed the item's max_stack.
If not, it simply adds the stacks to the existing item's count and again, a # TODO: update player_ui reminds us to update the visual representation in the inventory slot.
If adding the stacks would exceed the max_stack, it calculates the stacks_diff – the number of items that would overflow.
It then duplicates the existing inventory_item using duplicate(true) to create a new additional_inventory_item (the true argument performs a deep copy, ensuring all properties are copied).
The original inventory_item's stacks are set to max_stack, and the additional_inventory_item's stacks are set to the stacks_diff.
Finally, the additional_inventory_item is appended to the items array, effectively creating a new stack in a separate inventory slot if the current stack is full.
Another # TODO: update player_ui is essential here.

If no existing item with the same name is found in the inventory, it means this is the first instance of this stackable item being added.
In this case, the item's stacks property is set to the incoming stacks value, and the item is appended to the items array.
Again, the UI needs to be updated.

To test this stacking mechanism, I duplicated the PickUpItem nodes in my game world.
I then modified their stacks property within the Inspector to represent different quantities: one with a stacks value of 12, another with 88, and a third with 20.
This allowed me to simulate picking up varying amounts of the same stackable item (like gold coins) and observe how the inventory system handles them.

During development, I encountered and resolved a couple of syntax errors.
I mistakenly typed inventory.add.item(...) instead of the correct inventory.add_item(...).
Additionally, I incorrectly used item.append(...) when I should have used items.append(...) to add elements to the items array (which is the inventory itself).
These small errors highlight the importance of careful syntax and understanding the context of variables and functions.

With this implementation, the inventory system can now correctly handle stackable items,
consolidating them into single slots and creating new slots when the maximum stack size is reached.
The next crucial step is to ensure the InventoryUI accurately reflects these changes whenever items are added or their stack counts are modified.
This will involve updating the labels within the InventorySlot scenes to display the current stack size.

Today's work on stackable items felt like another solid step forward, reinforcing my belief that even as a solo developer with limited resources, a functional game, even if just a single level, is within reach.

It strikes me that many development teams, whether crafting AAA titles or working in large independent studios, often begin by ensuring they have one polished and engaging level ready.

Considering that I am navigating this endeavor alone, utilizing public domain assets, and this project serves as my introduction to both game development and the Godot engine, the progress feels particularly rewarding.

My workspace, an old laptop with constrained storage, presents its own set of challenges, though I offer this not as a complaint but as a description of my current reality.

The sedentary nature of coding, the prolonged periods spent staring at a screen, certainly aren't conducive to an ideal workflow.

To counter this, I've found solace and a change of scenery by working in a public cafe.

There, I can punctuate coding sessions with slow sips of coffee, allowing my gaze to wander and observe the world around me, providing moments to contemplate life beyond graduation, my aspirations, and dreams, all while the murmur of strangers' conversations fills the background.

For those more intense coding sessions, particularly while implementing the stackable item logic within the inventory script, I immerse myself in "The Autobiography of Malcolm X" as narrated by Laurence Fishburne, allowing his powerful story to occupy my mind while my fingers fly across the keyboard.

I sincerely hope this project serves as a genuine introduction to the broader world of software development, a field I am eager to explore further.

A significant personal goal is to cultivate greater confidence, a quality that sometimes eludes me, though I tend to mask this with a composed exterior and quiet demeanor.

Furthermore, my acknowledged tendency towards a shorter attention span, something my parents have often pointed out, is another personal hurdle I am consciously working to overcome.

Please understand that these reflections are not rooted in any feelings of depression or mental health struggles; that is not the impression I intend to convey.

Instead, these are observations made when I look inward, identifying areas for personal growth and development in the future.

For now, however, my immediate focus returns to the game itself, specifically on the next crucial task: presenting the items currently held within the inventory in a clear and user-friendly way within the Inventory UI.

16/04/2025

Today's development focused on bridging the gap between the inventory data and its visual representation within the user interface.

The primary goal was to allow the player to see the items they collect, observe their stacking behavior with a displayed quantity,
and provide basic interaction options like dropping or equipping.

To achieve this, I implemented changes in both the InventoryUI.gd and InventorySlot.gd scripts.

Within the InventoryUI.gd script, I added the following add_item function:
	func add_item(item: InventoryItem):
		var slots = grid_container.get_children().filter(func(slot): return slot.is_empty)
		var first_empty_slot = slots.front() as InventorySlot
		first_empty_slot.add_item(item)
		

This function is responsible for taking an InventoryItem and finding the first available empty slot in the GridContainer.
It retrieves all child nodes of the grid_container and filters them to select only those where the is_empty property (defined in InventorySlot.gd) is true.
It then takes the first empty slot from this filtered list and calls its own add_item function, passing the InventoryItem to it for visual presentation.

Correspondingly, I modified the add_item function within the InventorySlot.gd script:
	func add_item(item: InventoryItem):
		if item.slot_type != "NotEquipable":
			var popup_menu: PopupMenu = menu_button.get_popup()
			var equip_slot_array_name = item.slot_type.to_lower().split("_")
			var equip_slot_name = " ".join(equip_slot_array_name)
			slot_to_equip = item.slot_type
			popup_menu.set_item_text(0, "Equip to " + equip_slot_name)
		is_empty = false
		menu_button.disabled = false
		texture_rect.texture = item.texture
		name_label.text = item.name
		if item.stacks < 2:
			return
		stacks_label.text = str(item.stacks)
		
This function in InventorySlot.gd is now responsible for updating the visual elements of a specific inventory slot based on the InventoryItem it receives.

First, it checks if the item's slot_type is not "NotEquipable".
If it is an equippable item, it retrieves the PopupMenu associated with the menu_button.
It then processes the slot_type string (e.g., "Right_Hand") to create a more readable equip slot name ("right hand").
This name is then used to set the text of the first item (index 0) in the PopupMenu to "Equip to [slot name]", providing the "equip" option.
The slot_to_equip variable is also updated with the item's slot_type.

Next, it sets the is_empty flag of the slot to false, indicating that it now contains an item, and enables the menu_button, allowing for interaction (like dropping or equipping).
The texture_rect's texture is set to the item's texture, displaying the item's icon.
The name_label's text is updated with the item's name.
A check is performed to see if the item's stacks count is less than 2. If it is, the function returns, preventing the stack label from being displayed for single items.
Finally, if the stacks count is 2 or greater, the stacks_label's text is set to the string representation of the item's stacks value,
visually showing the quantity of stacked items like gold coins.

During this process, I encountered and resolved a few syntax errors, a common part of the development cycle.
Specifically, I initially had an issue with the set_item_text function in PopupMenu,
where I incorrectly provided three arguments instead of the expected two (the index and the text).
Removing the extra comma resolved this.

Aside from the scripting, I made a minor organizational adjustment by creating a separate folder for UI resources.
This allows for quicker loading of assets like the game's font, improving efficiency.

It feels like my understanding of the Godot engine is deepening with each step. The way scenes, scripts, and signals interact is becoming more intuitive.

With the basic presentation of inventory items now functional,
where collected coins are displayed with their stack count and equippable items offer an "Equip" option,
I feel like I'm heading in the right direction.

My next immediate focus will be on implementing the weapon management system, building upon this foundational inventory framework.

Building upon the visual presentation of items, I've now implemented a crucial update to ensure the inventory UI dynamically reflects the items the player collects and their stacking quantities.

With the newly implemented update_stack_at_slot_index function (though the code for this function wasn't explicitly provided in the prompt, its functionality is clear),
the inventory UI now accurately updates the stack count displayed in each slot as the player picks up more of the same stackable item.

This means that the player can indeed collect and stack up to 100 gold coins (or any item with a max_stack of 100) within a single inventory slot,
with the UI label reflecting the current quantity.

This dynamic updating of the UI provides immediate and clear feedback to the player regarding their collected resources, enhancing the gameplay experience.

With this core inventory functionality now largely in place, my attention is shifting towards the next significant phase of development: combat.

I've organized the upcoming tasks related to combat under the "items-inventory-implementation" branch in my version control system.

This organization includes several key areas: the creation and integration of weapon items, the management of resources relevant to combat (such as ammunition or mana),
the mechanics for equipping weapons, and the design and implementation of the on-screen UI elements necessary for displaying combat information.

As I move into the more intricate aspects of attack animations, I plan to create a separate branch specifically for that purpose.

This will ensure a clean and manageable development process, allowing me to focus solely on animation without disrupting the already established inventory and item systems.

Once the attack animations are in a satisfactory state and thoroughly tested, I will merge the "items-inventory-implementation" branch with the main branch of the project and then update the repository,
integrating all the new combat-related features.

This structured approach to development, utilizing branching and merging, will help maintain code stability and facilitate collaboration (even though I am currently working solo).

The transition to combat mechanics marks an exciting new chapter in this project, and I am eager to begin implementing weapon items and the initial stages of the combat system.

17/04/2025

Today's progress marks the exciting first step into implementing combat mechanics, specifically by introducing a weapon item: the sword, and ensuring it can be represented within the inventory.

To define the properties and behavior of weapon items, I created a new script named WeaponItem.gd, which extends the Resource class:
	
 extends Resource

   class_name WeaponItem

  @export var in_hand_texture: Texture
  @export var side_in_hand_texture: Texture
  @export var collision_shape: RectangleShape2D
  @export_enum("Melee", "Ranged", "Magic") var attack_type: String

  @export_group("Attachment_position")
  @export var left_attachment_position: Vector2
  @export var right_attachment_position: Vector2
  @export var front_attachment_position: Vector2
  @export var back_attachment_position: Vector2
  @export_group("")

  @export_group("Rotation")
  @export var left_rotation: int
  @export var right_rotation: int
  @export var front_rotation: int
  @export var back_rotation: int
  @export_group("")

  @export_group("Z index")
  @export var left_z_index: int
  @export var right_z_index: int
  @export var front_z_index: int
  @export var back_z_index: int
  @export_group("")

  func get_data_for_direction(direction: String):
	match direction:
		"left":
			return{
				"attachment_position": left_attachment_position,
				"rotation": left_rotation,
				"z_index": left_z_index
			}
		"right":
			return{
				"attachment_position": right_attachment_position,
				"rotation": right_rotation,
				"z_index": right_z_index
			}
		"front":
			return{
				"attachment_position": front_attachment_position,
				"roatation": front_rotation,
				"z_index": front_z_index
			}
		"back":
			return{
				"attachment_position": back_attachment_position,
				"rotation": back_rotation,
				"z_index": back_z_index
			}
			

This script defines the WeaponItem class, inheriting from Resource, which makes it suitable for creating reusable weapon data assets within the Godot editor.

It exports several variables that define the visual and functional aspects of a weapon:

in_hand_texture: This Texture will be used to display the sword (or any weapon) when it is held by the player.

side_in_hand_texture: This Texture might be used for a different visual representation of the weapon when viewed from the side, potentially for 2D sprite direction handling.

collision_shape: This RectangleShape2D defines the physical boundaries of the weapon, crucial for hit detection during combat. By including it directly in the resource, each weapon can have a unique hitbox.

attack_type: This uses @export_enum to restrict the possible values to "Melee", "Ranged", or "Magic", categorizing the weapon's attack style. This is important for implementing different combat behaviors later.

The script then defines three @export_group sections: "Attachment_position", "Rotation", and "Z index". These groups organize related properties within the Inspector panel, making it easier to manage the weapon's visual placement and layering relative to the player sprite for different facing directions.

Within each of these groups, there are Vector2 variables for left, right, front, and back attachment positions. These determine where the weapon sprite should be positioned relative to the player's hand or body when equipped and facing a particular direction.

Similarly, integer variables for left, right, front, and back rotations define the weapon's visual orientation for each direction.

Finally, integer variables for left, right, front, and back Z indices control the rendering order (layering) of the weapon sprite relative to other sprites, ensuring it appears correctly in front or behind the player depending on the viewing angle.

The get_data_for_direction function takes a direction string as input and uses a match statement (similar to a switch statement in other languages) to return a dictionary containing the attachment position, rotation,
and Z index specific to that direction.
This function encapsulates the logic for retrieving the correct visual transformation data based on the player's facing direction,
making it easier to handle directional weapon rendering.

To see the sword in action, I created a WeaponItem resource in the editor, assigned it a texture for its in-hand appearance and defined its collision shape.
By adding an instance of this WeaponItem to the player's inventory (for now, likely done manually for testing), the groundwork is laid for it to be displayed.

I spent some time tweaking the Inspector tabs to ensure these new weapon properties were organized logically and easy to understand,
reflecting good software design principles focused on user experience within the development environment itself.
I also addressed a few minor syntax errors that inevitably arise during coding.

My next immediate goal is to dive deeper into scripting the player's ability to equip this sword as their active weapon.
This will likely involve modifying the player's control script to handle equipping actions and visually attaching the weapon sprite to the player's hand based on their current facing direction,
utilizing the attachment positions and rotations defined in the WeaponItem resource.

Following the successful implementation of weapon equipping, I will create a new branch in my version control system,
specifically dedicated to developing the attack animations for the sword. This branched approach will allow me to iterate on the visual aspects of combat without destabilizing the core inventory and item management systems that I've been building.
Once the animations are satisfactory, I will merge this animation branch back into the main development branch and update the repository, integrating the initial combat mechanics into the game.

This step into weapon implementation feels significant. It marks the transition from purely inventory management towards dynamic gameplay interactions.
The structure I've established with the WeaponItem resource, including directional visual data, reflects common practices in 2D game development for handling sprite orientation and attachments.
As a solo developer, organizing these systems clearly is crucial for maintainability and future expansion. The cultural aspect of game development often involves sharing these kinds of reusable data structures within teams to ensure consistency and efficiency.
Even working alone, adopting these established patterns helps in thinking like a professional software developer.
The lifestyle of a game developer often involves this iterative process of designing data structures, implementing logic, and then visually realizing those systems in the game world. Seeing the sword appear in the inventory is a tangible reward for the abstract work of writing code and defining data.


19/04/2025

Today's development focused on enabling the player to equip weapons from their inventory,
a crucial step towards implementing a functional combat system.

The process involved modifications to several scripts,
primarily centered around handling the equipping action and communicating it between the inventory UI and the core inventory logic.

First, I declared a new signal in InventoryUI.gd: signal equip_item(index: int, slot_to_equip: String)

This signal, equip_item, is emitted by the InventoryUI when the player selects the "Equip" option from an item's context menu.

It carries two important pieces of data: the index of the inventory slot containing the item to be equipped, and the slot_to_equip string,
which indicates the intended equipment slot (e.g., "Right_Hand", "Left_Hand").

Next, I edited the on_popup_menu_item_pressed function within InventorySlot.gd.

This function now handles different actions based on the id of the menu item pressed in the PopupMenu.

Instead of the previous generic print_debug(id), I've implemented a match statement to provide specific behavior for different menu options.
I've also added a "Drop" and "Examine" option, even if their functionality is not fully implemented yet.

When the "Equip to ..." option (assumed to have an ID of 0) is selected, the code checks if the item is actually equippable (i.e., slot_to_equip is not "NotEquipable").

If it is, the script retrieves a reference to the InventoryUI node by traversing the scene tree (getting the parent of the parent).
It then emits the equip_item signal, passing the slot's index (obtained using get_index()) and the slot_to_equip string.
The print_debug line is commented out, but kept for debugging purposes.
I've added placeholder comments for the "Drop" and "Examine" options, indicating where their logic should be implemented later.

To handle this signal, I added the following code to Inventory.gd: func _ready() -> void: inventory_ui.equip_item.connect(on_item_equipped) ; and func on_item_equipped(index: int, slot_to_equip: String): ......

In the _ready() function, I connect the inventory_ui's equip_item signal to a new function called on_item_equipped.

This function is called when the equip_item signal is emitted.  It receives the slot index and the slot_to_equip string as arguments.
The function retrieves the corresponding item_to_equip from the items array using the provided index.
Currently, it only prints a debug message to confirm the correct item and slot are being processed.
I've added a comment to indicate where the actual logic for equipping the item (attaching it to the player, updating the player's appearance, etc.) will be implemented.

Finally, I deleted a duplicate _input function that was present in the Inventory.gd script.

This series of changes establishes the communication pathway for equipping items.
When the player chooses to equip an item from the inventory UI, the equip_item signal is emitted,
carrying the necessary information to the Inventory script, which then begins the equipping process.

This is a fundamental step in making the combat system functional.
The design pattern of using signals to communicate between different parts of the game (UI and game logic) is a cornerstone of good software development,
promoting modularity and maintainability.
Being game developers, we often work with complex systems, and signals provide a clean way to decouple components.
The choice to use a signal here reflects a design decision to separate the UI's responsibility (handling user interaction) from the game logic's responsibility (managing the game state and applying the effects of actions).
This separation of concerns is a core principle in software engineering and is valuable in any complex project, including game development.

20/04/2025

Today's development session was largely dedicated to resolving a critical error that prevented equipped items from being displayed on the screen.

The error message I encountered during playtesting in the Godot engine was:

"Attempt to call function 'equip_item' in base 'null instance' on a null instance"

This error occurred within the Inventory.gd script, specifically at line 58:
  extends Node
  class_name Inventory

 @onready var inventory_ui: InventoryUI = $"../InventoryUI"
 @onready var on_screen_ui: OnScreenUI = $OnScreenUI

 @export var items: Array[InventoryItem] = []

 func _ready() -> void:
	inventory_ui.equip_item.connect(on_item_equipped)

 @warning_ignore("unused_parameter")
 func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_ui.toggle()

 func add_item(item: InventoryItem, stacks: int):
	if stacks && item.max_stack > 1:
		add_stackable_item_to_inventory(item, stacks)
	else:
		# Syntext Error
		items.append(item)
		inventory_ui.add_item(item)

 func add_stackable_item_to_inventory(item: InventoryItem, stacks: int):
	var item_index = -1
	for i in items.size():
		if items[i] != null and items[i].name == item.name:
			item_index = i

	if item_index != -1:
		var inventory_item = items[item_index]

		if inventory_item.stacks + stacks <= item.max_stack:
			inventory_item.stacks += stacks
			items[item_index] = inventory_item
			inventory_ui.update_stack_at_slot_index(inventory_item.stacks, item_index)
		else:
			var stacks_diff = inventory_item.stacks + stacks - item.max_stack
			var additional_inventory_item = inventory_item.duplicate(true)
			inventory_item.stacks = item.max_stack
			inventory_ui.update_stack_at_slot_index(inventory_item.stacks, item_index)
			additional_inventory_item.stacks = stacks_diff
			# error fixed: syntex error
			items.append(additional_inventory_item)
			inventory_ui.add_item(additional_inventory_item)

	else:
		item.stacks = stacks
		items.append(item)
		inventory_ui.add_item(item)

 func on_item_equipped(index: int, slot_to_equip: String):
	var item_to_equip = items[index]
	on_screen_ui.equip_item(item_to_equip, slot_to_equip) # Line 58
	
	
	
This error message, a common one in Godot, indicates that the code was attempting to call the function equip_item on a variable (on_screen_ui) that held a null value.

In essence, the Inventory script couldn't find the OnScreenUI node in the scene, and therefore, on_screen_ui was never assigned, resulting in a null instance.

To provide more context, here are the relevant code snippets from InventoryUI.gd:
	extends CanvasLayer
 class_name InventoryUI

 signal equip_item(index: int, slot_to_equip: String)

 @onready var grid_container: GridContainer = %GridContainer
 const INVENTORY_SLOT_SCENE = preload("res://Product/Scenes/UI/inventory_slot.tscn")

 @export var size = 8
 @export var colums = 4

 func _ready():
	grid_container.columns = colums

	for i in size:
		var inventory_slot = INVENTORY_SLOT_SCENE.instantiate()
		grid_container.add_child(inventory_slot)

		inventory_slot.equip_item.connect(func(slot_to_equip: String): equip_item.emit(i, slot_to_equip))

 func toggle():
	visible = !visible

 func add_item(item: InventoryItem):
	var slots = grid_container.get_children().filter(func(slot): return slot.is_empty)
	var first_empty_slot = slots.front() as InventorySlot
	first_empty_slot.add_item(item)

 func update_stack_at_slot_index(stacks_value: int, inventory_slot_index: int):
	if inventory_slot_index == -1:
		return
	var inventory_slot: InventorySlot = grid_container.get_child(inventory_slot_index)
	inventory_slot.stacks_label.text = str(stacks_value)
	
And from InventorySlot.gd:
	extends VBoxContainer
 class_name InventorySlot

 var is_empty = true
 var is_selected = false
 signal equip_item

 @export var single_button_press = false
 @export var starting_texture: Texture
 @export var start_label: String

 @onready var texture_rect: TextureRect = $NinePatchRect/MenuButton/CenterContainer/TextureRect
 @onready var name_label: Label = $NameLabel
 @onready var stacks_label: Label = $NinePatchRect/StacksLabel
 @onready var on_click_button: Button = $NinePatchRect/OnClickbutton
 @onready var price_label: Label = $PriceLabel
 @onready var menu_button: MenuButton = $NinePatchRect/MenuButton

 var slot_to_equip = "NotEquipable"

 func _ready() -> void:

	if starting_texture != null:
		texture_rect.texture = starting_texture

	if start_label != null:
		name_label.text = start_label

	#menu_button.disable = single_button_press
	on_click_button.disabled = !single_button_press

	on_click_button.visible = single_button_press

	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(on_popup_menu_item_pressed)

 func on_popup_menu_item_pressed(id: int):
	var pressed_menu_item = menu_button.get_popup().get_item_text(id)

	if pressed_menu_item == "Drop":
		#TODO: handle item dropping
		print_debug("DROP")
	elif pressed_menu_item.contains("Equip") && slot_to_equip != "NotEquipable":
		equip_item.emit(slot_to_equip)
	#print_debug(id)

 func add_item(item: InventoryItem):
	if item.slot_type != "NotEquipable":
		var popup_menu: PopupMenu = menu_button.get_popup()
		var equip_slot_array_name = item.slot_type.to_lower().split("_")
		var equip_slot_name = " ".join(equip_slot_array_name)
		slot_to_equip = item.slot_type
		# Syntext Error fixed: expected two arguments but got three. Removed the comma after "Equip to"
		popup_menu.set_item_text(0, "Equip to " + equip_slot_name)

	is_empty = false
	menu_button.disabled = false
	texture_rect.texture = item.texture
	name_label.text = item.name
	if item.stacks < 2:
		return

	stacks_label.text = str(item.stacks)
	

And the relevant OnScreen UI code:
	extends VBoxContainer
 class_name OnScreenEquipmentSlot

 @onready var slot_label: Label = $SlotLabel
 @onready var texture_rect: TextureRect = %TextureRect

 @export var slot_name: String

 func _ready() -> void:
	slot_label.text = slot_name

 func set_equipment_texture(texture: Texture):
	texture_rect.texture = texture
 ```gd
 extends CanvasLayer
 class_name OnScreenUI

 @onready var right_hand_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/RightHandSlot
 @onready var left_hand_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/LeftHandSlot
 @onready var potion_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/PotionSlot
 @onready var spell_slot: OnScreenEquipmentSlot = $MarginContainer/HBoxContainer/SpellSlot

 @onready var slots_dictionary = {
	"Right_Hand": right_hand_slot,
	"Left_Hand": left_hand_slot,
	"Potions": potion_slot
 }

 func equip_item(item: InventoryItem, slot_to_equip: String):
	slots_dictionary[slot_to_equip].set_equipment_texture(item.texture)
	
	

The core issue was a misconfiguration in the scene tree, leading to an incorrect node path.

As the diary entry notes:

"The error occurred because on_screen_ui was assigned using $OnScreenUI, assuming that the OnScreenUI node was a direct child of this Inventory node.
However, at runtime, the node was not found at that path, resulting in a null reference when calling equip_item()."

The solution involved restructuring the scene:

"RESOLUTION: I moved the OnScreenUI node to be an instant child above both InventoryUI and Inventory in the scene tree,
ensuring that it is properly instantiated and accessible at the time Inventory is ready. Now $OnScreenUI correctly points to the node, and the error is resolved."

In essence: The Inventory script uses the @onready keyword to get a reference to the OnScreenUI node.
The $ syntax specifies a relative path within the scene tree. If the OnScreenUI node is not located at the path specified, the @onready variable will be assigned null.
By adjusting the scene tree so that OnScreenUI is a direct child of the node that contains Inventory, the path $OnScreenUI correctly resolves to the OnScreenUI node.

By correcting the scene structure, the Inventory script was able to correctly access the OnScreenUI node and call its equip_item function, allowing the equipped item to be displayed.

The diary entry concludes with the intention to: "and now I'm going to merge the items-inventory-implementation branch with the main, and moving to combat."

This indicates a successful resolution of the issue and a transition to the next development phase: implementing the combat system.
