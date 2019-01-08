---

layout: post
title: Encoding binary data into DNA sequence
description: ok

---

**Table of contents**

1. [Initial thoughts](#initial-thoughts)
2. [Data encoding](#data-encoding)
3. [Glossary](#glossary)
4. [Bit of theory and history](#bit-of-theory-and-history)
   1. [Quick history of DNA](#quick-history-of-dna)
   2. [What is DNA?](#what-is-dna)
5. [Encode binary data into DNA sequence](#encode-binary-data-into-dna-sequence)
   1. [Basic Encoding](#basic-encoding)
   2. [FASTA file format](#fasta-file-format)
   3. [PNG encoded DNA sequence](#png-encoded-dna-sequence)
6. [References](#references)

## Initial thoughts

Todo ...

## Data encoding

**TL;DR:** Encoding involves the use of a code to change original data into a form that can be used by an external process [^1].

Encoding is the process of converting data into a format required for a number of information processing needs, including:

- Program compiling and execution
- Data transmission, storage and compression/decompression
- Application data processing, such as file conversion

Encoding can have two meanings[^1]:

- In computer technology, encoding is the process of applying a specific code, such as letters, symbols and numbers, to data for conversion into an equivalent cipher.
- In electronics, encoding refers to analog to digital conversion.

## Glossary

**deoxyribose**
:  A five-carbon sugar molecule with a hydrogen atom rather than a hydroxyl group in the 2′ position; the sugar component of DNA nucleotides.

**double helix**
:  The molecular shape of DNA in which two strands of nucleotides wind around each other in a spiral shape.

**nitrogenous base**
:  A nitrogen-containing molecule that acts as a base; often referring to one of the purine or pyrimidine components of nucleic acids.

**phosphate group**
:  A molecular group consisting of a central phosphorus atom bound to four oxygen atoms.

## Bit of theory and history

History and explanation of what DNA is and where is used.

### Quick history of DNA

- **1869** - Friedrich Miescher identifies "nuclein".
- **1900s** - The Eugenics Movement.
- **1900** – Mendel's theories are rediscovered by researchers.
- **1902** - Sir Archibald Edward Garrod is the first to associate Mendel's theories with a human disease.
- **1944** - Oswald Avery identifies DNA as the 'transforming principle'.
- **1950** - Erwin Chargaff discovers that DNA composition is species specific.
- **1952** - Rosalind Franklin photographs crystallized DNA fibres.
- **1953** - James Watson and Francis Crick discover the double helix structure of DNA.
- **1953** - George Gamow and the “RNA Tie Club”.
- **1959** - An additional copy of chromosome 21 linked to Down's syndrome.
- **1965** - Marshall Nirenberg is the first person to sequence the bases in each codon.
- **1977** - Frederick Sanger develops rapid DNA sequencing techniques.
- **1983** - Huntington's disease is the first mapped genetic disease.
- **1990** - The first gene found to be associated with increased susceptibility to familial breast and ovarian cancer is identified.
- **1990** - The Human Genome Project begins.
- **1995** - Haemophilus Influenzae is the first bacterium genome sequenced.
- **1996** - Dolly the sheep is cloned.
- **1996** - 'Bermuda Principles' established.
- **1999** - First human chromosome is decoded.
- **2000** – Genetic code of the fruit fly is decoded.
- **2002** – Mouse is the first mammal to have its genome decoded.
- **2003** – The Human Genome Project is completed.
- **2013** – DNA Worldwide and Eurofins Forensic discover identical twins have differences in their genetic makeup [^2].

### What is DNA?

Deoxyribonucleic acid, a self-replicating material which is **present in nearly all living organisms** as the main constituent of chromosomes. It is the **carrier of genetic information**.

> The nitrogen in our DNA, the calcium in our teeth, the iron in our blood, the carbon in our apple pies were made in the interiors of collapsing stars. We are made of starstuff.
>
> **-- Carl Sagan, Cosmos**

The nucleotide in DNA consists of a sugar (deoxyribose), one of four bases (cytosine (C), thymine (T), adenine (A), guanine (G)), and a phosphate. Cytosine and thymine are pyrimidine bases, while adenine and guanine are purine bases. The sugar and the base together are called a nucleoside.

![DNA](/files/dna-sequence/dna-basics.jpg#center)

*DNA (a) forms a double stranded helix, and (b) adenine pairs with thymine and cytosine pairs with guanine. (credit a: modification of work by Jerome Walker, Dennis Myts) [^3]*

## Encode binary data into DNA sequence

Todo ...

As an input file you can use any file you want:
- ASCII files,
- Compiled programs,
- Multimedia files (MP3, MP4, MVK, etc),
- Images,
- Database files,
- etc.

Note: If you would copy all the bytes from RAM to file or pipe data to file you could encode also this data as long as you provide file pointer to the encoder.

### Basic Encoding

As already mentioned, the Basic Encoding is based on a simple mapping. Since DNA is composed of 4 nucleotides (Adenine, Cytosine, Guanine, Thymine; usually referred using the first letter). Using this technique we can encode log<sub>2</sub>(4) = log<sub>2</sub>(2<sup>2</sup>) = 2 bits using a single nucleotide. In this way, we are able to use the 4 bases that compose the DNA strand to encode each byte of data. [^4]

| Two bits | Nucleotides      |
| -------- | ---------------- |
| 00       | **A** (Adenine)  |
| 10       | **G** (Guanine)  |
| 01       | **C** (Cytosine) |
| 11       | **T** (Thymine)  |

With this in mind we can simply encode any data by using two-bit to Nucleotides conversion

![DNA](/files/dna-sequence/algorithm-binary-to-dna.png#center)

### FASTA file format

Todo ...

### PNG encoded DNA sequence

Todo ...



## References

[^1]: https://www.techopedia.com/definition/948/encoding
[^2]: https://www.dna-worldwide.com/resource/160/history-dna-timeline
[^3]: https://opentextbc.ca/biology/chapter/9-1-the-structure-of-dna/
[^4]: https://arxiv.org/abs/1801.04774
