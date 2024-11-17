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
