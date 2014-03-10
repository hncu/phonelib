package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.web.json.JSONObject

import java.util.Iterator
/**
 * 用户拥有图书类
 * @author Administrator
 *
 */
class OwnController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

   
	
	
	def index() {
		redirect(action: "list", params: params)
	}
	
	def list() {
		
		def principal = SecurityUtils.subject?.principal
		def userInstance=ShiroUser.findByUsername(principal)
		
		List categoryList =	Category.list()
		List resquestArray = []
		categoryList.each{
			def c = Own.createCriteria()
			String cname = it.cname
			def searchByCategory = {
				book{
					category{
						eq('cname',cname)
					}
				}
				user{
					eq('username',userInstance.username)
				}
			}
			def ownBook = c.list(params,searchByCategory)
			print(ownBook)
			int bookCount = ownBook.totalCount
			resquestArray.add(categoryIntance:it,bookCount:bookCount)
		}
		resquestArray.bookCount.sort()
		categoryList = []
		resquestArray.each{
			if(it.bookCount != 0){
				categoryList.add(it)
			}
		}
		print categoryList
		
		
		
		def categoryInstance = Category.get(params.id)
		
		params.max = Math.min(params.max ? params.int('max') : 15, 100)
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
		
		
		[ownInstanceList: ownList, ownInstanceTotal: ownCount,categoryInstanceList: categoryList]
			
		
		}
		
		def create() {
			[ownInstance: new Own(params)]
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
		
		
		// phone 
		
		
		
		def ownbooklist(){
			def principal = SecurityUtils.subject?.principal
			def userInstance=ShiroUser.findByUsername(principal)

			params.max = Math.min(params.max ? params.int('max') : 15, 100)
			def ownInstance = userInstance.own
			List categoryList = ownInstance.book.category
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
		
	}
	
	
