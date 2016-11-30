# coding:utf-8

@windows_only println("unix環境推奨")

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

""" @head """
macro head(filename)
  quote
    $(run(`head $filename -n 3`))
  end
end

""" @replace! """
macro replace!(string, pat, r)
  quote
    $(esc(string)) = $(eval(replace(eval(string),eval(pat), eval(r))))
    return
  end
end

""" @assign! """
macro assign!(a, b)
  quote
    $(esc(a)) = $(eval(b))
    return
  end
end

""" @toCmd """
macro toCmd(string)
  return `$string`
end


""" @run """
macro run(cmd)
  quote
    $(run(eval(cmd)))
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
    $(esc(string)) = $(eval(rstrip(eval(string))))
    return
  end
end


""" @println """
macro println(obj...)
  :(println($obj...))
end


""" @print """
macro print(obj...)
  :(print($obj...))
end


""" @inc! """
macro inc!(x)
   :($x += 1)
end


""" @decr! """
macro decr!(x)
  :($x -= 1)
end

""" iconv """
function iconv(inputfile, outputfile, from, to)
  return readall(pipeline(`iconv -f $from -t $to $inputfile`, outfile))
end


# convert any character encoding to utf8
""" readall_utf8 """
function readall_utf8(filename)
  return readall(pipeline(`iconv -t UTF-8 $filename`))
end

function readall_utf8(filename, from)
  return readall(pipeline(`iconv -f $from -t UTF-8 $filename`))
end

