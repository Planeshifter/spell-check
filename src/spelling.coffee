# load dependencies
R = require 'ramda'

# global variables
ALPHABET = "abcdefghijklmnopqrstuvwxyz"

# private functions
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

###
  FUNCTION: find_edits1_of( word )
  Finds all strings one edit distance away from input word
  @param {String} word - input word
  @returns {Array} result set - strings one edit distance away from input word
###
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

###
 FUNCTION: find_edits2_of( word )
 Finds all strings two edit distances away from word
 @param {String} word - input word
 @returns {Array} result set - strings two edit distances away from input word
###
find_edits2_of = (word) ->
  R.pipe(
    find_edits1_of, # find all strings one edit distance away of word
    R.map( (w) -> find_edits1_of(w) ),  # run find_edits_1_of for each of them
    R.flatten, # flatten the returned array of arrays
    R.uniq # discard duplicate elements
  ) (word)

###
 FUNCTION: spell( word )
 Finds possible correction for input word
 @param {String} word - input word
 @returns {String} the suggested correction
###
spell = (word) ->
  # not implemented yet, did only spelling 1 HW so far


# exported namespace
module.exports = exports = {
  "spell" : spell,
  "find_edits1_of" : find_edits1_of,
  "find_edits2_of" : find_edits2_of
}
