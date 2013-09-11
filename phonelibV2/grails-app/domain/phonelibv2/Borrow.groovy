package phonelibv2

import java.util.Date;

class Borrow {
	//User owner
	
	Date dateCreated
	static belongsTo=[userBorrow:User,book:Book]
}
