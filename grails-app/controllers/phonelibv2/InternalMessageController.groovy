package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils
import com.sun.beans.decoder.FalseElementHandler;

class InternalMessageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [internalMessageInstanceList: InternalMessage.list(params), internalMessageInstanceTotal: InternalMessage.count()]
    }

    def bgcreate() {
        [internalMessageInstance: new InternalMessage(params)]
    }

    def bgsave() {
        def internalMessageInstance = new InternalMessage(params)
        if (!internalMessageInstance.save(flush: true)) {
            render(view: "bgcreate", model: [internalMessageInstance: internalMessageInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), internalMessageInstance.id])
        redirect(action: "bgshow", id: internalMessageInstance.id)
    }

    def bgshow() {
        def internalMessageInstance = InternalMessage.get(params.id)
        if (!internalMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bglist")
            return
        }

        [internalMessageInstance: internalMessageInstance]
    }

    def bgedit() {
        def internalMessageInstance = InternalMessage.get(params.id)
        if (!internalMessageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bglist")
            return
        }

        [internalMessageInstance: internalMessageInstance]
    }

    def bgupdate() {
        def internalMessageInstance = InternalMessage.get(params.id)
        if (!internalMessageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bglist")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (internalMessageInstance.version > version) {
                internalMessageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'internalMessage.label', default: 'InternalMessage')] as Object[],
                          "Another user has updated this InternalMessage while you were editing")
                render(view: "bgedit", model: [internalMessageInstance: internalMessageInstance])
                return
            }
        }

        internalMessageInstance.properties = params

        if (!internalMessageInstance.save(flush: true)) {
            render(view: "bgedit", model: [internalMessageInstance: internalMessageInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), internalMessageInstance.id])
        redirect(action: "bgshow", id: internalMessageInstance.id)
    }

    def bgdelete() {
        def internalMessageInstance = InternalMessage.get(params.id)
        if (!internalMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            internalMessageInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }
	
	
		def index() {
			redirect(action: "list", params: params)
		}
	
		def list() {//鏀朵欢绠�
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def principal = SecurityUtils.subject?.principal
			def recipient = ShiroUser.findByUsername(principal)
			def internalMessage = recipient.recipient
//			[internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count()]
			
			if(!principal){//判断是否登录
				print("1")
				return [internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count()]
			}
			print("2")
			def user=ShiroUser.findByUsername(principal)
			if(!user?.btouxiang){//登录后，判断是否有头像
				def touxiangUrl = "touxiang/default_avatar.jpg" //默认头像
				print("3")
				return [internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count(),shiroUserInstance:touxiangUrl]
			}
			
			def tSize = "btouxiang" //选择头像的类型，这里是大头像
			print("4")
	//		println user.${tSize}  //D:\workspace-ggts\phonelibV2\web-app\images\touxiang\10\10\1385360315740_162.jpg
			
			def tIndex = user."${tSize}"?.indexOf("touxiang") //44,touxiang是第44位
			def touxiang =  user."${tSize}"?.substring(tIndex)//touxiang\10\10\1385360315740_162.jpg
			def touxiangUrl = touxiang?.replace('\\', '/');            //touxiang/10/10/1385360315740_162.jpg
			
			[internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count(),shiroUserInstance:touxiangUrl]
		}
		
		def senderList() {//鍙戜欢绠�
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def principal = SecurityUtils.subject?.principal
			def recipient = ShiroUser.findByUsername(principal)
			def internalMessage = recipient.sender
			render(view: "list" ,model:[internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count()])
		}
	
		def create() {
			[internalMessageInstance: new InternalMessage(params)]
		}
	
		def save() {
			
		  //  def internalMessageInstance = new InternalMessage(params)
			print (params)
			def internalMessage = params.message
			def recipient = ShiroUser.get(params.sender.id)
			def principal = SecurityUtils.subject?.principal
			def sender=ShiroUser.findByUsername(principal)
			Boolean statue = true
			def now = new Date()
			def internalMessageInstance = new InternalMessage(message:internalMessage,recipient:recipient,sender:sender,statue:statue,dateCreated:now)
			
			if (!internalMessageInstance.save(flush: true)) {
				render(view: "create", model: [internalMessageInstance: internalMessageInstance])
				return
			}
	
			flash.message = message(code: 'default.created.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), internalMessageInstance.id])
			redirect(action: "list")
		}
	
		def show() {
			def principal = SecurityUtils.subject?.principal
			def user=ShiroUser.findByUsername(principal)
			def internalMessageInstance = InternalMessage.get(params.id)
			if(internalMessageInstance?.recipient==user){
				internalMessageInstance.statue=false
			}
			internalMessageInstance.save()
			if (!internalMessageInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "list")
				return
			}
	
			[internalMessageInstance: internalMessageInstance]
		}
	
		def edit() {
			def internalMessageInstance = InternalMessage.get(params.id)
			if (!internalMessageInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "list")
				return
			}
	
			[internalMessageInstance: internalMessageInstance]
		}
	
		def update() {
			def internalMessageInstance = InternalMessage.get(params.id)
			if (!internalMessageInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "list")
				return
			}
	
			if (params.version) {
				def version = params.version.toLong()
				if (internalMessageInstance.version > version) {
					internalMessageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
							  [message(code: 'internalMessage.label', default: 'InternalMessage')] as Object[],
							  "Another user has updated this InternalMessage while you were editing")
					render(view: "edit", model: [internalMessageInstance: internalMessageInstance])
					return
				}
			}
	
			internalMessageInstance.properties = params
	
			if (!internalMessageInstance.save(flush: true)) {
				render(view: "edit", model: [internalMessageInstance: internalMessageInstance])
				return
			}
	
			flash.message = message(code: 'default.updated.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), internalMessageInstance.id])
			redirect(action: "show", id: internalMessageInstance.id)
		}
	
		def delete() {
			def internalMessageInstance = InternalMessage.get(params.id)
			if (!internalMessageInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				internalMessageInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		def borrowBookMessage(){
			 def borrowInstance = Borrow.get(params.id)
			 def internalMessage = "浣犲ソ锛屾垜鎯冲�闃呬綘鐨勩�${borrowInstance.book.title}銆嬭繖鏈功銆�"
			 def statue = true//鏈鐘舵�
			 def now = new Date()
			 def sender = borrowInstance.borrower
			 def recipient = borrowInstance.owner
			 def internalMessageInstance = new InternalMessage(message:internalMessage,recipient:recipient,sender:sender,borrow:borrowInstance,statue:statue,dateCreated:now)
			 if (!internalMessageInstance.save(flush: true)) {
				 render(view: "create", model: [internalMessageInstance: internalMessageInstance])
				 return
			 }
	 
			 flash.message = message(code: 'default.created.message', args: [message(code: 'internalMessage.label', default: 'InternalMessage'), internalMessageInstance.id])
			 redirect(action: "list")
		}
		
		def borrowBook(){
			def internalMessageInstance = InternalMessage.get(params.internalMessageId)
			internalMessageInstance?.statue = false
			def borrowStatus = params.borrowStatusId
			if(internalMessageInstance?.borrow?.borrowStatus!='2'){ //鍙厑璁镐竴娆℃搷浣�
				print("internalMessageIntance")
				if(borrowStatus=='1'){
					internalMessageInstance?.borrow?.borrowStatus = 3
					redirect(action: "list")
				}else{
					internalMessageInstance?.borrow?.borrowStatus = 0 //涓嶅悓鎰忓�闃�
					redirect(action: "list")
				}
			}else{
				redirect(action: "list")
			}
		}
		
		def borrowAck(){
			 def principal = SecurityUtils.subject?.principal
			 def userInstance=ShiroUser.findByUsername(principal)
			 def internalMessageInstance = InternalMessage.get(params.internalMessageId)
			 if(userInstance==internalMessageInstance.sender){
				 internalMessageInstance?.borrow?.borrowerAck = true
				 if(internalMessageInstance?.borrow?.borrowerAck&&internalMessageInstance?.borrow?.ownerAck){
					 internalMessageInstance?.borrow?.borrowStatus = 4 //姝ｅ湪鍊熼槄
					 internalMessageInstance?.borrow?.ownerAck = false
					 internalMessageInstance?.borrow?.borrowerAck = false
					 redirect(controller:"borrow",action:"ownerlist")
				 }else{
				 redirect(action: "list")
				 }
			 }
			 if(userInstance==internalMessageInstance.recipient){
				 internalMessageInstance?.borrow?.ownerAck = true
				 if(internalMessageInstance?.borrow?.borrowerAck&&internalMessageInstance?.borrow?.ownerAck){
					 internalMessageInstance?.borrow?.borrowStatus = 4 //姝ｅ湪鍊熼槄
					 internalMessageInstance?.borrow?.ownerAck = false
					 internalMessageInstance?.borrow?.borrowerAck = false
					 redirect(controller:"borrow",action:"ownerlist")
				 }
				 else{
				 redirect(action: "list")
				 }
			 }
		}
		
		def backAck(){
			print("1")
			def principal = SecurityUtils.subject?.principal
			def userInstance=ShiroUser.findByUsername(principal)
			def internalMessageInstance = InternalMessage.get(params.internalMessageId)
			print("2")
			def borrowInstance = internalMessageInstance?.borrow
			if(!internalMessageInstance){
				print("3")
				borrowInstance = Borrow.get(params.borrowId)
			}
			print("5")
			if(userInstance==borrowInstance.borrower){
				borrowInstance?.borrowerAck = true
				if(borrowInstance?.ownerAck&&borrowInstance?.borrowerAck){
					borrowInstance?.borrowStatus = 5//5宸插綊杩�
					print("111111111111111111111111")
					redirect(action: "list")
				}
				else{
				 redirect(action: "list")
				 }
			}
			if(userInstance==borrowInstance.owner){
				print("6")
				borrowInstance?.ownerAck = true
				print("7")
				if(borrowInstance?.ownerAck&&borrowInstance?.borrowerAck){
					borrowInstance?.borrowStatus = 5//5宸插綊杩�
					print("11111111111111111111111222222222221")
					redirect(action: "list")
				}
				else{
				 redirect(action: "list")
				 }
			}
		}
	}
	