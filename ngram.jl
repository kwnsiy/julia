using MeCab
using DataStructures

# morphological analysis
function parse_mecab(string)
  return parse(Mecab(), string)
end

# ngram
function ngram(string, n)
  words = []
  !contains(summary(string),"Array") && (string = utf32(string))
  for i in collect(1:(length(string)-n+1))
    push!(words, string[i:i+n-1])
  end
  return words
end

# word probability
function word_prob(words)
  word_count = counter(words)
  n, d = length(words), Dict()
  return [w => word_count[w]/n for w in keys(word_count)]
end

string = "すもももももももものうち"
n = 2

# ngram
@show word_prob(ngram(string, n))

# 単語ngram
words = [res.surface for res in parse_mecab(string)]
@show word_prob(ngram(words,n))
