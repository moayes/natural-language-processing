# natural-language-processing
A playground that uses Xcode 9 and the new and update API in Foundation This playground uses Xcode beta, and it may not work with feature releases of Xcode 9. You can download the latest version of Xcode 9 from Apple’s developer portal: https://developer.apple.com.

1. Create a `NSLinguisticTagger` object with `NSLinguisticTagScheme.nameType` scheme.
`.nameType` scheme finds proper names like personal, places and organizations based on the context:

```swift
let tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.nameType], options: 0)
```

2. Set the text on the tagger: 

```swift
tagger.string = String(text)
```

3. Specify the range on which you want to run natural language processing, and type of tags you're interested or not interested.

```swift
// Whole range of text.
let range: NSRange = NSMakeRange(0, text.length)

// Consider compound names, like Amazon Inc. as one word.
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
```

4. Specify the tags you're interested:

```swift
// Interested in all names.
let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
```

5. Finally, enumerate through the recognized tags and extract them:

```swift
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
```
