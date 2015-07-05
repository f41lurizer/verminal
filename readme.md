#What is Verminal?
Verminal is a minimalistic terminal interface for vim. It will work on any 
system, because it simply relies on vim's existing ability to run external 
commands. Whatever commands are available in the shell that starts vim should
be available in verminal. Please note that interactive commands are not
supported. Verminal also remaps some commands which vim has internal support 
for. For a list of these captured commands, please see the Captured Commands
section. 
##Does this let me run vim inside vim inside vim inside vim???
No. You can use vim as a command to open files in your current vim instance,
but it will not start a new vim instance inside of vim. 
#Installation
Verminal can be installed using Pathogen, and of course can also be installed
manually. For manual installation, move verminal.vim to your ~/.vim/plugin 
directory.  

#How do I use Verminal?
At this time, to use verminal, you can either type :call NewBuffer(), which 
will open a new buffer with a verminal initialized in it. If you have a buffer 
you wish to convert to a verminal, you can do this by typing
:call InitMappings(). It is recommended that you map whichever one of these 
functions that you usually use to some keystroke so it's more convenient to
use. For example, to map NewBuffer() to <Leader>om, add this line to your 
.vimrc: 
* nnoremap <Leader>om :call NewBuffer()<Enter>

  
#What are the limitations of verminal?
##Interactive Commands
Verminal will not work with interactive commands. The distinction between 
interactive and noninteractive commands is a bit blurred -- simple prompts
for input should work (such as git's prompts for username/password). However,
ssh will not work. This is due to limitations to vim, and 
in an effort to make this plugin as portable as possible, support for
interactive commands is will not be added unless vim adds this feature.
Given Bram Mooleanar's positon on shells in vim, this is unlikely. 
##Register Usage
Pleaes note that verminal will use your z register for internal storage. 
Future support is planned to allow the user to select a register other than z
for use. Ultimately, it would be nice not to use registers at all, but this is 
not an urgent optimization. 

#Captured Commands
* pwd
* cd
* vim

#To-Do List
* See about using append() instead of register hacks to insert text
* Add support for a vim-mode, so vim shell doesn't need colon in front of 
commands to work properly. 
* Allow user to select which register verminal uses
* Migrate away from using registers entirely
