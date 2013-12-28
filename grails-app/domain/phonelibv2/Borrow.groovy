package phonelibv2

import java.util.Date;

class Borrow {
	ShiroUser owner
	ShiroUser borrower
	
	Date dateCreated
	static belongsTo=[book:Book]
}
