package phonelibv2

class ShiroUser {
    String username
    String passwordHash
	String email
	String btouxiang
	String mtouxiang
	String stouxiang
//	String adress;
//	String niCheng = "无名氏"
//	Date   birthday
//	String weiZhi
//	String touXiangURL
	
    
    static hasMany = [ roles: ShiroRole, permissions: String ,owner:Borrow,borrower:Borrow,own:Own,sender:InternalMessage,recipient:InternalMessage]

    static constraints = {
    	username(nullable: false, blank: false, unique: true,size:3..20)
    	passwordHash(nullable: false, blank: false,size:6..70)//哈希算法后加密，长度权限没有
		email(nullable:false,blank:false,unique:true,email: true)
		btouxiang(blank:true,nullable:true)
		mtouxiang(blank:true,nullable:true)
		stouxiang(blank:true,nullable:true)
    }
	
	static mappedBy=[owner:'owner',borrower:'borrower',sender:'sender',recipient:'recipient']
}
