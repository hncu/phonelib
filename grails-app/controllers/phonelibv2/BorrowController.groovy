package phonelibv2

import org.springframework.dao.DataIntegrityViolationException

class BorrowController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def borrowerlist() {
		def username=session.getAttribute("org.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEY")
		//	println(username)
		def shiroUserInstance = ShiroUser.findByUsername("${username}");
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def borrowInstance = shiroUserInstance.borrower
        render(view: "list", model:[borrowInstanceList: borrowInstance, categoryInstanceList: (borrowInstance.book).category,borrowInstanceTotal: Borrow.count()])
    }
	def ownerlist() {
		def username=session.getAttribute("org.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEY")
		//	println(username)
		def shiroUserInstance = ShiroUser.findByUsername("${username}");
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def borrowInstance = shiroUserInstance.owner
		render(view: "list", model:[borrowInstanceList: borrowInstance, categoryInstanceList: (borrowInstance.book).category,borrowInstanceTotal: Borrow.count()])
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
}
