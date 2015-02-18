R = require 'ramda'
ALPHABET = "abcdefghijklmnopqrstuvwxyz"

get_deletes = (splits) ->
  return splits.map( (elem) -> elem[0] + elem[1][1...] )

get_inserts = (splits) ->
  inserts = []
  for letter in ALPHABET
    splits.forEach( (elem) -> inserts.push elem[0] + letter + elem[1] )
  return inserts

get_replacements = (splits) ->
  replacements = []
  for letter in ALPHABET
    splits.forEach( (elem) ->
      replacements.push elem[0] + letter + elem[1][1...] if elem[1]
    )
  return replacements

get_transpositions = (splits) ->
  return splits
    .filter( (e) -> e[1].length > 1)
    .map( (e) -> e[0] + e[1][1] + e[1][0] + e[1][2...])

find_edits1_of = (word) ->
  splits = []
  splits.push [word[...i], word[i...]] for i in R.range(0, word.length + 1)
  makeSet = R.compose(R.uniq, R.concat)
  return makeSet(
    get_deletes(splits),
    get_inserts(splits),
    get_replacements(splits),
    get_transpositions(splits)
  )

find_edits2_of = (word) ->
  R.pipe( find_edits1_of, R.map( (w) -> find_edits1_of(w) ), R.flatten ) (word)

spell = (word) ->
  # not implemented yet

module.exports = exports = {
  "spell" : spell,
  "find_edits1_of" : find_edits1_of,
  "find_edits2_of" : find_edits2_of
}
