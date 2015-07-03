function InitMappings()
  inoremap <buffer> <Enter> <Esc>:call RunCommand()<Enter>
  startinsert
endfunction
 
function RemoveMappings()
  inoremap <buffer> <Enter> <Enter>
endfunction
  
function NewBuffer()
  enew
  call InitMappings()
endfunction

function RunCommand()
  normal! ^v$"zy
  let cmd = @z
  let cmdsp = split(cmd)
    if cmdsp[0] == "clear"
      normal! ggdG
      return 1
    elseif cmdsp[0] == "cd"
      "todo: while loop to account for paths with spaces
      execute 'cd '.cmdsp[1]
    elseif cmdsp[0] =="pwd"
      redir @z
      pwd
      redir END
      let wd = split(split(@z)[0])[0]
      let @z = wd
      normal! o
      stopinsert
      normal! $"zp
    else
      let excmd = 'r! '.cmd
      execute excmd
    endif
  normal! o
  startinsert
endfunction
