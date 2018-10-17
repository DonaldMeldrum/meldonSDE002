require 'test/unit/assertions'
require_relative 'gr-twain-quotes'
require 'nokogiri'

include Test::Unit::Assertions

#Test input validation

#Confirm GR.com page is accessible
htmlDoc = getSiteHtml('https://goodreads.com', 'badUser', 'badPass')
assert_not_nil(htmlDoc, 'Site html is nil')

#Confirm bad url results in error message

#Confirm page can be parsed

#Confirm Element lookup returns correct number
quoteArray = getTopQuotes(htmlDoc, 10)
assert_not_nil(quoteArray, 'Quote array is nil')
assert_equal(10, quoteArray.length, 'Quote count wrong')

#Confirm Quote elements are non-nil

#Confirm json result is non-nil

#Perform json lint

#Confirm file gets created in current directory
testFileName = 'gr-twain-qoutes-testdata.json'
if (File.exists?(testFileName))
	File.delete(testFileName)
end
saveToFile(testFileName, quoteArray.to_json)
assert(File.exists?(testFileName), 'Testdata not saved')
File.delete(testFileName)

#Perform json lint on file contents

puts 'Tests Passed'