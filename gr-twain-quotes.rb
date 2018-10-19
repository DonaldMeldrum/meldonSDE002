require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'htmlentities'

def getSiteHtml(url, user, pass)
	begin
		htmlString = open(url, http_basic_authentication: [user, pass])
		Nokogiri::HTML(htmlString)
	rescue => e
		e.message
	end
end

def getTopQuotes(htmlNode, numQuotes)
	quoteElements = htmlNode.xpath("//div[@class='quoteText']").first(numQuotes).select{|p| p != nil}
	quoteArray = []
	quoteElements.each{|quote| 
		rawQuote = quote.inner_html.split('<br')[0].strip
		decodedQuote = HTMLEntities.new.decode(rawQuote)
		quoteHash = {:quoteText => decodedQuote }
		quoteArray << quoteHash
	}
	return quoteArray
end

def saveToFile(fileName, text)
	output = File.open( fileName,'w' )
	output.write(text)
	output.close		
end

begin

	if (ARGV.length != 2)
		puts 'Missing UserName and password'
		
	else	
		userName = ARGV[0]
		password = ARGV[1]

		numPosts = 10
		url = 'https://www.goodreads.com/author/quotes/1244.Mark_Twain'
		page = getSiteHtml(url, userName, password)
		quoteList = getTopQuotes(page, numPosts)

		fileTime = Time.now.strftime("%Y%m%d%H%M%S") 
		fileName = 'gr-twain-quotes_' + fileTime + '.json'
		fullpath = Dir.home + '/Downloads/' + fileName
		saveToFile(fullpath, quoteList.to_json)

		puts 'Saved last ' + numPosts.to_s + ' quote(s) from ' + url + ' to ' + fullpath
	end 
rescue => e
	puts 'Error encountered:'
	puts e.message
end
