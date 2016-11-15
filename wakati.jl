# -*- coding:utf-8 -*-

#=
 形態素解析
=#

using MeCab
using TinySegmenter

string = "すもももももももものうち"

mecab = Mecab()
results = parse(mecab, string)
println(join([result.surface for result in results], "|"))
println(join(tokenize(string), "|"))
