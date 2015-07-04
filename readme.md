#What is Verminal?
Verminal is a minimalistic terminal interface for vim. It will work on any 
system, because it simply relies on vim's existing ability to run external 
commands. Whatever commands are available in the shell that starts vim should
be available in vermianl. Please note that interactive commands are not
supported. Verminal also remaps some commands which vim has internal support 
for. For a list of these captured commands, please see the Captured Commands
section. 
##Does this let me run vim inside vim inside vim inside vim???
No. You can use vim as a command to open files in your current vim instance,
but it will not start a new vim instance inside of vim. 
#Installation
Verminal can be installed using Pathogen, and of course can also be installed
manually. 
#How do I use Verminal?
At this time, to use verminal, you can either type :call NewBuffer(), which 
will open a new buffer with a verminal initialized in it. If you have a buffer 
you wish to convert to a verminal, you can do this by typing
:call InitMappings().  
#What are the limitations of verminal?
Verminal will not work if the command is interactive (if it prompts you for 
input, it won't work with vermianal). This is due to limitations to vim, and 
in an effort to make this plugin as portable as possible, I do not plan to add
support for interactive plugins unless vim adds this feature. Given Bram 
Mooleanar's positon on shells in vim, I do not believe this will ever happen.
#Captured Commands
pwd
cd
#To-Do List
* Add support for any ex command (vim shell). 
* Add support for a vim-mode, so vim shell doesn't need colon in front of 
commands to work properly. 
