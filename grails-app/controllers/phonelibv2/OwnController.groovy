package phonelibv2

import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

import java.util.Iterator
/**
 * 用户拥有图书类
 * @author Administrator
 *
 */
class OwnController {

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
		def principal = SecurityUtils.subject?.principal
		def userInstance=ShiroUser.findByUsername(principal)
		def categoryInstance = Category.get(params.id)
		def searchOwnList = {
			if(categoryInstance)
			book{
				category{
					eq('cname',categoryInstance.cname)
				}
			}
			
			user{
				eq('username',userInstance.username)
				
			}
		}
		def c = Own.createCriteria()
		def ownList = c.list(params,searchOwnList)
		def ownCount = ownList.totalCount
		def ownInstance = userInstance.own
		List categoryList = (ownInstance.book).category
		categoryList.unique()



//		[ownInstanceList: ownList, ownInstanceTotal: ownCount,categoryInstanceList: categoryList,shiroUserInstance:touxiangUrl]
		
		if(!principal){//判断是否登录
			print("1")
			return [bookInstanceList: bookList,categoryInstanceList: Category.list(), bookInstanceTotal: bookList.totalCount]
		}
		print("2")
		def touxiangUrl = touxiang(!userInstance.btouxiang)
		
		[ownInstanceList: ownList, ownInstanceTotal: ownCount,categoryInstanceList: categoryList,shiroUserInstance:touxiangUrl]
		}
		
		def create() {
			[ownInstance: new Own(params)]
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
		
		def save(){
			def book=Book.findByIsbn13(params.isbn)

			println "params.author="+params.author
			if(book==null){
				book = new Book()
				JSONObject json= getbooksummy("${params.isbn}")
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
				book.title = title
				book.isbn13 = params.isbn
				book.author = author
				book.publisher = publisher
				book.pubdate = pubdate
				book.summary = summary
				book.imageUrl = imageUrl
				book.tags = tags

//				book.save()
				
				println "book=" + book
				def cname = params.category.id
				def category = Category.findByCname(cname)
				println "category="+category
				category.addToBooks(book);
				println "a"
				println book.title
				if (!book.save(flush: true)) {
					println "b"
					render(view: "create", model: [book: Book])
					return
				}
				println "c"
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
		// phone 
		
		
		
		def ownbooklist(){
			def principal = SecurityUtils.subject?.principal
			def userInstance=ShiroUser.findByUsername(principal)
			/*if(!userInstance.btouxiang){//娌℃湁澶村儚,鏄剧ず榛樿澶村儚
				def touxiangUrl = "touxiang/default_avatar.jpg"
				return [bookInstanceList: Book.list(params),categoryInstanceList: Category.list(), bookInstanceTotal: Book.count(),shiroUserInstance:touxiangUrl]
			}
			
			def tSize = "btouxiang" //btouxiang 澶�62x162锛宮touxiang涓�8x48锛宻touxiang灏�0x20
			def tIndex = userInstance."${tSize}".indexOf("touxiang") //44,绗竴娆″彂鐜皌ouxiang鐨勫湴鏂�
			def touxiang =  userInstance."${tSize}".substring(tIndex)//touxiang\10\10\1385360315740_162.jpg
			def touxiangUrl = touxiang.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
		*/
			params.max = Math.min(params.max ? params.int('max') : 15, 100)
			def ownInstance = userInstance.own
			List categoryList = (ownInstance.book).category
			categoryList.unique()
			def categoryInstance = Category.get(params.id)
			def searchOwnList = {
				if(categoryInstance)
				book{
					category{
						eq('cname',categoryInstance.cname)
					}
				}
				user{
					eq('username',userInstance.username)
					
				}
			}
			def c = Own.createCriteria()
			def ownList = c.list(params,searchOwnList)
			def ownCount = ownList.totalCount
			print("***************")
			
			render(contentType:"text/json"){
				ownInstanceList: ownList
				 ownInstanceTotal: ownCount
				 categoryInstanceList: categoryList
			}
		}
		
		def phoneSave(){
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
		
		def search(){
			params.max = Math.min(params.max ? params.int('max') : 15, 100)
			def bookName = params.bookName
			def principal = SecurityUtils.subject?.principal
			def userInstance =  ShiroUser.findByUsername(principal)
			def categoryInstance =  Category.get(params.id)
			def c = Own.createCriteria()
			def searchByOwnBook = {
				user{
					eq('username', userInstance.username)
				}
				
				book{
					if(bookName.length()==13 && bookName=~ /^[0-9]*$/ ){
					like('isbn13', "%${bookName}%")
					}else{
					like('title', "%${bookName}%")
					}
				}
			}
			def ownList = c.list(params, searchByOwnBook)
			println "ownList= " + ownList
			def ownInstance = userInstance.own

			
//			println "ownInstance = " + ownInstance
			def categoryList = ownInstance.book.category
			categoryList.unique()
//			print categoryList
//			println ownList
//			println "touxiang="+touxiang(0)
			def touxiangUrl = touxiang(!userInstance.btouxiang)
			println "Category.list()="+Category.list()
			
//			ownInstanceList: ownList, ownInstanceTotal: ownCount,categoryInstanceList: categoryList,shiroUserInstance:touxiangUrl
			render(view:"list",model:[ownInstanceList:ownList, ownInstanceTotal: ownList.totalCount, categoryInstanceList:categoryList, shiroUserInstance:touxiangUrl])	
			return
			
			
		}
		
		def phonelibOwnBookSearch(){
			println "手机端搜索"+params
			params.max = Math.min(params.max ? params.int('max') : 15, 100)
//			params.offset = q
			def bookName = params.bookName
			println "bookName=" + bookName
			def principal = SecurityUtils.subject?.principal
			def userInstance =  ShiroUser.findByUsername(principal)
			def categoryInstance =  Category.get(params.id)
			def c = Own.createCriteria()
			def searchByOwnBook = {
				user{
					eq('username', userInstance.username)
				}
				
				book{
					if(bookName.length()==13 && bookName=~ /^[0-9]*$/ ){
					like('isbn13', "%${bookName}%")
					}else{
					like('title', "%${bookName}%")
					}
				}
			}
			def ownList = c.list(params, searchByOwnBook)
			
			int bookCount = ownList.totalCount
			
			def resquestArray = []
			
			JSONObject requestJsonObject = new JSONObject()
			
			ownList.each{
				resquestArray.add('title':"${it.book.title}",'author':"${it.book.author}",'isbn13':"${it.book.isbn13}",'imageUrl':"${it.book.imageUrl}")
			}
			println "ownList.book.imageUrl="+ownList.book.imageUrl
			requestJsonObject.put('count', bookCount)
			requestJsonObject.putOpt('books', resquestArray)
			def ownInstance = userInstance.own
//			println "ownInstance = " + ownInstance
			def categoryList = ownInstance.book.category
			categoryList.unique()
			
			println "ownList= " + ownList
			//返回的格式为  {"books":[{"title":"C程序设计语言","author":"null","isbn13":"9787111128069","imageUrl":"null"}],"count":1}
			render(contentType:"text/json"){
				requestJsonObject
			}
			
		}
		
	}
	
	
