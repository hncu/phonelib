package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

class BookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count()]
    }

    def bgcreate() {
        [bookInstance: new Book(params)]
    }

    def bgsave() {
//        def bookInstance = new Book(params)
//        if (!bookInstance.save(flush: true)) {
//            render(view: "bgcreate", model: [bookInstance: bookInstance])
//            return
//        }
//
//		flash.message = message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
//        redirect(action: "bgshow", id: bookInstance.id)
		def categoryId = params.category.id
		def bookInstance = new Book()
		bookInstance.title = params.title
		bookInstance.isbn13 = params.isbn13
		def category = Category.findByCname(categoryId)
		category.addToBooks(bookInstance);

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		render(view: "bgcreate",message:"创建成功")
    }

    def bgshow() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "bglist")
            return
        }

        [bookInstance: bookInstance]
    }

    def bgedit() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "bglist")
            return
        }

        [bookInstance: bookInstance]
    }

    def bgupdate() {
//        def bookInstance = Book.get(params.id)
//        if (!bookInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
//            redirect(action: "bglist")
//            return
//        }
//
//        if (params.version) {
//            def version = params.version.toLong()
//            if (bookInstance.version > version) {
//                bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                          [message(code: 'book.label', default: 'Book')] as Object[],
//                          "Another user has updated this Book while you were editing")
//                render(view: "bgedit", model: [bookInstance: bookInstance])
//                return
//            }
//        }
//
//        bookInstance.properties = params
//
//        if (!bookInstance.save(flush: true)) {
//            render(view: "bgedit", model: [bookInstance: bookInstance])
//            return
//        }
//
//		flash.message = message(code: 'default.updated.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
//        redirect(action: "bgshow", id: bookInstance.id)
		def categoryId = params.category.id
//		def bookInstance = new Book()
		def bookInstance = Book.get(params.id)
		bookInstance.title = params.title
		bookInstance.isbn13 = params.isbn13
		def category = Category.findByCname(categoryId)
		category.addToBooks(bookInstance);

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		redirect(action: "bglist")
    }

    def bgdelete() {
        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            bookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }


	def index() {
		redirect(action: "list", params: params)
	}

	def list() {
		
		def principal = SecurityUtils.subject?.principal
		if(!principal){//没登陆不显示个人信息
			return [bookInstanceList: Book.list(params),categoryInstanceList: Category.list(), bookInstanceTotal: Book.count()]
			
		}
		def user=ShiroUser.findByUsername(principal)
		if(!user.btouxiang){//没有头像,显示默认头像
			def touxiangUrl = "touxiang/default_avatar.jpg"
			return [bookInstanceList: Book.list(params),categoryInstanceList: Category.list(), bookInstanceTotal: Book.count(),shiroUserInstance:touxiangUrl]
		}
		
		def tSize = "btouxiang" //btouxiang 大162x162，mtouxiang中48x48，stouxiang小20x20
		
//		println user.${tSize}  //D:\workspace-ggts\phonelibV2\web-app\images\touxiang\10\10\1385360315740_162.jpg
		
		def tIndex = user."${tSize}".indexOf("touxiang") //44,第一次发现touxiang的地方
		def touxiang =  user."${tSize}".substring(tIndex)//touxiang\10\10\1385360315740_162.jpg  
		def touxiangUrl = touxiang.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
		params.max = Math.min(params.max ? params.int('max') : 20, 100)
		[bookInstanceList: Book.list(params),categoryInstanceList: Category.list(), bookInstanceTotal: Book.count(),shiroUserInstance:touxiangUrl]
	}

	def create() {
		[bookInstance: new Book(params)]
	}

	def save() {
		//		def bookName = params.title
		//		def isbn = params.isbn13
		def categoryId = params.category.id
		//		print params.category.id
		def bookInstance = new Book()
		bookInstance.title = params.title
		//		print params.title
		bookInstance.isbn13 = params.isbn13
		//		print params.isbn13
		//        if (!bookInstance.save(flush: true)) {
		//            render(view: "create", model: [bookInstance: bookInstance])
		//            return
		//        }
		def category = Category.findByCname(categoryId)
		category.addToBooks(bookInstance);

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		//        redirect(action: "show", id: bookInstance.id)
		render(view: "create",message:"创建成功")
	}

	def show() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[bookInstance: bookInstance]
	}

	def edit() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		[bookInstance: bookInstance]
	}

	def update() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (bookInstance.version > version) {
				bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'book.label', default: 'Book')] as Object[],
						"Another user has updated this Book while you were editing")
				render(view: "edit", model: [bookInstance: bookInstance])
				return
			}
		}

		bookInstance.properties = params

		if (!bookInstance.save(flush: true)) {
			render(view: "edit", model: [bookInstance: bookInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'book.label', default: 'Book'),
			bookInstance.id
		])
		redirect(action: "show", id: bookInstance.id)
	}

	def delete() {
		def bookInstance = Book.get(params.id)
		if (!bookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
			return
		}

		try {
			bookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'book.label', default: 'Book'),
				params.id
			])
			redirect(action: "show", id: params.id)
		}
	}

	def search(){
		def bookName = params.bookName
		def books
		def bookCount
		if(bookName.length()==13&&bookName=~'\\d'){
			books = Book.findAllByIsbn13Like("%${bookName}%")
		}else{
			books = Book.findAllByTitleLike("%${bookName}%")
		}
		//def len = books.count()
		//println(len)


		render(view:"list",model:[bookInstanceList:books,bookInstanceTotal: Book.count(), categoryInstanceList: Category.list(params)])
	}

	def searchByUser(){
		def user=ShiroUser.get(params.id)
		def bookList = (user.own).book
		def categoryList = bookList.category
		HashSet h  = new HashSet(categoryList);
		categoryList.clear()
		categoryList.addAll(h)
		render(view:"list",model:[bookInstanceList: bookList, bookInstanceTotal: Own.count(),categoryInstanceList: categoryList])

	}

	def category(){
		def categoryInstance = Category.get(params.id)
		if (!categoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'category.label', default: 'Category'),
				params.id
			])
			redirect(action: "list")
			return
		}
		render(view:"list",model:[categoryInstanceList: Category.list(params),bookInstanceTotal: Book.count(),bookInstanceList:categoryInstance.books])
	}


	def phoneSearch(){
		def bookName = params.bookName
		def books
		def ren
		if(bookName.length()==13&&bookName=~'\\d'){
			books = Book.findAllByIsbn13Like("%${bookName}%")
		}else{
			books = Book.findAllByTitleLike("%${bookName}%")
		}
		if(books.empty){
			ren="false"
		}else{
			ren="true"
			println(books[[]])
		}
		render(contentType:"text/json"){ book(YN:ren)}
	}

}
