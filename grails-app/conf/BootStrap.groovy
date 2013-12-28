import phonelibv2.*
import grails.util.GrailsUtil
import java.util.Date

class BootStrap {

	def shiroSecurityService
	def book_isbn = ['9787111187776','9787512500983','9787208061644',
					'9787544253994','9787561339121','9787532725694',
					'9787505722460','9787532756728','9787208050037',
					'9787536692930','9787532731077','9787020024759',
					'9787542629586','9787805508405','9787508630069',
					'9787121100529','9787302185659','9787040195835']
	def init = { servletContext ->
		switch (GrailsUtil.environment) {

			case  "development":
				createTestingUsers()
				createTestingCategorys()
				createTestingBooks()
//				createTestingOwns()
				createTestingBorrows()
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

		for(i in 0..17) {
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
	
	void createTestingCategorys(){
		for(i in 0..17){
			def category1 = new Category(
					cname:"cname${i}"
					)
			category1.save()
			if(category1.hasErrors()){
				println "dasfasdfasdf"
			}
		}
	}
	
	void createTestingBooks(){
		for(i in 0..17) {
			def category = Category.findByCname("cname${i}")
			def book1 = new Book(
					title:"title${i}",
					isbn13:book_isbn[i],
					category:category
					)
			book1.save()
			if(book1.hasErrors()){
				
			}
		}
	}

	void createTestingOwns(){
		for(i in 0..17) {
			def book=Book.findByIsbn13(book_isbn[i])
			def user=ShiroUser.findByUsername("knight${i}")
			def now =new Date()
			
			def own =new Own(book:book,user:user,dateCreated:now)
			own.save()
			if(own.hasErrors()){
				println own.errors
				}
		 }		
	}

	void createTestingBorrows(){
		for(i in 0..16) {
			def book=Book.findByIsbn13(book_isbn[i])
			def owner=ShiroUser.findByUsername("knight${i}")
			def borrower=ShiroUser.findByUsername("knight${i+1}")
			def now =new Date()
						
			def borrow = new Borrow(owner:owner,borrower:borrower,book:book,dateCreated:now)
			borrow.save()
			if(borrow.hasErrors()){
				println borrow.errors
			}
		}
	}
}

