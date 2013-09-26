import phonelibv2.*
import grails.util.GrailsUtil

class BootStrap {

	def shiroSecurityService

	def init = { servletContext ->
		switch (GrailsUtil.environment) {

			case  "development":
				createTestingUsers()
				createTestingBooks()
				createTestingOwns()
				break;

			case "production":
				println "No special configuration required"
				break;
		}
	}
	def destroy = {
	}

	void createTestingRoles(){

	}

	void createTestingUsers(){

		// Create the admin role
		def adminRole = ShiroRole.findByName('ROLE_ADMIN') ?:
				new ShiroRole(name: 'ROLE_ADMIN').save(flush: true, failOnError: true)

		// Create the user role
		def userRole = ShiroRole.findByName('ROLE_USER') ?:
				new ShiroRole(name: 'ROLE_USER').save(flush: true, failOnError: true)
				
		// Create an admin user
		def adminUser = ShiroUser.findByUsername('admin') ?:
				new ShiroUser(username: "admin",
				passwordHash: shiroSecurityService.encodePassword('password'))
				.save(flush: true, failOnError: true)

		// Add roles to the admin user
		assert adminUser.addToRoles(adminRole)
		.save(flush: true, failOnError: true)
		//.addToRoles(userRole)

		// Create an standard user
		def standardUser = ShiroUser.findByUsername('joe') ?:
				new ShiroUser(username: "joe",
				passwordHash: shiroSecurityService.encodePassword('password'))
				.save(flush: true, failOnError: true)

		// Add role to the standard user
		assert standardUser.addToRoles(userRole)
		.save(flush: true, failOnError: true)

		for(i in 1..15) {
			def jane = ShiroUser.findByUsername("knight${i}") ?:
					new ShiroUser(username:"knight${i}",
					passwordHash:shiroSecurityService.encodePassword('123456'))
					.save(flush: true, failOnError: true)
			if(jane.hasErrors()){
				println jane.errors
			}
			assert jane.addToRoles(userRole)
			.save(flush: true, failOnError: true)
		}
	}

	void createTestingBooks(){
		for(i in 1..15) {
			def book1 = new Book(
					title:"title${i}",
					isbn13:"9787111187776",
					)
			book1.save()
			if(book1.hasErrors()){
				println book1.errors
			}
		}
	}

	void createTestingOwns(){
		/*for(i in 1..15) {
		 def book2 = new Book(
		 title:"title${i}",
		 isbn13:"9787111187776",
		 )
		 book2.save()
		 def jane = new User(
		 login:"knight${i}",
		 password:"123456",
		 )
		 jane.save()
		 def own1 = new Own(
		 book:book2,
		 user:jane,
		 )
		 own1.save()
		 if(own1.hasErrors()){
		 println own1.errors
		 }
		 }*/
	}

	void createTestingBorrows(){
		/*	for(i in 1..15) {
		 def Borrow1 = new Borrow(
		 //book:book1,
		 //userBorrow:user(1),
		 )
		 Borrow1.save()
		 if(Borrow1.hasErrors()){
		 println Borrow1.errors
		 }
		 }*/
	}
}

