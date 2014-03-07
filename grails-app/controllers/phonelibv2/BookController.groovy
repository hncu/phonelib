package phonelibv2



import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.web.json.JSONObject

import groovy.json.*

import org.hibernate.type.LongType


class BookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def touxiang = {b ->
		def principal = SecurityUtils.subject?.principal
		def userInstance=ShiroUser.findByUsername(principal)
		if(b){
			def touxiangUrl = "touxiang/default_avatar.jpg"  //默认头像
			return touxiangUrl
		}else{

	def tSize = "btouxiang" //选择头像的类型，这里是大头像
	def tIndex = userInstance."${tSize}"?.indexOf("touxiang") //44,touxiang是第44位
	def touxiang =  userInstance."${tSize}"?.substring(tIndex)//touxiang\10\10\1385360315740_162.jpg
	def touxiangUrl1 = touxiang?.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
	return touxiangUrl1
		}
	}

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

	def list() {// HQL 分页查询
//		print(params)
		def categoryInstance = null
		if(params.id != null){
			print(categoryInstance+"\n")
			categoryInstance = Category?.get(params.id)
		}
		print(categoryInstance)
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
		def principal = SecurityUtils.subject?.principal
		if(!principal){//判断是否登录
			print("1")
			return [bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount,shiroUserInstance:touxiangUrl]
		}
		print("2")
		def userInstance=ShiroUser.findByUsername(principal)
		def touxiangUrl = touxiang(!userInstance.btouxiang)
		[bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount,shiroUserInstance:touxiangUrl]
	}

	def create() {
		[bookInstance: new Book(params)]
	}

	def save() {
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
		if(bookName.length()==13 && bookName=~ /^[0-9]*$/ ){// grails里的正则  =~ , 正则写在//中 
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
	
		print(params)
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
		def categoryInstance = Category.get(params.category.id)		
		def principal = SecurityUtils.subject?.principal
		def userInstance = ShiroUser.findByUsername(principal)
			
		def c = Own.createCriteria()
		String cname = categoryInstance.cname
		def searchByCategory = {//这是一个闭包
			book{//默认情况下，条件之间的关系是 与
				category{
					eq('cname',cname)
				}
			}
			user{
				eq('username',userInstance.username)
			}
		}
		def ownBook = c.list(params,searchByCategory)
		int bookCount = ownBook.totalCount
			
			def resquestArray = []
			
			JSONObject requestJsonObject = new JSONObject()
			
			ownBook.each{
				resquestArray.add('title':"${it.book.title}",'author':"${it.book.author}",'isbn13':"${it.book.isbn13}",'imageUrl':"${it.book.imageUrl}")
			}
			requestJsonObject.put('cname',cname)
			requestJsonObject.put('count', bookCount)
			requestJsonObject.putOpt('books', resquestArray)

			print(requestJsonObject)
		
		render(contentType:"text/json"){
			requestJsonObject
		}
		
	}
		
	
	def updateBook(){
		params.offset = 0
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
				String temp = json.tags
				temp = temp.replaceAll("\\[", "{")
				temp = temp.replaceAll("\\]","}" )
				
				temp = temp.replaceFirst("\\{", "[")
				temp = temp.replaceAll("\\}}", "}]")
				
				String tags = "{\"tags\":"+temp+"}"
				print(temp) 
			//	print(summary)
				params.author = author
				params.pubdate = pubdate
				params.imageUrl = imageUrl
				params.title = title
				params.publisher = publisher
				params.summary = summary
				params.tags = tags
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
	
	def phonelibSearch(){
		def bookName = params.bookName
		def books
		def bookCount
		if(bookName.length()==13 && bookName=~ /^[0-9]*$/ ){// grails里的正则  =~ , 正则写在/  /中 
			books = Book.findAllByIsbn13Like("%${bookName}%")
		}else{
			books = Book.findAllByTitleLike("%${bookName}%")
		}
		render(view:"list",model:[bookInstanceList:books,bookInstanceTotal: Book.count(), categoryInstanceList: Category.list(params)])
		
	}

}
