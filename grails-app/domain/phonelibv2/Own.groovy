package phonelibv2

import java.util.Date;

class Own {
	int bookStatus
	Date dateCreated
	static belongsTo=[user:ShiroUser,book:Book]

}
