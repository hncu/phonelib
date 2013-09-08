package phonelibv2

import java.util.Date;

class Borrow {
	//User owner
	
	Date dateCreated
	static belongsTo=[user:User,book:Book]
}
