package phonelibv2


import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import java.util.Iterator


class OwnController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def index() {
		redirect(action: "list", params: params)
	}

	def list() {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
//		def ownInstance = Own.get()
//		def book_id = (ownInstance.book)
//		print ownInstance.book_id
//		print Own.list(params).book.id
		
		def principal = SecurityUtils.subject?.principal
//				println principal;
		def user=ShiroUser.findByUsername(principal)
		
//		def own=Own.findByUser(user)
//		if(!own){
//			own=Own.list(params)
//		}
		
		//去掉重复的类
		def ownInstance = user.own
		def OwnList = (ownInstance.book).category
		HashSet h  = new HashSet(OwnList);
		OwnList.clear()
		OwnList.addAll(h)
//		principal
		
//		print user
				
//        [ownInstanceList: Own.list(params), ownInstanceTotal: Own.count(),categoryInstanceList: Category.list(params)]
		[ownInstanceList: ownInstance, ownInstanceTotal: Own.count(),categoryInstanceList: OwnList]
//		[ownInstanceList: oList,ownInstanceTotal: Own.count(),categoryInstanceList: (ownInstance.book).category]
	}

	def create() {
		[ownInstance: new Own(params)]
	}

//    def save() {
//        def ownInstance = new Own(params)
//        if (!ownInstance.save(flush: true)) {
//            render(view: "create", model: [ownInstance: ownInstance])
//            return
//        }
//
//		flash.message = message(code: 'default.created.message', args: [message(code: 'own.label', default: 'Own'), ownInstance.id])
//        redirect(action: "show", id: ownInstance.id)
//    }
	
	def save(){
		def book = new Book()
//		def category = new Category()
		book.title = params.book_name
		book.isbn13 = params.isbn
//		book.category = params.category.id
//		category.cname = params.category.id
		def cname = params.category.id
		def category = Category.findByCname(cname)
		
		category.addToBooks(book);
//		category.save(flush: true)
//		book.save(flush: true)
		if (!book.save(flush: true)) {
			render(view: "create", model: [book: Book])
			return
		}
		
//		def user1 = session.user;
		//用shiro插件获得当前登录用户
		def principal = SecurityUtils.subject?.principal
//		println principal;
		
		def user=ShiroUser.findByUsername(principal)
		def now =new Date()
		def own =new Own(book:book,user:user,dateCreated:now)
		own.save()
		
		if(own.hasErrors()){
			println own.errors
			}
	
		
		
		flash.message = message(code: 'default.created.message', args: [message(code: 'own.label', default: 'Own'), book.id])
		redirect(action: "show", id: book.id)
	}

	def show() {
		def ownInstance = Own.get(params.id)
		if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "list")
			return
		}

		[ownInstance: ownInstance]
	}

	def edit() {
		def ownInstance = Own.get(params.id)
		if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "list")
			return
		}

		[ownInstance: ownInstance]
	}

	def update() {
		def ownInstance = Own.get(params.id)
		if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (ownInstance.version > version) {
				ownInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'own.label', default: 'Own')] as Object[],
						  "Another user has updated this Own while you were editing")
				render(view: "edit", model: [ownInstance: ownInstance])
				return
			}
		}

		ownInstance.properties = params

		if (!ownInstance.save(flush: true)) {
			render(view: "edit", model: [ownInstance: ownInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'own.label', default: 'Own'), ownInstance.id])
		redirect(action: "show", id: ownInstance.id)
	}

	def delete() {
		def ownInstance = Own.get(params.id)
		if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "list")
			return
		}

		try {
			ownInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'own.label', default: 'Own'), params.id])
			redirect(action: "show", id: params.id)
		}
	}
	
	def category(){
def categoryInstance = Category.get(params.id)
	def bookList = categoryInstance.getBooks()
	def ownList =  bookList.own
//	print ownList.getClass().getName()
	def ownSet =ownList.toSet()
//	println ownList
//	println ownList.toArray()
//	def estEmps = (List<Own>)((ArrayList<Own>)ownList).clone();
//	println estEmps
//	for(Own own1:ownList.toArray()){
//		print own1
//		def newown = Own.get(own1.id)
//		println newown
//	}
	List oList = new ArrayList()
	for(def i = 0;i < ownList.size(); i++){
		if(ownList[i]){
//			println ownList[i].id[0]
			def own = Own.get(ownList[i].id[0])
//			println own
//			def own = ownList[i]
			oList.add(own)
		}
	}
	
				def principal = SecurityUtils.subject?.principal
				def user=ShiroUser.findByUsername(principal)
				def ownInstance = user.own
//	owm.
//	print own
//	 Iterator it = ownList.entrySet().iterator();
//	 while(it.hasNext()){
//		 Map.Entry entry = (Map.Entry) it.next();
//		 Object key = entry.getKey()
//		 Object value = entry.getValue()
//		 println key
//		 println value
//		 }
//				def principal = SecurityUtils.subject?.principal
				//				println principal;
//				def user=ShiroUser.findByUsername(principal)
//				def own = user.own

		if (!categoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
			redirect(action: "list")
			return
		}
		def OwnList = (ownInstance.book).category
		HashSet h  = new HashSet(OwnList);
		OwnList.clear()
		OwnList.addAll(h)
//		render(view:"list",model:[categoryInstanceList: Category.list(params),bookInstanceTotal: Book.count(),bookInstanceList:categoryInstance.books])
		render(view:"list",model:[ownInstanceList: oList,ownInstanceTotal: Own.count(),categoryInstanceList: OwnList])
	}
//	def category(){
//
////		def categoryInstance = Category.get(params.id)
////		render(view:"list",model:[ownInstanceList: Own.list(params),ownInstanceTotal: Own.count(),])
//		//	}
//
//		def o = Own.createCriteria()
//		def goodList = o.list(){
//			def principal = SecurityUtils.subject?.principal
//			//				println principal;
//			def user=ShiroUser.findByUsername(principal)
//			def own = user.own
//			def categoryInstance = Category.get(params.id)
////			print categoryInstance
////			print params.id
////			print own.book.category
//			def categoryList = own.book.category;
////			for(def i = 0;i<categoryList.size;i++){
////				print categoryList.id
////
//////				if(categoryList.id==params.id){
//////					print "qqqqqqqqq"
//////				}else{
//////					print "wwwwwwwww"
//////				}
////			}
//
//			for(Category c:categoryList){
////				println c.id
////				print params.id
//
//								if(c.id==params.id.toInteger()){
////									print "qqqqqqqqq"
////								}else{
////									print "wwwwwwwww"
////									println "${c.id}+'  c.id'"
////									print "${params.id}+'  params.id'"
//									Category.findByBook
//								}
//
//			}
////			print own.book.category.findById(params.id)
////			if(own.book.categoryInstance){
////				print own.book
////			}
////		}
////		if()
//
//
//		render(view:"list",model:[ownInstanceList: Own.list(params),ownInstanceTotal: Own.count(),])
//		}
	
}

