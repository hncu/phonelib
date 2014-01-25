package phonelibv2

import java.util.Date;

class Borrow {
	ShiroUser owner
	ShiroUser borrower
	int borrowStatus //2未处理 1同意借 0 不同意借3正在交易4已借阅5已退还
	Boolean borrowerAck	
	Boolean ownerAck
	Date dateCreated
	Date dateBack
	static belongsTo=[book:Book]
	static constraints = {
		owner(nullable:true,blank:true)
	}
}
