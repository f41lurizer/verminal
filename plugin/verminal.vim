"function to initialize settings for the verminal
function InitMappings()
  "declare variable local to buffer
  let b:commandNum = 1
  inoremap <buffer> <Enter> <Esc>:call RunCommand()<Enter>
  "remove sign column highlighting
  highlight clear SignColumn
  "remove line numbers in local buffer
  setl nonumber
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
    if cmdsp[0] == "clear"
      normal! ggdG
      return 1
    "use vim's cd so the path actually changes
    elseif cmdsp[0] == "cd"
      "TODO: while loop to account for paths with spaces
      execute 'cd '.cmdsp[1]
    "use internal vim commands where possible
    elseif cmdsp[0] =="pwd"
      "redirect ex pwd command to register z
      redir @z
      pwd
      redir END
      "split it twice to get rid of ^J characters that get added
      let wd = split(split(@z)[0])[0]
      "put path into z register
      let @z = wd
      normal! o
      stopinsert
      normal! $"zp
    "if command isn't special cased, just run it 
    else
      let excmd = 'r! '.cmd
      execute excmd
    endif
  let b:commandNum += 1
  normal! o
  call ShowPrompt()
  startinsert
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
