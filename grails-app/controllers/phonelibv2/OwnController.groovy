package phonelibv2


import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

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
        [ownInstanceList: Own.list(params), ownInstanceTotal: Own.count(),categoryInstanceList: Category.list(params)]
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
//	categoryInstance
		if (!categoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
			redirect(action: "list")
			return
		}
//		render(view:"list",model:[categoryInstanceList: Category.list(params),bookInstanceTotal: Book.count(),bookInstanceList:categoryInstance.books])
		render(view:"list",model:[ownInstanceList: Own.list(params),ownInstanceTotal: Own.count()])
	}
}
