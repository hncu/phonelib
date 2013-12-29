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
	
		def list() {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def principal = SecurityUtils.subject?.principal
			def recipient = ShiroUser.findByUsername(principal)
			println(recipient)
			def internalMessage = recipient.recipient
			[internalMessageInstanceList: internalMessage, internalMessageInstanceTotal: InternalMessage.count()]
		}
	
		def create() {
			[internalMessageInstance: new InternalMessage(params)]
		}
	
		def save() {
			
		  //  def internalMessageInstance = new InternalMessage(params)
			def internalMessage = params.message
			def recipient = ShiroUser.get(params.recipient.id)
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
			def internalMessageInstance = InternalMessage.get(params.id)
			internalMessageInstance.statue=false
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
	}
	