package phonelibv2

class ShiroUser {
    String username
    String passwordHash
    
    static hasMany = [ roles: ShiroRole, permissions: String ,owner:Borrow,borrower:Borrow,own:Own,sender:InternalMessage,recipient:InternalMessage]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
    }
	
	static mappedBy=[owner:'owner',borrower:'borrower',sender:'sender',recipient:'recipient']
}
