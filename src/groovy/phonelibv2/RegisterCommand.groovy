package phonelibv2

class RegisterCommand {
	String password
	String passwordAgain
	
	static constraints = {
		passwordAgain(validator:{
			val,obj ->
			if(obj.password != val)
			return 'differentPassword'
		})
	}
}
