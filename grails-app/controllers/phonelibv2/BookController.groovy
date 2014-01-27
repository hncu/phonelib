package phonelibv2

import groovy.json.JsonBuilder;

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject
import org.hibernate.type.LongType;

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
		render(view: "bgcreate",message:"鍒涘缓鎴愬姛")
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
		print(params)
		def categoryInstance = Category.get(params.id)
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
		def searchBookByCategory = {
			if(categoryInstance){
				category{
					eq('cname',categoryInstance.cname)
				}
			}
			
		}
		def c = Book.createCriteria()
		def bookList = c.list(params,searchBookByCategory)
	//	render(view:"list",model:[categoryInstanceList: Category.list(),bookInstanceTotal: bookList.totalCount,bookInstanceList:bookList])
	//	params.max = Math.min(params.max ? params.int('max') : 15, 100)
		def principal = SecurityUtils.subject?.principal
		if(!principal){//娌＄櫥闄嗕笉鏄剧ず涓汉淇℃伅
			print("1")
			return [bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount]
		}
		print("2")
		def user=ShiroUser.findByUsername(principal)
		if(!user?.btouxiang){//娌℃湁澶村儚,鏄剧ず榛樿澶村儚
			def touxiangUrl = "touxiang/default_avatar.jpg"
			print("3")
			return [bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount,shiroUserInstance:touxiangUrl]
		}
		
		def tSize = "btouxiang" //btouxiang 澶�62x162锛宮touxiang涓�8x48锛宻touxiang灏�0x20
		print("4")
//		println user.${tSize}  //D:\workspace-ggts\phonelibV2\web-app\images\touxiang\10\10\1385360315740_162.jpg
		
		def tIndex = user."${tSize}".indexOf("touxiang") //44,绗竴娆″彂鐜皌ouxiang鐨勫湴鏂�
		def touxiang =  user."${tSize}".substring(tIndex)//touxiang\10\10\1385360315740_162.jpg  
		def touxiangUrl = touxiang.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
		
		[bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount,shiroUserInstance:touxiangUrl]
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
		render(view: "create",message:"鍒涘缓鎴愬姛")
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

	def search(){ //web
		def bookName = params.bookName
		def books
		def bookCount
		if(bookName.length()==13&&bookName=~'\\d'){
			books = Book.findAllByIsbn13Like("%${bookName}%")
		}else{
			books = Book.findAllByTitleLike("%${bookName}%")
		}
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

	def phoneBookList(){
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
		def bookInstanceList = Book.list(params)
		def bookCount = Book.count()
		JSONObject resquestBooklist = new JSONObject()
		List booklist = []
		bookInstanceList.each{
			booklist.add('title':it.title,'isbn13':it.isbn13)
		}
		resquestBooklist.putOpt("book",booklist)
		render(contentType:"text/json"){
			resquestBooklist
		}
	}
	
	def updateBook(){
		params.offset = 5587
		params.max = Math.min(params.max ? params.int('max') : 1000, 1000)
		Book.list(params).each {
			JSONObject json= getbooksummy("${it.isbn13}")
			if(json){
				String author = json.author
				String pubdate = json.pubdate
				String imageUrl = json.images.medium
				String title = json.title
				String publisher = json.publisher
				String summary = json.summary
			//	print(summary)
				params.author = author
				params.pubdate = pubdate
				params.imageUrl = imageUrl
				params.title = title
				params.publisher = publisher
				params.summary = summary
			//	print(params)
				def bookInstance = Book.get(it.id)
				print(bookInstance)
				bookInstance.properties = params
				if (!bookInstance.save(flush: true)) {
					render(view: "edit", model: [bookInstance: bookInstance])
					return
				}
			}
		}
	}
	
	def getbooksummy(String isbn){
		StringBuffer html = new StringBuffer();
		String result = null;
		try {
			URL url = new URL("https://api.douban.com/v2/book/isbn/"+isbn+"?alt=xd&callback=?");
			URLConnection conn = url.openConnection();
			conn.setRequestProperty(
					"User-Agent",
					"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB5; .NET CLR 2.0.50727; CIBA)");
			BufferedInputStream ins = new BufferedInputStream(conn.getInputStream());
			try {
				String inputLine;
				byte[] buf = new byte[4096];
				int bytesRead = 0;
				while (bytesRead >= 0) {
					inputLine = new String(buf, 0, bytesRead, "utf-8");
					html.append(inputLine);
					bytesRead = ins.read(buf);
					inputLine = null;
				}
				buf = null;
			} finally {
				//ins.close();
				conn = null;
				url = null;
			}
			result = new String(html.toString().trim().getBytes("utf-8"),
					"utf-8").toLowerCase();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		html = null;
		JSONObject json= new JSONObject(result)
		return json;
	}

}
