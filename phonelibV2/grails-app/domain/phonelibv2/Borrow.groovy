package phonelibv2

import java.util.Date;

class Borrow {
	User owner
	User borrower
	
	Date dateCreated
	static belongsTo=[book:Book]
}
