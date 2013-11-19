package phonelibv2
import org.apache.shiro.SecurityUtils

import org.springframework.dao.DataIntegrityViolationException

class OwnController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        //params.max = Math.min(params.max ? params.int('max') : 10, 100)
        //[ownInstanceList: Own.list(params), ownInstanceTotal: Own.count()]
		ShiroUser user=SecurityUtils.subject.getSession().getAttribute("ShiroUser")
		Own[] own=[]
		Book[] ownbook=[]
		own= Own.findAllByUser(user)
		ownbook=own.book
		[ownInstanceList:own,ownInstanceTotal:own.size(),ownBookInstanceList:ownbook]
    }

    def create() {
        [ownInstance: new Own(params)]
    }

    def save() {
        def ownInstance = new Own(params)
        if (!ownInstance.save(flush: true)) {
            render(view: "create", model: [ownInstance: ownInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'own.label', default: 'Own'), ownInstance.id])
        redirect(action: "show", id: ownInstance.id)
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
}
