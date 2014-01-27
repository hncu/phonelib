package phonelibv2

class ShiroUser {
    String username
    String passwordHash
	String email
	String btouxiang
	String mtouxiang
	String stouxiang
	String realname
	String weibo
	String qq
	String weixin
	String nickname
	String province
	String city
	String sex
//	Date   birthday
//	String weiZhi
//	String touXiangURL
	
    
    static hasMany = [ roles: ShiroRole, permissions: String ,owner:Borrow,borrower:Borrow,own:Own,sender:InternalMessage,recipient:InternalMessage]

    static constraints = {
    	username(nullable: false, blank: false, unique: true,size:3..20)
    	passwordHash(nullable: false, blank: false,size:6..70)//哈希算法后加密，长度权限没有
		email(nullable:true,blank:false,unique:true,email: true)
		nickname(nullable: true, blank: true, unique: true,size:3..20)
		btouxiang(blank:true,nullable:true)
		mtouxiang(blank:true,nullable:true)
		stouxiang(blank:true,nullable:true)
		city(nullable:true)
		province(nullable:true)
		qq(nullable:true)
		realname(nullable:true)
		sex(nullable:true)
		weibo(nullable:true)
		weixin(nullable:true)
    }
	
	static mappedBy=[owner:'owner',borrower:'borrower',sender:'sender',recipient:'recipient']
}
