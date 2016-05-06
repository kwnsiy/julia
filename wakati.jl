# -*- coding:utf-8 -*-

#=
 形態素解析
=#

using MeCab
mecab = Mecab()

results = parse(mecab, "すもももももももものうち")
println(join([result.surface for result in results], "\n"))

