[![NPM version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Dependencies][dependencies-image]][dependencies-url]

# spell-check
simple spelling checker

## Introduction

The language model is constructed from the newspaper corpus of
[http://www.corpora.heliohost.org/](http://www.corpora.heliohost.org/),
a collection of corpora for various languages freely available to download and
collected by Hans Christensen. Unigram counts were extracted and stored
in a *sqlite* database for the spell-checker.  

## API

### spell( word [, callback] )

Given an input string consisting of a single `word`,
the `spell` function returns the most probable correction according
to an error and language model. If no valid correction can be found,
the original argument is returned.

The function is asynchronous and either calls the `callback` function upon
completion if the parameter is supplied or otherwise
returns a `Promise`.

### Example:

#### Callback Style

JavaScript:
```js
spell("haert", function(err, res){
  console.log(res);
});
// returns: heart 
```

CoffeeScript:
```coffeescript
spell("haert", (err, res) ->
  console.log res
)
# returns: heart 
```

#### Using Promises

JavaScript:
```js
spell("lagauge").then(function(res){
  console.log(res);
});
// returns: language
```

CoffeeScript:
```coffeescript
spell("langauge").then( (res) -> console.log res )
# returns: language
```

## Unit Tests

Run tests via the command `npm test`

---
## License

[MIT license](http://opensource.org/licenses/MIT).

[npm-image]: https://badge.fury.io/js/spell-check.svg
[npm-url]: http://badge.fury.io/js/spell-check

[travis-image]: https://travis-ci.org/Planeshifter/spell-check.svg
[travis-url]: https://travis-ci.org/Planeshifter/spell-check

[dependencies-image]: http://img.shields.io/david/Planeshifter/spell-check.svg
[dependencies-url]: https://david-dm.org/Planeshifter/spell-check
