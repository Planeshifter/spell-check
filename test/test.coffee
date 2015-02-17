chai = require 'chai'
expect = chai.expect
R = require 'ramda'
{ find_edits1_of } = require '../lib/spelling'

describe("find_edits1_of()", () ->
  it("returns the correct list for word 'the'", () ->
    candidates = find_edits1_of("the")
    truth = [ 'he',  'te',  'th',  'the',  'athe',  'tahe',  'thae',  'thea',
    'bthe',  'tbhe',  'thbe',  'theb',  'cthe',  'tche',  'thce',  'thec',
    'dthe',  'tdhe',  'thde',  'thed',  'ethe',  'tehe',  'thee',  'fthe',
    'tfhe',  'thfe',  'thef',  'gthe',  'tghe',  'thge',  'theg',  'hthe',
    'thhe',  'theh',  'ithe',  'tihe',  'thie',  'thei',  'jthe',  'tjhe',
    'thje',  'thej',  'kthe',  'tkhe',  'thke',  'thek',  'lthe',  'tlhe',
    'thle',  'thel',  'mthe',  'tmhe',  'thme',  'them',  'nthe',  'tnhe',
    'thne',  'then',  'othe',  'tohe',  'thoe',  'theo',  'pthe',  'tphe',
    'thpe',  'thep',  'qthe',  'tqhe',  'thqe',  'theq',  'rthe',  'trhe',
    'thre',  'ther',  'sthe',  'tshe',  'thse',  'thes',  'tthe',  'thte',
    'thet',  'uthe',  'tuhe',  'thue',  'theu',  'vthe',  'tvhe',  'thve',
    'thev',  'wthe',  'twhe',  'thwe',  'thew',  'xthe',  'txhe',  'thxe',
    'thex',  'ythe',  'tyhe',  'thye',  'they',  'zthe',  'tzhe',  'thze',
    'thez' ]
    expect(R.difference(truth, candidates).length).to.be.equal(0)
  )
  it("returns the correct list for word 'man'", () ->
    candidates = find_edits1_of("man")
    truth = [ 'an',  'mn',  'ma',  'man',  'aman',  'maan',  'mana',  'bman',
    'mban',  'mabn',  'manb',  'cman',  'mcan',  'macn',  'manc',  'dman',
    'mdan',  'madn',  'mand',  'eman',  'mean',  'maen',  'mane',  'fman',
    'mfan',  'mafn',  'manf',  'gman',  'mgan',  'magn',  'mang',  'hman',
    'mhan',  'mahn',  'manh',  'iman',  'mian',  'main',  'mani',  'jman',
    'mjan',  'majn',  'manj',  'kman',  'mkan',  'makn',  'mank',  'lman',
    'mlan',  'maln',  'manl',  'mman',  'mamn',  'manm',  'nman',  'mnan',
    'mann',  'oman',  'moan',  'maon',  'mano',  'pman',  'mpan',  'mapn',
    'manp',  'qman',  'mqan',  'maqn',  'manq',  'rman',  'mran',  'marn',
    'manr',  'sman',  'msan',  'masn',  'mans',  'tman',  'mtan',  'matn',
    'mant',  'uman',  'muan',  'maun',  'manu',  'vman',  'mvan',  'mavn',
    'manv',  'wman',  'mwan',  'mawn',  'manw',  'xman',  'mxan',  'maxn',
    'manx',  'yman',  'myan',  'mayn',  'many',  'zman',  'mzan',
    'mazn',  'manz' ]
    expect(R.difference(truth, candidates).length).to.be.equal(0)
  )
  it("returns the correct list for word 'bird'", () ->
    candidates = find_edits1_of("bird")
    truth = [ 'ird',  'brd',  'bid',  'bir',  'bird',  'abird',  'baird',
    'biard',  'birad',  'birda',  'bbird',  'bibrd',  'birbd',  'birdb',
    'cbird',  'bcird',  'bicrd',  'bircd',  'birdc',  'dbird',  'bdird',
    'bidrd',  'birdd',  'ebird',  'beird',  'bierd',  'bired',  'birde',
    'fbird',  'bfird',  'bifrd',  'birfd',  'birdf',  'gbird',  'bgird',
    'bigrd',  'birgd',  'birdg',  'hbird',  'bhird',  'bihrd',  'birhd',
    'birdh',  'ibird',  'biird',  'birid',  'birdi',  'jbird',  'bjird',
    'bijrd',  'birjd',  'birdj',  'kbird',  'bkird',  'bikrd',  'birkd',
    'birdk',  'lbird',  'blird',  'bilrd',  'birld',  'birdl',  'mbird',
    'bmird',  'bimrd',  'birmd',  'birdm',  'nbird',  'bnird',  'binrd',
    'birnd',  'birdn',  'obird',  'boird',  'biord',  'birod',  'birdo',
    'pbird',  'bpird',  'biprd',  'birpd',  'birdp',  'qbird',  'bqird',
    'biqrd',  'birqd',  'birdq',  'rbird',  'brird',  'birrd',  'birdr',
    'sbird',  'bsird',  'bisrd',  'birsd',  'birds',  'tbird',  'btird',
    'bitrd',  'birtd',  'birdt',  'ubird',  'buird',  'biurd',  'birud',
    'birdu',  'vbird',  'bvird',  'bivrd',  'birvd',  'birdv',  'wbird',
    'bwird',  'biwrd',  'birwd',  'birdw',  'xbird',  'bxird',  'bixrd',
    'birxd',  'birdx',  'ybird',  'byird',  'biyrd',  'biryd',  'birdy',
    'zbird',  'bzird',  'bizrd',  'birzd',  'birdz' ]
    expect(R.difference(truth, candidates).length).to.be.equal(0)
  )
)

describe("find_edits2_of()", () ->

)

describe("spell()", () ->

)
