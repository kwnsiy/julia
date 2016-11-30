# coding:utf-8

# convert any character encoding to utf8

function readall_utf8(filename)
  return readall(pipeline(`iconv -t UTF-8 $filename`))
end

function readall_utf8(filename, from)
  return readall(pipeline(`iconv -f $from -t UTF-8 $filename`))
end

function iconv(inputfile, outputfile, from, to)
  return readall(pipeline(`iconv -f $from -t $to $inputfile`, outfile))
end
