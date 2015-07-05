"function to initialize settings for the verminal
function InitMappings()
  "declare variable local to buffer
  let b:commandNum = 1
  inoremap <buffer> <Enter> <Esc>:call RunCommand()<Enter>
  "remove sign column highlighting
  highlight clear SignColumn
  "remove line numbers in local buffer
  setl nonumber
  setl norelativenumber
  call ShowPrompt()
endfunction

"remove keybindings set by buffer
"removing signs here would remove prompts, no need to do that
function RemoveMappings()
  inoremap <buffer> <Enter> <Enter>
endfunction

"open a new buffer and initialize mappings in it
function NewBuffer()
  enew
  call InitMappings()
endfunction

"function to evaluate user commands
function RunCommand()
  "yank command into register z
  normal! ^v$"zy
  let cmd = @z
  let cmdsp = split(cmd)
    "evaluate if command is an ex mode command
    if cmdsp[0][0] == ":"
      call RunExCommand(cmd)
    "on clear, maybe we should remove the signs
    elseif cmdsp[0] == "clear"
      normal! ggdG
      call ShowPrompt()
      return 1
    "use vim's cd so the path actually changes
    elseif cmdsp[0] == "cd"
      let path =  RemoveCommand(cmd, len(cmdsp[0]) + 1)
      execute 'cd '.path
      call RunExCommand('pwd')
    "use internal vim commands where possible
    elseif cmdsp[0] =="pwd"
      call RunExCommand(cmd)

    elseif cmdsp[0] == "vim"
      let path = RemoveCommand(cmd, len(cmdsp[0]) + 1)
      call OpenFile(path)
    "if command isn't special cased, just run it 
    else
      let excmd = 'r! '.cmd
      execute excmd
    endif
  "prepare prompt for next file
  let b:commandNum += 1
  normal! o
  call ShowPrompt()
  startinsert
endfunction

function OpenFile(path)
  execute "edit " . a:path
  let bufferNum = bufnr('%')
  b#
  "let lineNum = line('.') "current line
  "TODO: make append work instead of register hacks
  "let messageCmd = 'call append('.lineNum.', "File added to buffer list")'
  normal! o
  stopinsert
  let @z = a:path . " opened in buffer " . bufferNum
  normal! "zp
  "execute messageCmd
endfunction

function RunExCommand(cmd)
  redir @z
  execute "silent " . a:cmd
  redir END
  let nullChar = '\n'
  let splitCmd = 'let vars = split(@z, "' . nullChar . '")'
  execute splitCmd
  for line in vars
    let @z = line
    normal! o
    stopinsert
    normal! "zp
  endfor
endfunction

function RemoveCommand(input, start) "function to remove command from string
  execute 'let value = a:input[' . a:start . ':' . len(a:input) . ']'
  return value
endfunction

"function to use signcolumn to display a prompt for user on command lines
":help sign-commands
function ShowPrompt()
  let promptString = "> "
  let promptCmd = "sign define prompt text=" . promptString
  execute promptCmd
  let lineNum = line('.') "current line
  let bufferNum = bufnr('%') "current buffer
  let bufferCmd = "buffer=" . bufferNum
  let lineCmd = "line=" . lineNum
  let nameCmd = "name=prompt"
  let signCmd = "sign place " . b:commandNum "current command
  "place command
  let cmd = signCmd . " " . nameCmd . " " . lineCmd . " " . bufferCmd
  execute cmd
  startinsert
endfunction
