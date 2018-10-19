# meldonSDE002

Script to fetch top 10 Mark Twain quotes on goodreads.com and save them a local file in JSON format.

### Prerequisites

- Install ruby gem nokogiri
- Install ruby gem htmlentities

```
Give examples
```

### Installing

First, make sure you have the latest version of RubyGems and xcode commandline tools:

```
gem update --system
xcode-select --install # Then agree to the terms, even if you have done this before!
```

Install nokogiri:
```
gem install nokogiri
```
If there's any issues refer to http://www.nokogiri.org/tutorials/installing_nokogiri.html#install_with_custom___non_standard_libraries

Install htmlentities
```
gem install htmlentities
```

### Running the script

From command line:
```
ruby gr-twain-quotes.rb {userName} {password}
```

If successful, a file is created in the current directory with the name format: gr-twain-quotes_{timestamp}.json
Otherwise, an error message will display with the accompanying exception message.

### Running unit tests
From command line:
```
ruby gr-twain-quotes-test.rb
```

### How it works

* Get html source using open-uri, using provided credentials for basic auth
* Use Nokogiri gem to parse html
* Use XPath to extract first 10 non-nil quotes
* Create a hash for each post: {:quoteText => quote.text }
* Use json gem to convert array of hashes into JSON array
* Write JSON array string to file in current directory
