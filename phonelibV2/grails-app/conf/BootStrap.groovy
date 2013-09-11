import phonelibv2.*
import grails.util.GrailsUtil

class BootStrap {
	
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
		void createTestingUsers(){
			for(i in 1..15) {
				def jane = new User(
						login:"knight${i}",
						password:"123456",
						)
				jane.save()
				if(jane.hasErrors()){
					println jane.errors
				}
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
	
	