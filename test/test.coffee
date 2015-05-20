# load libraries
chai = require 'chai'
chaiAsPromised = require 'chai-as-promised'
chai.use(chaiAsPromised)

expect = chai.expect
R = require 'ramda'

# load package functions
{ find_edits1_of,  find_edits2_of, spell} = require '../lib/spelling'

# load ground truth
truth = JSON.parse require('fs').readFileSync(__dirname + "/truth.json")

describe("find_edits1_of()", () ->
  this.timeout(10000)
  it("returns the correct list for word 'the'", () ->
    candidates = find_edits1_of("the")
    expect(R.difference(truth.the, candidates).length).to.be.equal(0)
  )
  it("returns the correct list for word 'man'", () ->
    candidates = find_edits1_of("man")
    expect(R.difference(truth.man, candidates).length).to.be.equal(0)
  )
  it("returns the correct list for word 'bird'", () ->
    candidates = find_edits1_of("bird")
    expect(R.difference(truth.bird, candidates).length).to.be.equal(0)
  )
)

describe("find_edits2_of()", () ->
  this.timeout(20000)
  it("returns the correct list for word 'bed'", () ->
    candidates = find_edits2_of("bed")
    expect(R.difference(truth.bed, candidates).length).to.be.equal(0)
  )
)

describe("spell()", () ->
  this.timeout(10000)
  it("returns the correct results for some spelling mistakes", () ->
    expect(spell("haert")).to.eventually.be.equal("heart")
    expect(spell("helllo")).to.eventually.be.equal("hello")
    expect(spell("guesed")).to.eventually.be.equal("guessed")
  )
)
