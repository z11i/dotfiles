function aliasset -a als exe
  if type -q $exe then
    alias $als=$exe
  end 
end