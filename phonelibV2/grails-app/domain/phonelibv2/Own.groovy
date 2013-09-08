package phonelibv2

import java.util.Date;

class Own {

	Date dateCreated
	static belongsTo=[user:User,book:Book]
}
