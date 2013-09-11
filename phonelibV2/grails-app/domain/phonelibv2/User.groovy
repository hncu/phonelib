package phonelibv2

class User {

	String login
	String password

	static constraints = {
		login(blank:false, nullable:false, unique:true)
		password(blank:false, password:true)
	}
	static mappedBy=[owner:'owner',borrower:'borrower']
	static hasMany=[owner:Borrow,borrower:Borrow,own:Own]
}
