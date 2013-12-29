package phonelibv2

import org.springframework.dao.DataIntegrityViolationException

class ShiroRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [shiroRoleInstanceList: ShiroRole.list(params), shiroRoleInstanceTotal: ShiroRole.count()]
    }

    def bgcreate() {
        [shiroRoleInstance: new ShiroRole(params)]
    }

    def bgsave() {
        def shiroRoleInstance = new ShiroRole(params)
        if (!shiroRoleInstance.save(flush: true)) {
            render(view: "bgcreate", model: [shiroRoleInstance: shiroRoleInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), shiroRoleInstance.id])
        redirect(action: "bgshow", id: shiroRoleInstance.id)
    }

    def bgshow() {
        def shiroRoleInstance = ShiroRole.get(params.id)
        if (!shiroRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bglist")
            return
        }

        [shiroRoleInstance: shiroRoleInstance]
    }

    def bgedit() {
        def shiroRoleInstance = ShiroRole.get(params.id)
        if (!shiroRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bglist")
            return
        }

        [shiroRoleInstance: shiroRoleInstance]
    }

    def bgupdate() {
        def shiroRoleInstance = ShiroRole.get(params.id)
        if (!shiroRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bglist")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (shiroRoleInstance.version > version) {
                shiroRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'shiroRole.label', default: 'ShiroRole')] as Object[],
                          "Another user has updated this ShiroRole while you were editing")
                render(view: "bgedit", model: [shiroRoleInstance: shiroRoleInstance])
                return
            }
        }

        shiroRoleInstance.properties = params

        if (!shiroRoleInstance.save(flush: true)) {
            render(view: "bgedit", model: [shiroRoleInstance: shiroRoleInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), shiroRoleInstance.id])
        redirect(action: "bgshow", id: shiroRoleInstance.id)
    }

    def bgdelete() {
        def shiroRoleInstance = ShiroRole.get(params.id)
        if (!shiroRoleInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            shiroRoleInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'shiroRole.label', default: 'ShiroRole'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }
	
		def scaffold = true
	}
	