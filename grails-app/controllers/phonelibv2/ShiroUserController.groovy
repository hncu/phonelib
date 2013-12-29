package phonelibv2

import org.springframework.dao.DataIntegrityViolationException

class ShiroUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [shiroUserInstanceList: ShiroUser.list(params), shiroUserInstanceTotal: ShiroUser.count()]
    }

    def create() {
        [shiroUserInstance: new ShiroUser(params)]
    }

    def save() {
        def shiroUserInstance = new ShiroUser(params)
        if (!shiroUserInstance.save(flush: true)) {
            render(view: "create", model: [shiroUserInstance: shiroUserInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])
        redirect(action: "show", id: shiroUserInstance.id)
    }

    def show() {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "list")
            return
        }

        [shiroUserInstance: shiroUserInstance]
    }

    def edit() {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "list")
            return
        }

        [shiroUserInstance: shiroUserInstance]
    }

    def update() {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (shiroUserInstance.version > version) {
                shiroUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'shiroUser.label', default: 'ShiroUser')] as Object[],
                          "Another user has updated this ShiroUser while you were editing")
                render(view: "edit", model: [shiroUserInstance: shiroUserInstance])
                return
            }
        }

        shiroUserInstance.properties = params

        if (!shiroUserInstance.save(flush: true)) {
            render(view: "edit", model: [shiroUserInstance: shiroUserInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])
        redirect(action: "show", id: shiroUserInstance.id)
    }

    def delete() {
        def shiroUserInstance = ShiroUser.get(params.id)
        if (!shiroUserInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "list")
            return
        }

        try {
            shiroUserInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
