package phonelibv2

class User {

	String login
	String password

	static constraints = {
		login(blank:false, nullable:false, unique:true)
		password(blank:false, password:true)
	}
	static hasMany=[borrow:Borrow,own:Own]
}
