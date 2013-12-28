package phonelibv2

class Category {
	
	String cname
	
	static hasMany = [books:Book]
	
	static constraints = {
		cname(blank:false,nullable:false, unique:true)
	}
	

	static mappedBy=[cname:'cname']
	
	String toString(){
		return cname
	}
	
	

}