# load dependencies
R = require 'ramda'
sqlite3 = require 'sqlite3'
bluebird = require 'bluebird'
BPromise  = bluebird.Promise
path     = require 'path'

# load unigram database
db_path = path.normalize( __dirname + '/../data/unigrams.sqlite' )
db = new sqlite3.Database( db_path )
db = BPromise.promisifyAll(db)

# global variables
ALPHABET = "abcdefghijklmnopqrstuvwxyz"

# private functions
get_deletes = (splits) ->
  deletes = splits.map( (elem) -> elem[0] + elem[1][1...] )
  return deletes

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
  transpositions = splits
    .filter( (e) -> e[1].length > 1)
    .map( (e) -> e[0] + e[1][1] + e[1][0] + e[1][2...])
  return transpositions

###
  FUNCTION: find_edits1_of( word )
  Finds all strings one edit distance away from input word
  @param {String} word - input word
  @returns {Array} result set - strings one edit distance away from input word
###
find_edits1_of = (word) ->
  splits = []
  splits.push [word[...i], word[i...]] for i in R.range(0, word.length + 1)

  deletes = get_deletes(splits)
  inserts = get_inserts(splits)
  replacements = get_replacements(splits)
  transpositions = get_transpositions(splits)

  candidates = []
    .concat(deletes)
    .concat(inserts)
    .concat(replacements)
    .concat(transpositions)
  resultSet = R.uniq(candidates)
  return resultSet

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

fetch_unigram_data = (terms) ->
  terms = terms.map( (e) -> "'#{e}'" )
  query = "SELECT term, freq FROM unigrams WHERE term IN ( #{terms.join(',')} )"
  return db.allAsync(query)

get_top_term = (arr) ->
  return R.compose( R.prop( "term" ), R.maxBy( (obj) -> obj.freq ) ) ( arr )

###
 FUNCTION: spell( word )
 Finds possible correction for input word
 @param {String} word - input word
 @returns {String} the suggested correction
###
spell = (input, callback) ->
  fword   = fetch_unigram_data( R.of(input) )

  suggestion = fword.then( (word) ->
    if word and word.length > 0 then return get_top_term( word )
    else
      fEdits1 = fetch_unigram_data( find_edits1_of(input) )
      return fEdits1.then( (edits1) ->
        if edits1 and edits1.length > 0 then return get_top_term( edits1 )
        else
          fEdits2 = fetch_unigram_data( find_edits2_of(input) )
          return fEdits2.then( (edits2) ->
            if edits2 and edits2.length > 0 then return get_top_term( edits2 )
            else return input
          )
      )
  )
  return suggestion.nodeify(callback)

# exported namespace
module.exports = exports = {
  "spell" : spell,
  "find_edits1_of" : find_edits1_of,
  "find_edits2_of" : find_edits2_of,
  "fetch_unigram_data"  : fetch_unigram_data
}

spell("langauge").then( (res) -> console.log res )
