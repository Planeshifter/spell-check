R = require 'ramda'

find_edits1_of = (word) ->
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  splits = []
  splits.push [word[...i], word[i...]] for i in R.range(0, word.length + 1)

  deletes = []
  for elem in splits
    deletes.push elem[0] + elem[1][1...]

  inserts = []
  for letter in alphabet
    for elem in splits
      inserts.push elem[0] + letter + elem[1]

  replacements = []
  for letter in alphabet
    for elem in splits
      replacements.push elem[0] + letter + elem[1][1...] if elem[1]

  transpositions = []
  for elem in splits
    if elem[1].length > 1
      transpositions.push elem[0] + elem[1][1] + elem[1][0] + elem[1][2...]

  makeSet = R.compose(R.uniq, R.concat)
  return makeSet deletes, inserts, replacements, transpositions

find_edits2_of = (word) ->
  R.pipe( find_edits1_of, R.map( (w) -> find_edits1_of(w) ), R.flatten ) (word)
