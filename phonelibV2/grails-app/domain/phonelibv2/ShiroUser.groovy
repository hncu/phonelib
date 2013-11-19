package phonelibv2

class ShiroUser {
    String username
    String passwordHash
	
//	Integer numOwn
//	Integer numBorrowin
//	Integer numBorrowout
	//��ע��ʱ��ʼ��Ϊ0
    
    static hasMany = [ roles: ShiroRole, permissions: String ,owner:Borrow,borrower:Borrow,own:Own]

    static constraints = {
        username(nullable: false, blank: false, unique: true)
    }
	
	static mappedBy=[owner:'owner',borrower:'borrower']
}
