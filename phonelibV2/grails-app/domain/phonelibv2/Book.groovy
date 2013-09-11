package phonelibv2

class Book {

	String title
	String isbn13
	
    static constraints = {
		title(blank:false, nullable:false, unique:true)
		isbn13(blank:false, unique:false)
    }
	
	static hasMany=[own:Own,borrow:Borrow]	
}
