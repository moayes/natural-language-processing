/**
 * Copyright (c) 2017 Soheil Moayedi Azarpour
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

let text: NSString = """
Not only do they dominate our daily lives, but as their stocks continue to soar, these technology giants may also dictate our financial futures.

In the last three years, their share prices have risen far faster than the major market indexes — Amazon leads the way, up 206 percent; Apple trails the pack with a 67 percent gain — as investors of virtually every stripe have piled into these companies.

But this gold-rush mentality, reminiscent of investor frenzies for Nifty 50 stocks in the late 1970s and the dot-com boom and bust at the end of the last century, is giving investors pause. Not because they think these companies will crack, as many did in previous market corrections, but because in the parlance of the industry, the trade has become very crowded.

Mr. Dodd, a maker of musical instruments in northern England, joined an experiment. He and around 10,000 others volunteered their data, allowing researchers to monitor in real time which political ads were showing up in their Facebook news feeds as Britain’s election approached.

Their goal: to shed more light on how political campaigns are using Facebook and other digital services — technologies that are quickly reshaping the democratic process, but which often offer few details about their outsize roles in elections worldwide.
"""

// Create a tagger with "nameType" scheme to find proper names such as
// personal, organization and place names.
let tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.nameType], options: 0)
tagger.string = String(text)

// Whole range of text.
let range: NSRange = NSMakeRange(0, text.length)

// Consider compound names, like Amazon Inc. as one word.
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

// Interested in all names.
let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

var personals: [String] = []
var places: [String] = []
var organizations: [String] = []

// Enumerate through recognized tokens.
tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { (tag, tokenRange, stop) in
  guard let tag = tag else { return }
  let token = text.substring(with: tokenRange)
  
  switch tag {
  case .personalName: personals.append(token)
  case .placeName: places.append(token)
  case .organizationName: organizations.append(token)
  default: break
  }
}

print("""
  Persons:\n\(personals)\n\n
  Places:\n\(places)\n\n
  Organizations:\n\(organizations)\n\n
""")
