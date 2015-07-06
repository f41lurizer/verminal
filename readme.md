#What is Verminal?
Verminal is a minimalistic terminal interface for vim. It will work on any 
system, because it simply relies on vim's existing ability to run external 
commands. Whatever commands are available in the shell that starts vim should
be available in verminal. Please note that interactive commands are not
supported. Verminal also remaps some commands which vim has internal support 
for. For a list of these captured commands, read the helpdoc for the plugin.
Verminal also allows you to run ex mode commands by typing :Command from a 
verminal buffer.  
##Does this let me run vim inside vim inside vim inside vim???
No. You can use vim as a command to open files in your current vim instance,
but it will not start a new vim instance inside of vim. 
#Installation
Verminal can be installed using Pathogen, and of course can also be installed
manually. For manual installation, move verminal.vim to your ~/.vim/plugin 
directory.  

#How do I use Verminal?
Verminal supports two "modes". The first, external mode, can be used by simply
typing a command in the verminal window (ex: ls -lah). The second, Ex mode, 
is used by typing a :command in a verminal window (ex: :source file.vim). 

To use verminal, you can type 
:call NewBuffer()
which will open a new buffer with a verminal initialized in it. 

If you have a buffer you wish to convert to a verminal, you can type 
:call InitMappings()
It is recommended that you map one of these functions to a keybinding for ease of
use. For example, to map NewBuffer() to <Leader>om, add this line to your .vimrc: 
* nnoremap <Leader>om :call NewBuffer()<Enter>
 
#What are the limitations of verminal?
##Interactive Commands
Verminal will not work with interactive commands. Commands which prompt for
standard input are not considered interactive and will work. However, things like 
the emacs operating system will not be able to run. This is due to limitations of
 vim, and in an effort to make this plugin as portable as possible, support for
interactive commands is will not be added unless vim adds this feature.
Given Bram Mooleanar's positon on shells in vim, this is unlikely. 
##Register Usage
Pleaes note that verminal will use your z register for internal storage. 
Future support is planned to allow the user to select a register other than z
for use. Ultimately, it would be nice not to use registers at all, but this is 
not an urgent optimization. 

#To-Do List
* See about using append() instead of register hacks to insert text
* Add support for a vim-mode, so vim shell doesn't need colon in front of 
commands to work properly. 
* Allow user to select which register verminal uses
* Migrate away from using registers entirely
