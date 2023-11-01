---
title: Encoding binary data into DNA sequence
permalink: /encoding-binary-data-into-dna-sequence.html
date: 2019-01-03T12:00:00+02:00
layout: post
type: post
draft: false
---

## Initial thoughts

Imagine a world where you could go outside and take a leaf from a tree and put
it through your personal DNA sequencer and get data like music, videos or
computer programs from it. Well, this is all possible now. It was not done on a
large scale because it is quite expensive to create DNA strands but it's
possible.

Encoding data into DNA sequence is relatively simple process once you understand
the relationship between binary data and nucleotides and scientists have been
making large leaps in this field in order to provide viable long-term storage
solution for our data that would potentially survive our specie if case of
global disaster. We could imprint all the world's knowledge into plants and
ensure the survival of our knowledge.

More optimistic usage for this technology would be easier storage of ever
growing data we produce every day. Once machines for sequencing DNA become fast
enough and cheaper this could mean the next evolution of storing data and
abandoning classical hard and solid state drives in data warehouses.

As we currently stand this is still not viable but it is quite an amazing and
cool technology.

My interests in this field are purely in encoding processes and experimental
testing mainly because I don't have the access to this expensive machines. My
initial goal was to create a toolkit that can be used by everybody to encode
their data into a proper DNA sequence.

## Glossary

**deoxyribose** A five-carbon sugar molecule with a hydrogen atom rather than a
hydroxyl group in the 2′ position; the sugar component of DNA nucleotides.

**double helix** The molecular shape of DNA in which two strands of nucleotides
wind around each other in a spiral shape.

**nitrogenous base** A nitrogen-containing molecule that acts as a base; often
referring to one of the purine or pyrimidine components of nucleic acids.

**phosphate group** A molecular group consisting of a central phosphorus atom
bound to four oxygen atoms.

**RGB** The RGB color model is an additive color model in which red, green and
blue light are added together in various ways to reproduce a broad array of
colors.

**GCC** The GNU Compiler Collection is a compiler system produced by the GNU
Project supporting various programming languages.

## Data encoding

**TL;DR:** Encoding involves the use of a code to change original data into a
form that can be used by an external process.

Encoding is the process of converting data into a format required for a number
of information processing needs, including:

- Program compiling and execution
- Data transmission, storage and compression/decompression
- Application data processing, such as file conversion

Encoding can have two meanings:

- In computer technology, encoding is the process of applying a specific code,
  such as letters, symbols and numbers, to data for conversion into an
  equivalent cipher.
- In electronics, encoding refers to analog to digital conversion.

## Quick history of DNA

- **1869** - Friedrich Miescher identifies "nuclein".
- **1900s** - The Eugenics Movement.
- **1900** – Mendel's theories are rediscovered by researchers.
- **1944** - Oswald Avery identifies DNA as the 'transforming principle'.
- **1952** - Rosalind Franklin photographs crystallized DNA fibres.
- **1953** - James Watson and Francis Crick discover the double helix structure of DNA.
- **1965** - Marshall Nirenberg is the first person to sequence the bases in each codon.
- **1983** - Huntington's disease is the first mapped genetic disease.
- **1990** - The Human Genome Project begins.
- **1995** - Haemophilus Influenzae is the first bacterium genome sequenced.
- **1996** - Dolly the sheep is cloned.
- **1999** - First human chromosome is decoded.
- **2000** – Genetic code of the fruit fly is decoded.
- **2002** – Mouse is the first mammal to have its genome decoded.
- **2003** – The Human Genome Project is completed.
- **2013** – DNA Worldwide and Eurofins Forensic discover identical twins have differences in their genetic makeup.

## What is DNA?

Deoxyribonucleic acid, a self-replicating material which is **present in nearly
all living organisms** as the main constituent of chromosomes. It is the
**carrier of genetic information**.

> The nitrogen in our DNA, the calcium in our teeth, the iron in our blood,
> the carbon in our apple pies were made in the interiors of collapsing stars.
> We are made of starstuff.
> **-- Carl Sagan, Cosmos**

The nucleotide in DNA consists of a sugar (deoxyribose), one of four bases
(cytosine (C), thymine (T), adenine (A), guanine (G)), and a phosphate.
Cytosine and thymine are pyrimidine bases, while adenine and guanine are purine
bases. The sugar and the base together are called a nucleoside.

![DNA](/assets/posts/dna-sequence/dna-basics.jpg)
*DNA (a) forms a double stranded helix, and (b) adenine pairs with thymine and
cytosine pairs with guanine. (credit a: modification of work by Jerome Walker,
Dennis Myts)*

## Encode binary data into DNA sequence

As an input file you can use any file you want:

- ASCII files,
- Compiled programs,
- Multimedia files (MP3, MP4, MVK, etc),
- Images,
- Database files,
- etc.

Note: If you would copy all the bytes from RAM to file or pipe data to file you
could encode also this data as long as you provide file pointer to the encoder.

### Basic Encoding

As already mentioned, the Basic Encoding is based on a simple mapping. Since DNA
is composed of 4 nucleotides (Adenine, Cytosine, Guanine, Thymine; usually
referred using the first letter). Using this technique we can encode

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 -907.9672135000189 11313.37788460873 1185.0382429179317" style="width: 26.259ex; height: 2.721ex; vertical-align: -0.68ex; margin: 1px 0px;"><g stroke="black" fill="black" stroke-width="0" transform="matrix(1 0 0 -1 0 0)"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-6C"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-6F" x="303" y="0"/><g transform="translate(793,0)"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-67"/><use transform="scale(0.7071067811865476)" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-32" x="681" y="-213"/></g><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-28" x="1732" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-34" x="2126" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-29" x="2631" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-3D" x="3302" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-6C" x="4363" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-6F" x="4666" y="0"/><g transform="translate(5156,0)"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-67"/><use transform="scale(0.7071067811865476)" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-32" x="681" y="-213"/></g><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-28" x="6095" y="0"/><g transform="translate(6489,0)"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-32"/><use transform="scale(0.7071067811865476)" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-32" x="714" y="583"/></g><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-29" x="7451" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-3D" x="8123" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMAIN-32" x="9184" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-62" x="9689" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-69" x="10123" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-74" x="10473" y="0"/><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#MJMATHI-73" x="10839" y="0"/></g><defs id="MathJax_SVG_glyphs"><path id="MJSZ2-2211" stroke-width="10" d="M60 948Q63 950 665 950H1267L1325 815Q1384 677 1388 669H1348L1341 683Q1320 724 1285 761Q1235 809 1174 838T1033 881T882 898T699 902H574H543H251L259 891Q722 258 724 252Q725 250 724 246Q721 243 460 -56L196 -356Q196 -357 407 -357Q459 -357 548 -357T676 -358Q812 -358 896 -353T1063 -332T1204 -283T1307 -196Q1328 -170 1348 -124H1388Q1388 -125 1381 -145T1356 -210T1325 -294L1267 -449L666 -450Q64 -450 61 -448Q55 -446 55 -439Q55 -437 57 -433L590 177Q590 178 557 222T452 366T322 544L56 909L55 924Q55 945 60 948Z"/><path id="MJMATHI-69" stroke-width="10" d="M184 600Q184 624 203 642T247 661Q265 661 277 649T290 619Q290 596 270 577T226 557Q211 557 198 567T184 600ZM21 287Q21 295 30 318T54 369T98 420T158 442Q197 442 223 419T250 357Q250 340 236 301T196 196T154 83Q149 61 149 51Q149 26 166 26Q175 26 185 29T208 43T235 78T260 137Q263 149 265 151T282 153Q302 153 302 143Q302 135 293 112T268 61T223 11T161 -11Q129 -11 102 10T74 74Q74 91 79 106T122 220Q160 321 166 341T173 380Q173 404 156 404H154Q124 404 99 371T61 287Q60 286 59 284T58 281T56 279T53 278T49 278T41 278H27Q21 284 21 287Z"/><path id="MJMAIN-3D" stroke-width="10" d="M56 347Q56 360 70 367H707Q722 359 722 347Q722 336 708 328L390 327H72Q56 332 56 347ZM56 153Q56 168 72 173H708Q722 163 722 153Q722 140 707 133H70Q56 140 56 153Z"/><path id="MJMAIN-30" stroke-width="10" d="M96 585Q152 666 249 666Q297 666 345 640T423 548Q460 465 460 320Q460 165 417 83Q397 41 362 16T301 -15T250 -22Q224 -22 198 -16T137 16T82 83Q39 165 39 320Q39 494 96 585ZM321 597Q291 629 250 629Q208 629 178 597Q153 571 145 525T137 333Q137 175 145 125T181 46Q209 16 250 16Q290 16 318 46Q347 76 354 130T362 333Q362 478 354 524T321 597Z"/><path id="MJMATHI-6E" stroke-width="10" d="M21 287Q22 293 24 303T36 341T56 388T89 425T135 442Q171 442 195 424T225 390T231 369Q231 367 232 367L243 378Q304 442 382 442Q436 442 469 415T503 336T465 179T427 52Q427 26 444 26Q450 26 453 27Q482 32 505 65T540 145Q542 153 560 153Q580 153 580 145Q580 144 576 130Q568 101 554 73T508 17T439 -10Q392 -10 371 17T350 73Q350 92 386 193T423 345Q423 404 379 404H374Q288 404 229 303L222 291L189 157Q156 26 151 16Q138 -11 108 -11Q95 -11 87 -5T76 7T74 17Q74 30 112 180T152 343Q153 348 153 366Q153 405 129 405Q91 405 66 305Q60 285 60 284Q58 278 41 278H27Q21 284 21 287Z"/><path id="MJMAIN-28" stroke-width="10" d="M94 250Q94 319 104 381T127 488T164 576T202 643T244 695T277 729T302 750H315H319Q333 750 333 741Q333 738 316 720T275 667T226 581T184 443T167 250T184 58T225 -81T274 -167T316 -220T333 -241Q333 -250 318 -250H315H302L274 -226Q180 -141 137 -14T94 250Z"/><path id="MJMAIN-2B" stroke-width="10" d="M56 237T56 250T70 270H369V420L370 570Q380 583 389 583Q402 583 409 568V270H707Q722 262 722 250T707 230H409V-68Q401 -82 391 -82H389H387Q375 -82 369 -68V230H70Q56 237 56 250Z"/><path id="MJMAIN-31" stroke-width="10" d="M213 578L200 573Q186 568 160 563T102 556H83V602H102Q149 604 189 617T245 641T273 663Q275 666 285 666Q294 666 302 660V361L303 61Q310 54 315 52T339 48T401 46H427V0H416Q395 3 257 3Q121 3 100 0H88V46H114Q136 46 152 46T177 47T193 50T201 52T207 57T213 61V578Z"/><path id="MJMAIN-29" stroke-width="10" d="M60 749L64 750Q69 750 74 750H86L114 726Q208 641 251 514T294 250Q294 182 284 119T261 12T224 -76T186 -143T145 -194T113 -227T90 -246Q87 -249 86 -250H74Q66 -250 63 -250T58 -247T55 -238Q56 -237 66 -225Q221 -64 221 250T66 725Q56 737 55 738Q55 746 60 749Z"/><path id="MJMAIN-32" stroke-width="10" d="M109 429Q82 429 66 447T50 491Q50 562 103 614T235 666Q326 666 387 610T449 465Q449 422 429 383T381 315T301 241Q265 210 201 149L142 93L218 92Q375 92 385 97Q392 99 409 186V189H449V186Q448 183 436 95T421 3V0H50V19V31Q50 38 56 46T86 81Q115 113 136 137Q145 147 170 174T204 211T233 244T261 278T284 308T305 340T320 369T333 401T340 431T343 464Q343 527 309 573T212 619Q179 619 154 602T119 569T109 550Q109 549 114 549Q132 549 151 535T170 489Q170 464 154 447T109 429Z"/><path id="MJMATHI-6C" stroke-width="10" d="M117 59Q117 26 142 26Q179 26 205 131Q211 151 215 152Q217 153 225 153H229Q238 153 241 153T246 151T248 144Q247 138 245 128T234 90T214 43T183 6T137 -11Q101 -11 70 11T38 85Q38 97 39 102L104 360Q167 615 167 623Q167 626 166 628T162 632T157 634T149 635T141 636T132 637T122 637Q112 637 109 637T101 638T95 641T94 647Q94 649 96 661Q101 680 107 682T179 688Q194 689 213 690T243 693T254 694Q266 694 266 686Q266 675 193 386T118 83Q118 81 118 75T117 65V59Z"/><path id="MJMATHI-6F" stroke-width="10" d="M201 -11Q126 -11 80 38T34 156Q34 221 64 279T146 380Q222 441 301 441Q333 441 341 440Q354 437 367 433T402 417T438 387T464 338T476 268Q476 161 390 75T201 -11ZM121 120Q121 70 147 48T206 26Q250 26 289 58T351 142Q360 163 374 216T388 308Q388 352 370 375Q346 405 306 405Q243 405 195 347Q158 303 140 230T121 120Z"/><path id="MJMATHI-67" stroke-width="10" d="M311 43Q296 30 267 15T206 0Q143 0 105 45T66 160Q66 265 143 353T314 442Q361 442 401 394L404 398Q406 401 409 404T418 412T431 419T447 422Q461 422 470 413T480 394Q480 379 423 152T363 -80Q345 -134 286 -169T151 -205Q10 -205 10 -137Q10 -111 28 -91T74 -71Q89 -71 102 -80T116 -111Q116 -121 114 -130T107 -144T99 -154T92 -162L90 -164H91Q101 -167 151 -167Q189 -167 211 -155Q234 -144 254 -122T282 -75Q288 -56 298 -13Q311 35 311 43ZM384 328L380 339Q377 350 375 354T369 368T359 382T346 393T328 402T306 405Q262 405 221 352Q191 313 171 233T151 117Q151 38 213 38Q269 38 323 108L331 118L384 328Z"/><path id="MJMAIN-34" stroke-width="10" d="M462 0Q444 3 333 3Q217 3 199 0H190V46H221Q241 46 248 46T265 48T279 53T286 61Q287 63 287 115V165H28V211L179 442Q332 674 334 675Q336 677 355 677H373L379 671V211H471V165H379V114Q379 73 379 66T385 54Q393 47 442 46H471V0H462ZM293 211V545L74 212L183 211H293Z"/><path id="MJMATHI-62" stroke-width="10" d="M73 647Q73 657 77 670T89 683Q90 683 161 688T234 694Q246 694 246 685T212 542Q204 508 195 472T180 418L176 399Q176 396 182 402Q231 442 283 442Q345 442 383 396T422 280Q422 169 343 79T173 -11Q123 -11 82 27T40 150V159Q40 180 48 217T97 414Q147 611 147 623T109 637Q104 637 101 637H96Q86 637 83 637T76 640T73 647ZM336 325V331Q336 405 275 405Q258 405 240 397T207 376T181 352T163 330L157 322L136 236Q114 150 114 114Q114 66 138 42Q154 26 178 26Q211 26 245 58Q270 81 285 114T318 219Q336 291 336 325Z"/><path id="MJMATHI-74" stroke-width="10" d="M26 385Q19 392 19 395Q19 399 22 411T27 425Q29 430 36 430T87 431H140L159 511Q162 522 166 540T173 566T179 586T187 603T197 615T211 624T229 626Q247 625 254 615T261 596Q261 589 252 549T232 470L222 433Q222 431 272 431H323Q330 424 330 420Q330 398 317 385H210L174 240Q135 80 135 68Q135 26 162 26Q197 26 230 60T283 144Q285 150 288 151T303 153H307Q322 153 322 145Q322 142 319 133Q314 117 301 95T267 48T216 6T155 -11Q125 -11 98 4T59 56Q57 64 57 83V101L92 241Q127 382 128 383Q128 385 77 385H26Z"/><path id="MJMATHI-73" stroke-width="10" d="M131 289Q131 321 147 354T203 415T300 442Q362 442 390 415T419 355Q419 323 402 308T364 292Q351 292 340 300T328 326Q328 342 337 354T354 372T367 378Q368 378 368 379Q368 382 361 388T336 399T297 405Q249 405 227 379T204 326Q204 301 223 291T278 274T330 259Q396 230 396 163Q396 135 385 107T352 51T289 7T195 -10Q118 -10 86 19T53 87Q53 126 74 143T118 160Q133 160 146 151T160 120Q160 94 142 76T111 58Q109 57 108 57T107 55Q108 52 115 47T146 34T201 27Q237 27 263 38T301 66T318 97T323 122Q323 150 302 164T254 181T195 196T148 231Q131 256 131 289Z"/></defs></svg>

using a single nucleotide. In this way, we are able to use the 4 bases that
compose the DNA strand to encode each byte of data.

| Two bits | Nucleotides      |
| -------- | ---------------- |
| 00       | **A** (Adenine)  |
| 10       | **G** (Guanine)  |
| 01       | **C** (Cytosine) |
| 11       | **T** (Thymine)  |

With this in mind we can simply encode any data by using two-bit to Nucleotides
conversion.

```python
{ Algorithm 1: Naive byte array to DNA encode }
procedure EncodeToDNASequence(f) string
begin
  enc string
  while not eof(f) do
    c byte := buffer[0]                             { Read 1 byte from buffer }
    bin integer := sprintf('08b', c)                { Convert to string binary }
    for e in range[0, 2, 4, 6] do
      if e[0] == 48 and e[1] == 48 then             { 0x00 - A (Adenine) }
        enc += 'A'
      else if e[0] == 48 and e[1] == 49 then        { 0x01 - G (Guanine) }
        enc += 'G'
      else if e[0] == 49 and e[1] == 48 then        { 0x10 - C (Cytosine) }
        enc += 'C'
      else if e[0] == 49 and e[1] == 49 then        { 0x11 - T (Thymine) }
        enc += 'T'
  return enc                                        { Return DNA sequence }
end
```

Another encoding would be **Goldman encoding**. Using this encoding helps with
Nonsense mutation (amino acids replaced by a stop codon) that occurs and is the
most problematic during translation because it leads to truncated amino acid
sequences, which in turn results in truncated proteins.

[Where to store big data? In DNA: Nick Goldman at TEDxPrague](https://www.youtube.com/watch?v=a4PiGWNsIEU)

### FASTA file format

In bioinformatics, FASTA format is a text-based format for representing either
nucleotide sequences or peptide sequences, in which nucleotides or amino acids
are represented using single-letter codes. The format also allows for sequence
names and comments to precede the sequences. The format originates from the
FASTA software package, but has now become a standard in the field of
bioinformatics.

The first line in a FASTA file started either with a ">" (greater-than) symbol
or, less frequently, a ";" (semicolon) was taken as a comment. Subsequent lines
starting with a semicolon would be ignored by software. Since the only comment
used was the first, it quickly became used to hold a summary description of the
sequence, often starting with a unique library accession number, and with time
it has become commonplace to always use ">" for the first line and to not use
";" comments (which would otherwise be ignored).

```txt
;LCBO - Prolactin precursor - Bovine
; a sample sequence in FASTA format
MDSKGSSQKGSRLLLLLVVSNLLLCQGVVSTPVCPNGPGNCQVSLRDLFDRAVMVSHYIHDLSS
EMFNEFDKRYAQGKGFITMALNSCHTSSLPTPEDKEQAQQTHHEVLMSLILGLLRSWNDPLYHL
VTEVRGMKGAPDAILSRAIEIEEENKRLLEGMEMIFGQVIPGAKETEPYPVWSGLPSLQTKDED
ARYSAFYNLLHCLRRDSSKIDTYLKLLNCRIIYNNNC*

>MCHU - Calmodulin - Human, rabbit, bovine, rat, and chicken
ADQLTEEQIAEFKEAFSLFDKDGDGTITTKELGTVMRSLGQNPTEAELQDMINEVDADGNGTID
FPEFLTMMARKMKDTDSEEEIREAFRVFDKDGNGYISAAELRHVMTNLGEKLTDEEVDEMIREA
DIDGDGQVNYEEFVQMMTAK*

>gi|5524211|gb|AAD44166.1| cytochrome b [Elephas maximus maximus]
LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
EWIWGGFSVDKATLNRFFAFHFILPFTMVALAGVHLTFLHETGSNNPLGLTSDSDKIPFHPYYTIKDFLG
LLILILLLLLLALLSPDMLGDPDNHMPADPLNTPLHIKPEWYFLFAYAILRSVPNKLGGVLALFLSIVIL
GLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX
IENY
```

FASTA format was extended by [FASTQ](https://en.wikipedia.org/wiki/FASTQ_format)
format from the [Sanger Centre](https://www.sanger.ac.uk/) in Cambridge.

### PNG encoded DNA sequence

| Nucleotides  | RGB         | Color name |
| ------------ | ----------- | ---------- |
| A ➞ Adenine  | (0,0,255)   | Blue       |
| G ➞ Guanine  | (0,100,0)   | Green      |
| C ➞ Cytosine | (255,0,0)   | Red        |
| T ➞ Thymine  | (255,255,0) | Yellow     |

With this in mind we can create a simple algorithm to create PNG representation
of a DNA sequence.

```python
{ Algorithm 2: Naive DNA to PNG encode from FASTA file }
procedure EncodeDNASequenceToPNG(f)
begin
  i image
  while not eof(f) do
    c char := buffer[0]                             { Read 1 char from buffer }
    case c of
      'A': color := RGB(0, 0, 255)                  { Blue }
      'G': color := RGB(0, 100, 0)                  { Green }
      'C': color := RGB(255, 0, 0)                  { Red }
      'T': color := RGB(255, 255, 0)                { Yellow }
    drawRect(i, [x, y], color)
  save(i)                                           { Save PNG image }
end
```

## Encoding text file in practice

In this example we will take a simple text file as our input stream for
encoding. This file will have a quote from Niels Bohr and saved as txt file.

> How wonderful that we have met with a paradox. Now we have some hope of
> making progress.
> ― Niels Bohr

First we encode text file into FASTA file.

```bash
./dnae-encode -i quote.txt -o quote.fa
2019/01/10 00:38:29 Gathering input file stats
2019/01/10 00:38:29 Starting encoding ...
 106 B / 106 B [==================================] 100.00% 0s
2019/01/10 00:38:29 Saving to FASTA file ...
2019/01/10 00:38:29 Output FASTA file length is 438 B
2019/01/10 00:38:29 Process took 987.263µs
2019/01/10 00:38:29 Done ...
```

Output of `quote.fa` file contains the encoded DNA sequence in ASCII format.

```txt
>SEQ1
GACAGCTTGTGTACAAGTGTGCTTGCTCGCGAGCGGGTACGCGCGTGGGCTAACAAGTGA
GCCAGCAGGTGAACAAGTGTGCGGACAAGCCAGCAGGTGCGCGGACAAGCTGGCGGGTGA
ACAAGTGTGCCGGTGAGCCAACAAGCAGACAAGTAAGCAGGTACGCAGGCGAGCTTGTCA
ACTCACAAGATCGCTTGTGTACAAGTGTGCGGACAAGCCAGCAGGTGCGCGGACAAGTAT
GCTTGCTGGCGGACAAGCCAGCTTGTAAGCGGACAAGCTTGCGCACAAGCTGGCAGGCCT
GCCGGCTCGCGTACAAATTCACAAGTAAGTACGCTTGCGTGTACGCGGGTATGTATACTC
AACCTCACCAAACGGGACAAGATCGCCGGCGGGCTAGTATACAAGAACGCTTGCCAGTAC
AACC
```

Then we encode FASTA file from previous operation to encode this data into PNG.

```bash
./dnae-png -i quote.fa -o quote.png
2019/01/10 00:40:09 Gathering input file stats ...
2019/01/10 00:40:09 Deconstructing FASTA file ...
2019/01/10 00:40:09 Compositing image file ...
 424 / 424 [==================================] 100.00% 0s
2019/01/10 00:40:09 Saving output file ...
2019/01/10 00:40:09 Output image file length is 1.1 kB
2019/01/10 00:40:09 Process took 19.036117ms
2019/01/10 00:40:09 Done ...
```

After encoding into PNG format this file looks like this.

![Encoded Quote in PNG format](/assets/posts/dna-sequence/quote.png)
The larger the input stream is the larger the PNG file would be.

Compiled basic Hello World C program with
[GCC](https://www.gnu.org/software/gcc/) would [look
like](/assets/posts/dna-sequence/sample.png).

```c
// gcc -O3 -o sample sample.c
#include <stdio.h>

main() {
  printf("Hello, world!\n");
  return 0;
}
```

## Toolkit for encoding data

I have created a toolkit with two main programs:

- dnae-encode (encodes file into FASTA file)
- dnae-png (encodes FASTA file into PNG)

Toolkit with full source code is available on
[github.com/mitjafelicijan/dna-encoding](https://github.com/mitjafelicijan/dna-encoding).

### dnae-encode

```bash
> ./dnae-encode --help
usage: dnae-encode --input=INPUT [<flags>]

A command-line application that encodes file into DNA sequence.

Flags:
      --help             Show context-sensitive help (also try --help-long and --help-man).
  -i, --input=INPUT      Input file (ASCII or binary) which will be encoded into DNA sequence.
  -o, --output="out.fa"  Output file which stores DNA sequence in FASTA format.
  -s, --sequence=SEQ1    The description line (defline) or header/identifier line, gives a name and/or a unique identifier for the sequence.
  -c, --columns=60       Row characters length (no more than 120 characters). Devices preallocate fixed line sizes in software.
      --version          Show application version.
```

### dnae-png

```bash
> ./dnae-png --help
usage: dnae-png --input=INPUT [<flags>]

A command-line application that encodes FASTA file into PNG image.

Flags:
      --help              Show context-sensitive help (also try --help-long and --help-man).
  -i, --input=INPUT       Input FASTA file which will be encoded into PNG image.
  -o, --output="out.png"  Output file in PNG format that represents DNA sequence in graphical way.
  -s, --size=10           Size of pairings of DNA bases on image in pixels (lower resolution lower file size).
      --version           Show application version.
```

## Benchmarks

First we generate some binary sample data with dd.

```bash
dd if=<(openssl enc -aes-256-ctr  -pass pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" -nosalt < /dev/zero) of=1KB.bin bs=1KB count=1 iflag=fullblock
```


![Sample binary file 1KB](/assets/posts/dna-sequence/sample-binary-file.png)
Our freshly generated 1KB file looks something like this (its full of
garbage data as intended).

We create following binary files:

- 1KB.bin
- 10KB.bin
- 100KB.bin
- 1MB.bin
- 10MB.bin
- 100MB.bin

After this we create FASTA files for all the binary files by encoding them
into DNA sequence.

```bash
./dnae-encode -i 100MB.bin -o 100MB.fa
```

Then we GZIP all the FASTA files to see how much the can be compressed.

```bash
gzip -9 < 10MB.fa > 10MB.fa.gz
```

![Encode to FASTA](/assets/posts/dna-sequence/chart-speed.svg)
The speed increase that occurs when encoding to FASTA format.

![File sizes](/assets/posts/dna-sequence/chart-size.svg)
Size of the out file after encoding.

[Download CSV file with benchmarks](/assets/posts/dna-sequence/benchmarks.csv).

## References

- https://www.techopedia.com/definition/948/encoding
- https://www.dna-worldwide.com/resource/160/history-dna-timeline
- https://opentextbc.ca/biology/chapter/9-1-the-structure-of-dna/
- https://arxiv.org/abs/1801.04774
- https://en.wikipedia.org/wiki/FASTA_format
