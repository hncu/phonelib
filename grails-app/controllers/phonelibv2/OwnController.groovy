package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import java.util.Iterator

class OwnController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [ownInstanceList: Own.list(params), ownInstanceTotal: Own.count()]
    }

    def bgcreate() {
        [ownInstance: new Own(params)]
    }

    def bgsave() {
        def ownInstance = new Own(params)
        if (!ownInstance.save(flush: true)) {
            render(view: "bgcreate", model: [ownInstance: ownInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'own.label', default: 'Own'), ownInstance.id])
        redirect(action: "bgshow", id: ownInstance.id)
    }

    def bgshow() {
        def ownInstance = Own.get(params.id)
        if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bglist")
            return
        }

        [ownInstance: ownInstance]
    }

    def bgedit() {
        def ownInstance = Own.get(params.id)
        if (!ownInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bglist")
            return
        }

        [ownInstance: ownInstance]
    }

    def bgupdate() {
        def ownInstance = Own.get(params.id)
        if (!ownInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bglist")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (ownInstance.version > version) {
                ownInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'own.label', default: 'Own')] as Object[],
                          "Another user has updated this Own while you were editing")
                render(view: "bgedit", model: [ownInstance: ownInstance])
                return
            }
        }

        ownInstance.properties = params

        if (!ownInstance.save(flush: true)) {
            render(view: "bgedit", model: [ownInstance: ownInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'own.label', default: 'Own'), ownInstance.id])
        redirect(action: "bgshow", id: ownInstance.id)
    }

    def bgdelete() {
        def ownInstance = Own.get(params.id)
        if (!ownInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            ownInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'own.label', default: 'Own'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }
	
	
		def index() {
			redirect(action: "list", params: params)
		}
	
		def list() {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def principal = SecurityUtils.subject?.principal
			def user=ShiroUser.findByUsername(principal)
			def ownInstance = user.own
			def OwnList = (ownInstance.book).category
			HashSet h  = new HashSet(OwnList);
			OwnList.clear()
			OwnList.addAll(h)
			[ownInstanceList: ownInstance, ownInstanceTotal: Own.count(),categoryInstanceList: OwnList]
		}
	
		def create() {
			[ownInstance: new Own(params)]
		}
	
		
		def save(){
			def book=Book.findByIsbn13(params.isbn)
			if(book==null){
				book = new Book()
				book.title = params.book_name
				book.isbn13 = params.isbn
				def cname = params.category.id
				def category = Category.findByCname(cname)
				category.addToBooks(book);
				if (!book.save(flush: true)) {
					render(view: "create", model: [book: Book])
					return
				}
			}
		
			def principal = SecurityUtils.subject?.principal
			
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
				
				def userInstance = ownInstance.book.own.user
				println(userInstance)
				if(userInstance.isEmpty()){
					ownInstance.book.delete();
					println(userInstance)
				}
				
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
	
			if (!categoryInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
				return
			}
			def OwnList = (ownInstance.book).category
			HashSet h  = new HashSet(OwnList);
			OwnList.clear()
			OwnList.addAll(h)
			render(view:"list",model:[ownInstanceList: oList,ownInstanceTotal: Own.count(),categoryInstanceList: OwnList])
		}
		
	}
	
	
