package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import org.codehaus.groovy.grails.web.json.JSONArray;
import org.codehaus.groovy.grails.web.json.JSONObject
import org.hibernate.FetchMode;


class BorrowController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [borrowInstanceList: Borrow.list(params), borrowInstanceTotal: Borrow.count()]
    }

    def bgcreate() {
        [borrowInstance: new Borrow(params)]
    }

    def bgsave() {
        def borrowInstance = new Borrow(params)
        if (!borrowInstance.save(flush: true)) {
            render(view: "bgcreate", model: [borrowInstance: borrowInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
        redirect(action: "bgshow", id: borrowInstance.id)
    }

    def bgshow() {
        def borrowInstance = Borrow.get(params.id)
        if (!borrowInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bglist")
            return
        }

        [borrowInstance: borrowInstance]
    }

    def bgedit() {
        def borrowInstance = Borrow.get(params.id)
        if (!borrowInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bglist")
            return
        }

        [borrowInstance: borrowInstance]
    }

    def bgupdate() {
        def borrowInstance = Borrow.get(params.id)
        if (!borrowInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bglist")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (borrowInstance.version > version) {
                borrowInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'borrow.label', default: 'Borrow')] as Object[],
                          "Another user has updated this Borrow while you were editing")
                render(view: "bgedit", model: [borrowInstance: borrowInstance])
                return
            }
        }

        borrowInstance.properties = params

        if (!borrowInstance.save(flush: true)) {
            render(view: "bgedit", model: [borrowInstance: borrowInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
        redirect(action: "bgshow", id: borrowInstance.id)
    }

    def bgdelete() {
        def borrowInstance = Borrow.get(params.id)
        if (!borrowInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            borrowInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }
	
	
		def index() {
			redirect(action: "list", params: params)
		}
	
		def borrowerlist() {
			def principal = SecurityUtils.subject?.principal
			def shiroUserInstance = ShiroUser.findByUsername(principal);
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def search = {
				eq('borrowStatus',4)
				borrower{
					eq('username',shiroUserInstance.username)
				}
				
			}
			def c = Borrow.createCriteria()
			def borrowInstanceList = c.list(params,search)
			def count = borrowInstanceList.totalCount
			if(!shiroUserInstance.btouxiang){//登录后，判断是否有头像
				def touxiangUrl = "touxiang/default_avatar.jpg" //默认头像
				render(view: "list", model:[borrowInstanceList: borrowInstanceList, categoryInstanceList: (borrowInstanceList.book).category,borrowInstanceTotal: count,shiroUserInstance:touxiangUrl])
				return
				}
			
			def tSize = "btouxiang" //btouxiang 澶�62x162锛宮touxiang涓�8x48锛宻touxiang灏�0x20
			def tIndex = shiroUserInstance?."${tSize}"?.indexOf("touxiang") //44,绗竴娆″彂鐜皌ouxiang鐨勫湴鏂�
			def touxiang =  shiroUserInstance?."${tSize}"?.substring(tIndex)//touxiang\10\10\1385360315740_162.jpg
			def touxiangUrl = touxiang?.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
		
			params.max = Math.min(params.max ? params.int('max') : 15, 100)
			render(view: "list", model:[borrowInstanceList: borrowInstanceList, categoryInstanceList: (borrowInstanceList.book).category,borrowInstanceTotal: count,shiroUserInstance:touxiangUrl])
		}
		def ownerlist() {
			def principal = SecurityUtils.subject?.principal
			def shiroUserInstance = ShiroUser.findByUsername(principal);
			def search = {
				eq('borrowStatus',4)
				owner{
					eq('username',shiroUserInstance.username)
				}
			}
			def c = Borrow.createCriteria()
			def borrowInstanceList = c.list(params,search)
			def count = borrowInstanceList.totalCount
			
			if(!shiroUserInstance.btouxiang){//登录后，判断是否有头像
				def touxiangUrl = "touxiang/default_avatar.jpg"  //默认头像
				println("1");
				render(view: "list", model:[borrowInstanceList: borrowInstanceList, categoryInstanceList: (borrowInstanceList.book).category,borrowInstanceTotal: count,shiroUserInstance:touxiangUrl])
				return 
			}
			println("2");
			def tSize = "btouxiang"  //选择头像的类型，这里是大头像
			def tIndex = shiroUserInstance."${tSize}".indexOf("touxiang") //44,touxiang是第44位
			def touxiang =  shiroUserInstance."${tSize}".substring(tIndex)//touxiang\10\10\1385360315740_162.jpg
			def touxiangUrl = touxiang.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
			
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
	
			render(view: "list", model:[borrowInstanceList: borrowInstanceList, categoryInstanceList: (borrowInstanceList.book).category,borrowInstanceTotal: count,shiroUserInstance:touxiangUrl])
			return 
		}
	
		def create() {
			[borrowInstance: new Borrow(params)]
		}
	
		def save() {
			def borrowInstance = new Borrow(params)
			if (!borrowInstance.save(flush: true)) {
				render(view: "create", model: [borrowInstance: borrowInstance])
				return
			}
	
			flash.message = message(code: 'default.created.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
			redirect(action: "show", id: borrowInstance.id)
		}
	
		def show() {
			def borrowInstance = Borrow.get(params.id)
			if (!borrowInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "list")
				return
			}
	
			[borrowInstance: borrowInstance]
		}
	
		def edit() {
			def borrowInstance = Borrow.get(params.id)
			if (!borrowInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "list")
				return
			}
	
			[borrowInstance: borrowInstance]
		}
	
		def update() {
			def borrowInstance = Borrow.get(params.id)
			if (!borrowInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "list")
				return
			}
	
			if (params.version) {
				def version = params.version.toLong()
				if (borrowInstance.version > version) {
					borrowInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
							  [message(code: 'borrow.label', default: 'Borrow')] as Object[],
							  "Another user has updated this Borrow while you were editing")
					render(view: "edit", model: [borrowInstance: borrowInstance])
					return
				}
			}
	
			borrowInstance.properties = params
	
			if (!borrowInstance.save(flush: true)) {
				render(view: "edit", model: [borrowInstance: borrowInstance])
				return
			}
	
			flash.message = message(code: 'default.updated.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
			redirect(action: "show", id: borrowInstance.id)
		}
	
		def delete() {
			def borrowInstance = Borrow.get(params.id)
			if (!borrowInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				borrowInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		def borrowBookSearchOwner(){
			def bookInstance = Book.get(params.id)
			def ownerInstance = bookInstance.own.user
		//	println(ownerInstance)
			redirect(controller:"book",action:"list",ownerInstance:ownerInstance)
		}
		
		def borrowBookAdd(){
			def principal = SecurityUtils.subject?.principal
			def book = Book.get(params.bookId)
			def owner = ShiroUser.get(params.userId)
			def borrower = ShiroUser.findByUsername(principal)
			if(owner==borrower){
				flash.message = message(code: 'borrow.create.error.label', args: [message(code: 'borrow.label', default: 'Borrow'), params.id])
				redirect(controller:"book",action:"list")
				return
			}
			def ownerAck = false
			def borrowerAck = false
			def borrowStatus = 2
			def now =new Date()
			def dateBack = new Date()+60;
			def borrowInstance = new Borrow(book:book,owner:owner,borrower:borrower,ownerAck:ownerAck,borrowerAck:borrowerAck,borrowStatus:borrowStatus,dateCreated:now,dateBack:dateBack)
			borrowInstance.setOwnerAck(false)
			borrowInstance.setBorrowerAck(false)
			if (!borrowInstance.save(flush: true)) {
				render(view: "create", model: [borrowInstance: borrowInstance])
				return
				print("oneasdfasdf")
			}
			flash.message = message(code: 'default.created.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
			redirect(controller:"internalMessage",action: "borrowBookMessage",id:borrowInstance.id)
		}
		
		//phone 端
		def check(){
			def bookName = params.bookname
			def books
			def state
			if(bookName.length()==13&&bookName=~'\\d'){
				books = Book.findAllByIsbn13Like("%${bookName}%")
			}else{
				books = Book.findAllByTitleLike("%${bookName}%")
			}
			if(books.empty){
				state = 0
				render(contentType:"text/json"){ Book(state:state)}
				return
			}
			
			def principal = SecurityUtils.subject?.principal
			def userInstance=ShiroUser.findByUsername(principal)
			def search = {
				borrower{
					eq('username',userInstance.username)
				}
				book{
					if(bookName.length()==13&&bookName=~'\\d'){
						like('isbn13',"%${bookName}%")
					}else{
						like('title',"%${bookName}%")
					}
				}
			}
			def c = Borrow.createCriteria()
			def borrowInstance = c.list (search)
			if(!borrowInstance.empty){
				state = 1
			}else{
				state = 2
			}
			render(contentType:"text/json"){ Book(state:state)}
		}
		
		def phoneborrow(){
			print(params)
			JSONObject json = new JSONObject(params)
			//JSONArray jsonArray= new JSONArray((json.books).data)
		//	print(json)
			
			
			
			def principal = SecurityUtils.subject?.principal
			def book = Book.get(params.bookId)
			def owner = ShiroUser.get(params.userId)
			def borrower = ShiroUser.findByUsername(principal)
			def ownerAck = false
			def borrowerAck = false
			def borrowStatus = 4 //2未处理 1同意借 0 不同意借3正在交易4已借阅5已退还
			def now =new Date()
			def dateBack = new Date()+60
			def borrowInstance = new Borrow(book:book,owner:owner,borrower:borrower,ownerAck:ownerAck,borrowerAck:borrowerAck,borrowStatus:borrowStatus,dateCreated:now,dateBack:dateBack)
			borrowInstance.setOwnerAck(false)
			borrowInstance.setBorrowerAck(false)
			if (!borrowInstance.save(flush: true)) {
				render(contentType:"text/json"){ create(state:false)}
				return
			}
			flash.message = message(code: 'default.created.message', args: [message(code: 'borrow.label', default: 'Borrow'), borrowInstance.id])
			render(contentType:"text/json"){ creat(state:true)}
		}
		
		def phonebooklist(){
			
			def username=session.getAttribute("org.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEY")
			def shiroUserInstance = ShiroUser.findByUsername("${username}");
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def search = {
				eq('borrowStatus',4)
				borrower{
					eq('username',shiroUserInstance.username)
				}
				
			}
			def c = Borrow.createCriteria()
			def borrowInstanceList = c.list(params,search)
			JSONObject requestJsonObject = new JSONObject()
			def resquestArray = []
			
			borrowInstanceList.each{
				def dateCreated = it.dateCreated
				dateCreated = dateCreated?.format("yyyy-MM-dd")
				def dateBack = it.dateBack
				dateBack = dateBack?.format("yyyy-MM-dd")
				resquestArray.add('id':it.id,'isbn':"${it?.book?.isbn13}",title:"${it?.book?.title}",dateCreated:dateCreated,dateBack:dateBack)
			}
			requestJsonObject.put('borrowCount',borrowInstanceList.totalCount)
			requestJsonObject.putOpt('book', resquestArray)
			render(contentType:"text/json"){ borrowList(requestJsonObject)}
		}
	}
	