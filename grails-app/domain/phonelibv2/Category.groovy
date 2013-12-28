package phonelibv2

class Category {
	
	String cname
	
	static hasMany = [books:Book]
	
	static constraints = {
		cname(blank:false)
	}
	

	static mappedBy=[cname:'cname']

}