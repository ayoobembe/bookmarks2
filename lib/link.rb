class Link
	#makes instances of this class datamapper resources
	include DataMapper::Resource

	property :id,			Serial
	property :title, 	String
	property :url, 		String
	has n, :tags, :through => Resource

end