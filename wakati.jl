# -*- coding:utf-8 -*-

#=
 形態素解析
=#

using MeCab
using TinySegmenter

mecab = Mecab()
results = parse(mecab, "すもももももももものうち")
println(join([result.surface for result in results], "|"))
println(join(tokenize(string), "|"))
