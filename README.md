# Size-proportionate Bijective Encoding

The following repository contains two files `CatL.hs` and `GCat.hs` which are an generalisation of Size-proportionate Bijective encoding / decodings
for de Bruijn terms over Cat (Catalan Objects). The generalised de Bruijn terms notation is compressed into combinatorial objects, in particular,
binary tree data structures. Each term is tested by yielding large random numbers by encoding / decoding terms all efficiently represented through
Haskell classes.

De Bruijn terms are another class of syntax for formal Lambda calculi whereby variables within some application binds to the inner notation
of the Lambda term rather than its outer body. Key logical rules must apply and as long as the arity of the application holds, two formal terms in both
Lambda and de Bruijn should hold as equal - even though the notation differs. Therefore, de Bruijn terms are applicative arity-reserving notations for 
formal Lambda calculi. With this in mind, any terms in Lambda that are too complex to capture in notation can be encoded into de Bruijn terms as an 
alternative. 

Original paper written by Paul Tarau, provided source of inspiration for continuous experimentation. 

## License

```
Copyright © 2017

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the “Software”),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```


