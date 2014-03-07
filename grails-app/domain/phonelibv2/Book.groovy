package phonelibv2

import org.hibernate.type.LongType;

class Book {

	String title
	String isbn13
	String author
	String publisher
	String pubdate
	String summary	
	String imageUrl
	String tags
    static constraints = {
		title(blank:false, nullable:false, unique:false)
		isbn13(blank:false, unique:false)
		author(nullable:true)
		publisher(nullable:true)
		pubdate(nullable:true)
		summary(nullable:true)
		imageUrl(nullable:true)
		tags(nullable:true)
    }
	
	static hasMany=[own:Own,borrow:Borrow]	
	static belongsTo = [category:Category]
}
