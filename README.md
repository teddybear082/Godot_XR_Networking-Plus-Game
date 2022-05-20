# Godot_XR_Networking-Plus-Game
 A test of Godot, networking, XR-tools modifications and Pac-Man-style gameplay for learning purposes


<img src="./pelletman_gif.gif" alt="Pellet-Man GIF" width="800" height="450">



Uses Godot OpenXR asset: https://github.com/GodotVR/godot_openxr

Uses modified tools from https://github.com/GodotVR/godot-xr-tools

Uses https://github.com/goatchurchprime/Godot_XR_networking

Ports experimental "Jog in place to move in game" functionality from OQ-Toolkit originally found here: https://github.com/NeoSpark314/godot_oculus_quest_toolkit/blob/master/OQ_Toolkit/OQ_ARVROrigin/scripts/Locomotion_WalkInPlace.gd

Textures from https://ambientcg.com/

Sounds and music used from OpenGameArt.org:

Little Robot Sound Factory, www.littlerobotsoundfactory.com, https://opengameart.org/content/sci-fi-sound-effects-library

OwlishMedia:
https://opengameart.org/content/sound-effects-pack
https://opengameart.org/content/8-bit-sound-effect-pack

CodeManu: https://opengameart.org/content/platformer-game-music-pack

Sword model from Sketchfab:https://skfb.ly/6WQ87, by Fermin Morales

Pac-Man-style level model from Sketchfab: https://skfb.ly/6XGYL by phamducphuc94

Arcade machine model from Sketchfab: https://skfb.ly/Q69Oby Daniel Bruck

**INSTALLATION**

*Quest native* - download APK and signature file to your hard drive, use sidequest's feature to install a local APK to your quest by selecting the files

*PCVR/OpenXR* - download the zip and unzip the directory anywhere.  Run the .exe file.  Your VR Software should boot up and start you in the game.  *In theory,* should work with all VR headsets; tested with Quest / Virtual Desktop.  You need a PCVR-ready PC.

If you use Virtual Desktop, make sure you have SteamVR set as your OpenXR runtime.


**MULTI-PLAYER (Experimental, and see "Known Issues" at bottom)**

*Once you get into the "real game"* you can see a networking debug menu in front of you. You can hide it or bring it up again by pressing the left controller Y button.

If you have two headsets you can play local multiplayer by going to the top left drop down menu and choosing "ENet" and going to the top right menu and choosing one person "as server" and the other person as "Local Network."   

In theory, both of you should then connect to the game together.

If you want to play with someone online, keep the network option in the top left corner at its default (WebRTC/MQTT) and in the top right corner both choose "as necessary." In theory one person should be assigned automatically as the server and the other as the client and connect.

*There's only been very limited testing on this, and objects/ghosts do not sync, only the other player's avatars.* So for now, think of it like you are in parallel universes with a bridge between you...


**DEFAULT CONTROLS:**

Move character with left thumbstick or **just use experimental "jog in place" movement in real life to move, once you get into the "real game" ;) **

Select options in menus with your right controller and then press trigger

Sprint (toggle) by clicking left thumbstick

**Bullet Time** on and off by pressing the Y button on your right controller.  On its own, if you do not end it yourself, bullet time only lasts for a second or two. 

Jump by clicking right thumbstick.  **When you jump, you can also activate "bullet time" for a second or two.**  Try some "epic" jumps between platforms!  Or jump-cut some blocks or rocks  with your sword :)

Turn in real life or with right thumb stick.  You begin with snap turn.  

Grappling hook movement enabled on both hands, use left hand X button or right hand A button to fire grapples

Climb by using grab buttons.  (To pull yourself up onto platforms, use a roughly lateral movement forward to back while grabbing and you should "pop up")

Glide when you are in the air or jump off of a ledge by extending your arms out like a bird.

Grab objects using grab buttons

Once you get into the "real game," pull your sword out of its holster by positioning your hands around your shoulder areas and pressing the trigger key.  Pressing the key again in the same area holsters the sword.

You can cut a lot of the blocks and rocks with your swords.



**SWITCHING CONTROLS**

**You can adjust all of the controls except for the grabbing buttons and using your right hand as the pointer in the controls menu in the main game.  This includes switching hands, switching to teleport movement or changing turning to smooth turning.**


**PELLET-MAN:**

Travel to the area with the long ladder and click the "new game" button with your trigger while highlighted to start a new "Pellet-man" game. You can also just jump/fly into the arena.

Keep track of your score and lives with your left hand wrist HUD

See how many levels you can earn!

See how long you can last physically jogging away from the ghosts instead of using your thumbstick or teleport!


**QUIT:**

Travel to the area with the long ladder and click the "QUIT" button to exit the entire game.

(If you're in Pellet-Man, you have to find your way to the exit and climb out first!)


**KNOWN ISSUES:**

-Pellets, objects and ghosts do not sync in multiplayer (players are essentially in their own parallel universes; they can see eachother but not how the other impacts the world

-No VOIP

-A lot of jankiness

-Ghost movement could be improved to be closer to its "inspiration"

-Level system should increase your level each time you clear the board but right now it does not impact gameplay (example: ghosts and pacman remain the same speed)

-No controller oriented movement, only HMD movement.

-And many more since I'm just learning..
