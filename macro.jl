# coding:utf-8

""" @swap! """
macro swap!(x,y)
  quote
    $(esc(x)) = $(eval(y))
    $(esc(y)) = $(eval(x))
    return
  end
end


""" @cd """
macro cd(obj)
  :(cd($obj))
end


""" @pwd """
macro pwd()
  :(pwd())
end

""" @replace! """
macro replace!(string, pat, r)
  quote
    $(esc(string)) = $(eval(replace(eval(string),eval(pat), eval(r))))
    return
  end
end


""" @split! """
macro split!(string, chars)
  quote
    $(esc(string)) = $(eval(split(eval(string),eval(chars))))
    return
  end
end


""" @rstrip! """
macro rstrip!(string)
  quote
    $(esc(string)) = $(eval(rsrtrip(eval(string))))
    return
  end
end


""" @println """
macro println(obj)
  :(println($obj))
end


""" @print """
macro print(obj)
  :(print($obj))
end


""" @inc! """
macro inc!(x)
   :($x += 1)
end


""" @decr! """
macro decr!(x)
  :($x -= 1)
end
